import 'package:drift/drift.dart';

/// 일일 활동 요약 테이블
@DataClassName('DailyActivity')
class DailyActivities extends Table {
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  DateTimeColumn get date => dateTime()(); // 날짜 (시간은 자정으로 정규화)
  
  // 걸음 수 관련
  IntColumn get steps => integer().withDefault(const Constant(0))();
  IntColumn get distanceMeters => integer().withDefault(const Constant(0))(); // 이동 거리 (미터)
  
  // 칼로리
  IntColumn get caloriesBurned => integer().withDefault(const Constant(0))(); // 소모 칼로리
  
  // 활동 시간 (분)
  IntColumn get activeMinutes => integer().withDefault(const Constant(0))(); // 중간+고강도 활동 시간
  IntColumn get lightActivityMinutes => integer().withDefault(const Constant(0))(); // 가벼운 활동
  IntColumn get moderateActivityMinutes => integer().withDefault(const Constant(0))(); // 중간 강도
  IntColumn get vigorousActivityMinutes => integer().withDefault(const Constant(0))(); // 고강도
  IntColumn get sedentaryMinutes => integer().withDefault(const Constant(0))(); // 앉아있는 시간
  
  // 심박수
  IntColumn get heartRateAverage => integer().nullable()(); // 평균 심박수
  IntColumn get heartRateMax => integer().nullable()(); // 최고 심박수
  
  // 메타데이터
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {userId, date}; // 복합 키
}

/// 운동 세션 테이블
@DataClassName('WorkoutSession')
class WorkoutSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  
  // 운동 정보
  TextColumn get type => text()(); // 'running', 'cycling', 'strength_training', 'swimming', etc.
  TextColumn get name => text()(); // 운동 이름 (예: '조깅', '웨이트 트레이닝')
  DateTimeColumn get startTime => dateTime()(); // 운동 시작 시간
  DateTimeColumn get endTime => dateTime()(); // 운동 종료 시간
  IntColumn get duration => integer()(); // 운동 시간 (분)
  
  // 운동 강도 및 결과
  TextColumn get intensity => text().withDefault(const Constant('moderate'))(); // 'low', 'moderate', 'high'
  IntColumn get caloriesBurned => integer().withDefault(const Constant(0))(); // 소모 칼로리
  RealColumn get distance => real().nullable()(); // 이동 거리 (km, 달리기/자전거 등)
  
  // 추가 정보
  TextColumn get notes => text().nullable()(); // 운동 메모
  
  // 메타데이터
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// 활동 목표 테이블
@DataClassName('ActivityGoal')
class ActivityGoals extends Table {
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  
  // 일일 목표
  IntColumn get stepsGoal => integer().withDefault(const Constant(10000))();
  IntColumn get caloriesBurnedGoal => integer().withDefault(const Constant(400))();
  IntColumn get activeMinutesGoal => integer().withDefault(const Constant(60))(); // 중간+고강도 활동
  IntColumn get distanceGoal => integer().withDefault(const Constant(7500))(); // 미터
  
  // 주간 목표
  IntColumn get workoutsPerWeekGoal => integer().withDefault(const Constant(3))();
  
  // 메타데이터
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {userId}; // 사용자당 하나의 목표 설정
}

/// 체중 기록 테이블
@DataClassName('WeightRecord')
class WeightRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  
  DateTimeColumn get date => dateTime()(); // 측정 날짜/시간
  RealColumn get weight => real()(); // 체중 (kg)
  RealColumn get bodyFatPercentage => real().nullable()(); // 체지방률 (%)
  RealColumn get muscleMass => real().nullable()(); // 근육량 (kg)
  RealColumn get visceralFat => real().nullable()(); // 내장지방
  RealColumn get bmi => real().nullable()(); // BMI (자동 계산 가능)
  
  TextColumn get notes => text().nullable()(); // 메모
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}