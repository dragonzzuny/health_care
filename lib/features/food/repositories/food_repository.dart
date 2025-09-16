import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';

class FoodRepository {
  final AppDatabase _db;

  FoodRepository(this._db);

  /// 음식 검색 (이름으로)
  Future<List<Food>> searchFoods(String query, {int limit = 20}) async {
    if (query.trim().isEmpty) {
      return await (_db.select(_db.foods)
          ..where((f) => f.isActive.equals(true))
          ..orderBy([(f) => OrderingTerm(expression: f.nameKo)])
          ..limit(limit))
          .get();
    }

    final normalizedQuery = query.trim().toLowerCase();
    
    // 1. 직접적인 이름 매칭
    final directMatches = await (_db.select(_db.foods)
          ..where((f) => 
              f.nameKo.lower().contains(normalizedQuery) |
              f.nameEn.lower().contains(normalizedQuery))
          ..where((f) => f.isActive.equals(true))
          ..orderBy([(f) => OrderingTerm(expression: f.nameKo)])
          ..limit(limit ~/ 2))
        .get();

    // 2. 동의어를 통한 매칭
    final synonymQuery = _db.select(_db.foods).join([
      innerJoin(
        _db.foodSynonyms,
        _db.foodSynonyms.foodId.equalsExp(_db.foods.id),
      )
    ])
      ..where(_db.foodSynonyms.synonym.lower().contains(normalizedQuery))
      ..where(_db.foods.isActive.equals(true))
      ..orderBy([OrderingTerm(expression: _db.foods.nameKo)])
      ..limit(limit - directMatches.length);
    
    final synonymMatches = await synonymQuery
        .map((row) => row.readTable(_db.foods))
        .get();

    // 중복 제거 후 반환
    final allMatches = <Food>[];
    final seenIds = <int>{};
    
    for (final food in [...directMatches, ...synonymMatches]) {
      if (!seenIds.contains(food.id)) {
        seenIds.add(food.id);
        allMatches.add(food);
      }
    }
    
    return allMatches;
  }

  /// 카테고리별 음식 조회
  Future<List<Food>> getFoodsByCategory(String category, {int limit = 50}) async {
    return await (_db.select(_db.foods)
          ..where((f) => f.category.equals(category) & f.isActive.equals(true))
          ..orderBy([(f) => OrderingTerm(expression: f.nameKo)])
          ..limit(limit))
        .get();
  }

  /// ID로 음식 조회
  Future<Food?> getFoodById(int id) async {
    return await (_db.select(_db.foods)
          ..where((f) => f.id.equals(id) & f.isActive.equals(true)))
        .getSingleOrNull();
  }

  /// 음식 상세 정보 (동의어, 일반적인 포션 포함)
  Future<FoodDetail?> getFoodDetail(int foodId) async {
    final food = await getFoodById(foodId);
    if (food == null) return null;

    final synonyms = await (_db.select(_db.foodSynonyms)
          ..where((s) => s.foodId.equals(foodId)))
        .get();

    final commonPortions = await (_db.select(_db.commonPortions)
          ..where((p) => p.foodId.equals(foodId))
          ..orderBy([(p) => OrderingTerm(expression: p.isDefault, mode: OrderingMode.desc)]))
        .get();

    return FoodDetail(
      food: food,
      synonyms: synonyms,
      commonPortions: commonPortions,
    );
  }

  /// 인기 음식 조회 (사용 통계 기반)
  Future<List<Food>> getPopularFoods(String userId, {int limit = 10}) async {
    final query = _db.select(_db.foods).join([
      innerJoin(
        _db.userFoodStatistics,
        _db.userFoodStatistics.foodId.equalsExp(_db.foods.id) &
        _db.userFoodStatistics.foodType.equals('standard'),
      )
    ])
      ..where(_db.userFoodStatistics.userId.equals(userId))
      ..orderBy([OrderingTerm(expression: _db.userFoodStatistics.totalConsumptions, mode: OrderingMode.desc)])
      ..limit(limit);

    final results = await query.get();
    return results.map((row) => row.readTable(_db.foods)).toList();
  }

  /// 최근 섭취한 음식 조회
  Future<List<Food>> getRecentFoods(String userId, {int limit = 10}) async {
    final query = _db.select(_db.foods).join([
      innerJoin(
        _db.foodEntries,
        _db.foodEntries.foodId.equalsExp(_db.foods.id),
      )
    ])
      ..where(_db.foodEntries.userId.equals(userId))
      ..orderBy([OrderingTerm(expression: _db.foodEntries.timestamp, mode: OrderingMode.desc)])
      ..limit(limit);

    final results = await query.get();
    return results.map((row) => row.readTable(_db.foods)).toList();
  }

  /// 추천 음식 조회 (영양 목표 기반)
  Future<List<Food>> getRecommendedFoods(
    String userId, 
    String mealType, {
    int limit = 20
  }) async {
    // 사용자 선호도와 현재 일일 영양 상태를 고려한 추천 로직
    // 여기서는 간단히 카테고리별 다양성을 고려한 추천을 구현
    
    final categories = ['한식', '양식', '중식', '일식', '과일', '간식'];
    final recommendations = <Food>[];
    final itemsPerCategory = (limit / categories.length).ceil();

    for (final category in categories) {
      if (recommendations.length >= limit) break;
      
      final categoryFoods = await (_db.select(_db.foods)
            ..where((f) => f.category.equals(category) & f.isActive.equals(true))
            ..orderBy([(f) => OrderingTerm.random()])
            ..limit(itemsPerCategory))
          .get();
      
      recommendations.addAll(categoryFoods.take(limit - recommendations.length));
    }

    return recommendations;
  }

  /// 새 음식 등록
  Future<int> createFood(FoodsCompanion food) async {
    return await _db.into(_db.foods).insert(food);
  }

  /// 음식 정보 수정
  Future<bool> updateFood(int id, FoodsCompanion food) async {
    final updated = await (_db.update(_db.foods)
          ..where((f) => f.id.equals(id)))
        .write(food);
    return updated > 0;
  }

  /// 음식 삭제 (소프트 삭제)
  Future<bool> deleteFood(int id) async {
    final updated = await (_db.update(_db.foods)
          ..where((f) => f.id.equals(id)))
        .write(FoodsCompanion(
          isActive: const Value(false),
          updatedAt: Value(DateTime.now()),
        ));
    return updated > 0;
  }

  /// 동의어 추가
  Future<int> addSynonym(int foodId, String synonym, String type) async {
    return await _db.into(_db.foodSynonyms).insert(
      FoodSynonymsCompanion(
        foodId: Value(foodId),
        synonym: Value(synonym),
        type: Value(type),
      ),
    );
  }

  /// 일반적인 포션 추가
  Future<int> addCommonPortion(
    int foodId,
    String portionName,
    double gramAmount, {
    String? description,
    bool isDefault = false,
  }) async {
    return await _db.into(_db.commonPortions).insert(
      CommonPortionsCompanion(
        foodId: Value(foodId),
        portionName: Value(portionName),
        gramAmount: Value(gramAmount),
        description: Value(description),
        isDefault: Value(isDefault),
      ),
    );
  }

  /// 카테고리 목록 조회
  Future<List<String>> getCategories() async {
    final result = await _db.customSelect(
      'SELECT DISTINCT category FROM foods WHERE is_active = 1 ORDER BY category'
    ).get();
    
    return result.map((row) => row.data['category'] as String).toList();
  }

  /// 영양 성분 검색 (특정 영양소가 풍부한 음식)
  Future<List<Food>> getFoodsByNutrient(
    String nutrientType,
    double minAmount, {
    int limit = 20
  }) async {
    Expression<bool> condition;
    
    switch (nutrientType.toLowerCase()) {
      case 'protein':
        condition = _db.foods.proteinPer100g.isBiggerThanValue(minAmount);
        break;
      case 'fiber':
        condition = _db.foods.fiberPer100g.isBiggerThanValue(minAmount);
        break;
      case 'carbs':
        condition = _db.foods.carbsPer100g.isBiggerThanValue(minAmount);
        break;
      case 'fat':
        condition = _db.foods.fatPer100g.isBiggerThanValue(minAmount);
        break;
      default:
        throw ArgumentError('Unknown nutrient type: $nutrientType');
    }

    return await (_db.select(_db.foods)
          ..where((f) => condition & f.isActive.equals(true))
          ..orderBy([(f) => OrderingTerm(expression: f.nameKo)])
          ..limit(limit))
        .get();
  }
}

/// 음식 상세 정보를 담는 클래스
class FoodDetail {
  final Food food;
  final List<FoodSynonym> synonyms;
  final List<CommonPortion> commonPortions;

  const FoodDetail({
    required this.food,
    required this.synonyms,
    required this.commonPortions,
  });

  /// 기본 포션 조회
  CommonPortion? get defaultPortion {
    try {
      return commonPortions.firstWhere((p) => p.isDefault);
    } catch (e) {
      return commonPortions.isNotEmpty ? commonPortions.first : null;
    }
  }

  /// 모든 이름 (메인 이름 + 동의어)
  List<String> get allNames {
    final names = [food.nameKo];
    if (food.nameEn != null) names.add(food.nameEn!);
    names.addAll(synonyms.map((s) => s.synonym));
    return names;
  }
}