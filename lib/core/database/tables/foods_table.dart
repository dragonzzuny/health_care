import 'package:drift/drift.dart';

/// 음식 정보를 저장하는 테이블
@DataClassName('Food')
class Foods extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // 음식 이름 (한국어/영어)
  TextColumn get nameKo => text().withLength(min: 1, max: 100)();
  TextColumn get nameEn => text().nullable().withLength(max: 100)();
  
  // 분류 및 브랜드
  TextColumn get category => text().withLength(min: 1, max: 50)(); // 한식, 중식, 양식, 일식 등
  TextColumn get subcategory => text().nullable().withLength(max: 50)(); // 국물류, 볶음류 등
  TextColumn get brand => text().nullable().withLength(max: 100)(); // 브랜드명 (가공식품용)
  
  // 영양 정보 (100g 당)
  RealColumn get kcalPer100g => real().withDefault(const Constant(0))();
  RealColumn get carbsPer100g => real().withDefault(const Constant(0))(); // 탄수화물 (g)
  RealColumn get proteinPer100g => real().withDefault(const Constant(0))(); // 단백질 (g)
  RealColumn get fatPer100g => real().withDefault(const Constant(0))(); // 지방 (g)
  RealColumn get fiberPer100g => real().withDefault(const Constant(0))(); // 식이섬유 (g)
  RealColumn get sugarPer100g => real().nullable()(); // 당류 (g)
  RealColumn get sodiumPer100g => real().nullable()(); // 나트륨 (mg)
  
  // 추가 정보
  TextColumn get description => text().nullable().withLength(max: 500)(); // 음식 설명
  TextColumn get ingredients => text().nullable().withLength(max: 1000)(); // 주요 재료
  TextColumn get allergens => text().nullable().withLength(max: 200)(); // 알레르기 유발 요소
  
  // 메타데이터
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))(); // 영양사 검증 여부
  BoolColumn get isActive => boolean().withDefault(const Constant(true))(); // 활성 상태
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
}

/// 음식 동의어/별명을 저장하는 테이블
@DataClassName('FoodSynonym')
class FoodSynonyms extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get foodId => integer().references(Foods, #id, onDelete: KeyAction.cascade)();
  TextColumn get synonym => text().withLength(min: 1, max: 100)(); // 동의어
  TextColumn get type => text().withLength(max: 20)(); // 'alias', 'brand', 'regional' 등
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
}

/// 일반적인 포션 정보를 저장하는 테이블
@DataClassName('CommonPortion')
class CommonPortions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get foodId => integer().references(Foods, #id, onDelete: KeyAction.cascade)();
  TextColumn get portionName => text().withLength(min: 1, max: 50)(); // '한 접시', '한 컵' 등
  RealColumn get gramAmount => real()(); // 그램 단위
  TextColumn get description => text().nullable().withLength(max: 200)(); // 설명
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))(); // 기본 포션 여부
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
}