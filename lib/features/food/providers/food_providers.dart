import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/providers/database_providers.dart';
import '../../../core/mock/mock_food_data.dart';
import '../repositories/food_entry_repository.dart';
import '../repositories/food_repository.dart';

// 현재 사용자 ID (실제 구현 시에는 인증 시스템과 연동)
const String currentUserId = MockFoodData.userId;

/// 오늘의 식사 기록 프로바이더
final todayMealsProvider = FutureProvider<List<FoodEntryWithFood>>((ref) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final today = DateTime.now();
  return await repository.getFoodEntriesByDate(currentUserId, today);
});

/// 오늘의 영양 요약 프로바이더
final todayNutritionProvider = FutureProvider<DailyNutritionSummary?>((ref) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final today = DateTime.now();
  return await repository.getDailyNutritionSummary(currentUserId, today);
});

/// 영양 목표 달성률 프로바이더
final nutritionProgressProvider = Provider<Map<String, double>>((ref) {
  final nutritionAsync = ref.watch(todayNutritionProvider);
  
  return nutritionAsync.when(
    data: (nutrition) {
      if (nutrition == null) {
        return {
          'calories': 0.0,
          'protein': 0.0,
          'carbs': 0.0,
          'fat': 0.0,
          'fiber': 0.0,
        };
      }
      
      return {
        'calories': nutrition.calorieGoal > 0 ? (nutrition.totalCalories / nutrition.calorieGoal) : 0.0,
        'protein': nutrition.proteinGoal > 0 ? (nutrition.totalProtein / nutrition.proteinGoal) : 0.0,
        'carbs': nutrition.carbsGoal > 0 ? (nutrition.totalCarbs / nutrition.carbsGoal) : 0.0,
        'fat': nutrition.fatGoal > 0 ? (nutrition.totalFat / nutrition.fatGoal) : 0.0,
        'fiber': 25.0 > 0 ? (nutrition.totalFiber / 25.0) : 0.0, // 일반적인 섬유질 목표
      };
    },
    loading: () => {
      'calories': 0.0,
      'protein': 0.0,
      'carbs': 0.0,
      'fat': 0.0,
      'fiber': 0.0,
    },
    error: (_, __) => {
      'calories': 0.0,
      'protein': 0.0,
      'carbs': 0.0,
      'fat': 0.0,
      'fiber': 0.0,
    },
  );
});

/// 식사 타입별 오늘의 기록 프로바이더
final mealsByTypeProvider = FutureProvider.family<List<FoodEntryWithFood>, String>((ref, mealType) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final today = DateTime.now();
  return await repository.getFoodEntriesByMealType(currentUserId, today, mealType);
});

/// 인기 음식 프로바이더
final popularFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getPopularFoods(currentUserId, limit: 10);
});

/// 최근 섭취 음식 프로바이더
final recentFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getRecentFoods(currentUserId, limit: 8);
});

/// 즐겨찾는 포션 프로바이더
final myFavoritePortionsProvider = FutureProvider<List<FavoritePortionWithFood>>((ref) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  return await repository.getFavoritePortions(currentUserId, limit: 10);
});

/// 추천 음식 프로바이더 (식사 타입별)
final recommendedFoodsProvider = FutureProvider.family<List<Food>, String>((ref, mealType) async {
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getRecommendedFoods(currentUserId, mealType, limit: 6);
});

/// 음식 검색 상태 프로바이더
final foodSearchQueryProvider = StateProvider<String>((ref) => '');

/// 검색된 음식 목록 프로바이더
final searchedFoodsProvider = FutureProvider<List<Food>>((ref) async {
  final query = ref.watch(foodSearchQueryProvider);
  final searchNotifier = ref.watch(foodSearchProvider.notifier);
  
  if (query.trim().isEmpty) {
    return [];
  }
  
  await searchNotifier.searchFoods(query);
  final result = ref.watch(foodSearchProvider);
  
  return result.when(
    data: (foods) => foods,
    loading: () => [],
    error: (_, __) => [],
  );
});

/// 주간 영양 트렌드 프로바이더
final weeklyNutritionTrendProvider = FutureProvider<List<DailyNutritionSummary>>((ref) async {
  final repository = ref.watch(foodEntryRepositoryProvider);
  final now = DateTime.now();
  final weekStart = now.subtract(Duration(days: now.weekday % 7)); // 이번 주 일요일
  return await repository.getWeeklyNutritionSummary(currentUserId, weekStart);
});

/// 식사 추가 상태 프로바이더
class MealEntryNotifier extends StateNotifier<AsyncValue<void>> {
  MealEntryNotifier(this._repository) : super(const AsyncValue.data(null));
  
  final FoodEntryRepository _repository;
  
  /// 새 식사 기록 추가
  Future<void> addMealEntry({
    required int foodId,
    required double portionGrams,
    required String mealType,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final now = DateTime.now();
      // 음식 정보를 가져와서 영양소 계산
      final db = _repository.db;
      final selectedFood = await (db.select(db.foods)..where((f) => f.id.equals(foodId))).getSingle();
      
      final multiplier = portionGrams / 100.0;
      final totalCalories = selectedFood.kcalPer100g * multiplier;
      final totalCarbs = selectedFood.carbsPer100g * multiplier;
      final totalProtein = selectedFood.proteinPer100g * multiplier;
      final totalFat = selectedFood.fatPer100g * multiplier;
      final totalFiber = selectedFood.fiberPer100g * multiplier;
      
      await _repository.createFoodEntry(
        FoodEntriesCompanion.insert(
          userId: currentUserId,
          foodId: foodId,
          portionGrams: portionGrams,
          mealType: mealType,
          timestamp: now,
          totalCalories: totalCalories,
          totalCarbs: totalCarbs,
          totalProtein: totalProtein,
          totalFat: totalFat,
          totalFiber: totalFiber,
          notes: Value(notes),
        ),
      );
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  /// 식사 기록 수정
  Future<void> updateMealEntry({
    required int entryId,
    required double portionGrams,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.updateFoodEntry(
        entryId,
        FoodEntriesCompanion(
          portionGrams: Value(portionGrams),
          notes: Value(notes),
        ),
      );
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
  
  /// 식사 기록 삭제
  Future<void> deleteMealEntry(int entryId) async {
    state = const AsyncValue.loading();
    
    try {
      await _repository.deleteFoodEntry(entryId);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

/// 식사 추가 상태 프로바이더
final mealEntryProvider = StateNotifierProvider<MealEntryNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(foodEntryRepositoryProvider);
  return MealEntryNotifier(repository);
});

/// 선택된 음식 상세정보 프로바이더
final selectedFoodDetailProvider = FutureProvider.family<FoodDetail?, int>((ref, foodId) async {
  if (foodId <= 0) return null;
  
  final repository = ref.watch(foodRepositoryProvider);
  return await repository.getFoodDetail(foodId);
});

/// 일일 칼로리 잔여량 프로바이더
final remainingCaloriesProvider = Provider<double>((ref) {
  final nutritionAsync = ref.watch(todayNutritionProvider);
  
  return nutritionAsync.when(
    data: (nutrition) {
      if (nutrition == null) return 1800.0; // 기본 목표 칼로리
      return (nutrition.calorieGoal - nutrition.totalCalories).clamp(0.0, double.infinity);
    },
    loading: () => 1800.0,
    error: (_, __) => 1800.0,
  );
});

/// 오늘의 식사 완성도 프로바이더 (아침, 점심, 저녁 섭취 여부)
final mealCompletenessProvider = Provider<Map<String, bool>>((ref) {
  final mealsAsync = ref.watch(todayMealsProvider);
  
  return mealsAsync.when(
    data: (meals) {
      final mealTypes = meals.map((m) => m.entry.mealType).toSet();
      return {
        'breakfast': mealTypes.contains('breakfast'),
        'lunch': mealTypes.contains('lunch'),
        'dinner': mealTypes.contains('dinner'),
        'snack': mealTypes.contains('snack'),
      };
    },
    loading: () => {
      'breakfast': false,
      'lunch': false,
      'dinner': false,
      'snack': false,
    },
    error: (_, __) => {
      'breakfast': false,
      'lunch': false,
      'dinner': false,
      'snack': false,
    },
  );
});

/// 영양소별 일일 섭취량 프로바이더
final dailyNutrientIntakeProvider = Provider<Map<String, double>>((ref) {
  final nutritionAsync = ref.watch(todayNutritionProvider);
  
  return nutritionAsync.when(
    data: (nutrition) {
      if (nutrition == null) {
        return {
          'calories': 0.0,
          'protein': 0.0,
          'carbs': 0.0,
          'fat': 0.0,
          'fiber': 0.0,
        };
      }
      
      return {
        'calories': nutrition.totalCalories,
        'protein': nutrition.totalProtein,
        'carbs': nutrition.totalCarbs,
        'fat': nutrition.totalFat,
        'fiber': nutrition.totalFiber,
      };
    },
    loading: () => {
      'calories': 0.0,
      'protein': 0.0,
      'carbs': 0.0,
      'fat': 0.0,
      'fiber': 0.0,
    },
    error: (_, __) => {
      'calories': 0.0,
      'protein': 0.0,
      'carbs': 0.0,
      'fat': 0.0,
      'fiber': 0.0,
    },
  );
});

/// 식사 시간대별 분포 프로바이더
final mealTimeDistributionProvider = Provider<Map<String, int>>((ref) {
  final mealsAsync = ref.watch(todayMealsProvider);
  
  return mealsAsync.when(
    data: (meals) {
      final distribution = <String, int>{
        'breakfast': 0,
        'lunch': 0,
        'dinner': 0,
        'snack': 0,
      };
      
      for (final meal in meals) {
        distribution[meal.entry.mealType] = 
            (distribution[meal.entry.mealType] ?? 0) + 1;
      }
      
      return distribution;
    },
    loading: () => {
      'breakfast': 0,
      'lunch': 0,
      'dinner': 0,
      'snack': 0,
    },
    error: (_, __) => {
      'breakfast': 0,
      'lunch': 0,
      'dinner': 0,
      'snack': 0,
    },
  );
});