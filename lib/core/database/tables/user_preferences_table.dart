import 'package:drift/drift.dart';

/// 사용자 영양 목표 및 설정을 저장하는 테이블
@DataClassName('UserPreference')
class UserPreferences extends Table {
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  
  // 일일 영양 목표
  RealColumn get dailyCalorieGoal => real().withDefault(const Constant(2000))(); // kcal
  RealColumn get dailyCarbsGoal => real().withDefault(const Constant(250))(); // g
  RealColumn get dailyProteinGoal => real().withDefault(const Constant(50))(); // g
  RealColumn get dailyFatGoal => real().withDefault(const Constant(65))(); // g
  RealColumn get dailyFiberGoal => real().withDefault(const Constant(25))(); // g
  
  // 매크로 비율 (퍼센트)
  RealColumn get carbsRatio => real().withDefault(const Constant(50))(); // 50%
  RealColumn get proteinRatio => real().withDefault(const Constant(20))(); // 20%
  RealColumn get fatRatio => real().withDefault(const Constant(30))(); // 30%
  
  // 사용자 기본 정보 (목표 계산용)
  IntColumn get age => integer().nullable()();
  TextColumn get gender => text().nullable().withLength(max: 10)(); // 'male', 'female', 'other'
  RealColumn get height => real().nullable()(); // cm
  RealColumn get weight => real().nullable()(); // kg
  TextColumn get activityLevel => text().withDefault(const Constant('moderate'))(); // 'sedentary', 'light', 'moderate', 'active', 'very_active'
  TextColumn get goal => text().withDefault(const Constant('maintain'))(); // 'lose', 'maintain', 'gain'
  
  // 식단 제한사항
  TextColumn get dietaryRestrictions => text().nullable()(); // JSON 형태로 저장 ['vegetarian', 'gluten_free', 'dairy_free']
  TextColumn get allergies => text().nullable()(); // JSON 형태로 저장
  TextColumn get dislikedFoods => text().nullable()(); // JSON 형태로 저장
  
  // AI 설정
  BoolColumn get aiSuggestionsEnabled => boolean().withDefault(const Constant(true))();
  RealColumn get aiConfidenceThreshold => real().withDefault(const Constant(0.7))(); // AI 인식 최소 신뢰도
  BoolColumn get autoSaveRecognitions => boolean().withDefault(const Constant(false))(); // 자동 저장 여부
  
  // 알림 설정
  BoolColumn get mealRemindersEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get breakfastReminderTime => text().nullable()(); // 'HH:mm' 형태
  TextColumn get lunchReminderTime => text().nullable()();
  TextColumn get dinnerReminderTime => text().nullable()();
  BoolColumn get nutritionGoalNotifications => boolean().withDefault(const Constant(true))();
  
  // 메타데이터
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {userId};
  
}

/// 사용자별 커스텀 음식 정보를 저장하는 테이블
@DataClassName('CustomFood')
class CustomFoods extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  TextColumn get name => text().withLength(min: 1, max: 100)(); // 커스텀 음식명
  TextColumn get description => text().nullable().withLength(max: 300)();
  
  // 영양 정보 (100g 당)
  RealColumn get kcalPer100g => real()();
  RealColumn get carbsPer100g => real().withDefault(const Constant(0))();
  RealColumn get proteinPer100g => real().withDefault(const Constant(0))();
  RealColumn get fatPer100g => real().withDefault(const Constant(0))();
  RealColumn get fiberPer100g => real().withDefault(const Constant(0))();
  
  // 레시피 정보
  TextColumn get recipe => text().nullable()(); // 간단한 레시피
  TextColumn get ingredients => text().nullable()(); // 재료 목록
  
  // 사용 통계
  IntColumn get usageCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUsedAt => dateTime().nullable()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
}

/// 사용자의 식단 패턴을 분석하기 위한 통계 테이블
@DataClassName('UserFoodStatistic')
class UserFoodStatistics extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  IntColumn get foodId => integer()(); // Foods 또는 CustomFoods의 ID
  TextColumn get foodType => text()(); // 'standard' 또는 'custom'
  
  // 통계 데이터
  IntColumn get totalConsumptions => integer().withDefault(const Constant(0))(); // 총 섭취 횟수
  RealColumn get averagePortionGrams => real().withDefault(const Constant(0))(); // 평균 섭취량
  DateTimeColumn get firstConsumedAt => dateTime().nullable()(); // 첫 섭취 시간
  DateTimeColumn get lastConsumedAt => dateTime().nullable()(); // 마지막 섭취 시간
  
  // 선호도 점수 (알고리즘으로 계산)
  RealColumn get preferenceScore => real().withDefault(const Constant(0))(); // 0.0 ~ 1.0
  TextColumn get preferredMealTypes => text().nullable()(); // JSON: ['breakfast', 'dinner']
  
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
}