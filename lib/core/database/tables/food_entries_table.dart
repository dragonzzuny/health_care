import 'package:drift/drift.dart';
import 'foods_table.dart';

/// 사용자의 식사 기록을 저장하는 테이블
@DataClassName('FoodEntry')
class FoodEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // 사용자 및 음식 정보
  TextColumn get userId => text().withLength(min: 1, max: 50)(); // 사용자 ID
  IntColumn get foodId => integer().references(Foods, #id)();
  
  // 식사 정보
  TextColumn get mealType => text().withLength(min: 1, max: 20)(); // 'breakfast', 'lunch', 'dinner', 'snack'
  DateTimeColumn get timestamp => dateTime()(); // 식사 시간
  
  // 포션 정보
  RealColumn get portionGrams => real()(); // 실제 섭취량 (g)
  TextColumn get portionDescription => text().nullable().withLength(max: 100)(); // '한 접시', '반 공기' 등
  
  // 계산된 영양 정보 (실제 섭취량 기준)
  RealColumn get totalCalories => real()();
  RealColumn get totalCarbs => real()();
  RealColumn get totalProtein => real()();
  RealColumn get totalFat => real()();
  RealColumn get totalFiber => real()();
  
  // 메타데이터
  TextColumn get notes => text().nullable().withLength(max: 500)(); // 사용자 메모
  TextColumn get imageUrl => text().nullable()(); // 음식 사진 URL
  BoolColumn get isFromAI => boolean().withDefault(const Constant(false))(); // AI 인식 여부
  IntColumn get recognitionHistoryId => integer().nullable()(); // AI 인식 이력 ID (별도 테이블)
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
}

/// 사용자의 즐겨찾는 포션을 저장하는 테이블
@DataClassName('FavoritePortion')
class FavoritePortions extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  IntColumn get foodId => integer().references(Foods, #id, onDelete: KeyAction.cascade)();
  
  RealColumn get portionGrams => real()(); // 즐겨찾는 분량 (g)
  TextColumn get nickname => text().nullable().withLength(max: 50)(); // 사용자 지정 별명
  IntColumn get usageCount => integer().withDefault(const Constant(1))(); // 사용 횟수
  DateTimeColumn get lastUsedAt => dateTime().withDefault(currentDateAndTime)(); // 마지막 사용 시간
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  
}

/// 일별 영양 목표 및 요약을 저장하는 테이블
@DataClassName('DailyNutritionSummary')
class DailyNutritionSummaries extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  DateTimeColumn get date => dateTime()(); // 날짜 (시간은 00:00:00으로 정규화)
  
  // 목표값
  RealColumn get calorieGoal => real()();
  RealColumn get carbsGoal => real()();
  RealColumn get proteinGoal => real()();
  RealColumn get fatGoal => real()();
  
  // 실제 섭취량 (계산된 값)
  RealColumn get totalCalories => real().withDefault(const Constant(0))();
  RealColumn get totalCarbs => real().withDefault(const Constant(0))();
  RealColumn get totalProtein => real().withDefault(const Constant(0))();
  RealColumn get totalFat => real().withDefault(const Constant(0))();
  RealColumn get totalFiber => real().withDefault(const Constant(0))();
  
  // 식사별 카운트
  IntColumn get breakfastCount => integer().withDefault(const Constant(0))();
  IntColumn get lunchCount => integer().withDefault(const Constant(0))();
  IntColumn get dinnerCount => integer().withDefault(const Constant(0))();
  IntColumn get snackCount => integer().withDefault(const Constant(0))();
  
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
}