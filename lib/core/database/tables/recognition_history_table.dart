import 'package:drift/drift.dart';
import 'foods_table.dart';

/// AI 음식 인식 이력을 저장하는 테이블
@DataClassName('RecognitionHistory')
class RecognitionHistories extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // 사용자 및 이미지 정보
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  TextColumn get imagePath => text()(); // 로컬 이미지 경로 또는 URL
  TextColumn get imageHash => text().nullable().withLength(max: 64)(); // 이미지 해시 (중복 방지)
  
  // 인식 결과 메타데이터
  DateTimeColumn get recognizedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get modelVersion => text().withLength(max: 20)(); // 사용된 AI 모델 버전
  RealColumn get processingTimeMs => real().nullable()(); // 처리 시간 (밀리초)
  
  // 인식 상태
  TextColumn get status => text().withDefault(const Constant('pending'))(); // 'pending', 'completed', 'failed', 'confirmed'
  TextColumn get errorMessage => text().nullable()(); // 오류 발생 시 메시지
  
  // 사용자 피드백
  BoolColumn get userConfirmed => boolean().withDefault(const Constant(false))(); // 사용자 확인 여부
  BoolColumn get userCorrected => boolean().withDefault(const Constant(false))(); // 사용자 수정 여부
  
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
}

/// 개별 음식 인식 결과를 저장하는 테이블 (한 이미지에서 여러 음식이 인식될 수 있음)
@DataClassName('RecognitionResult')
class RecognitionResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  IntColumn get historyId => integer().references(RecognitionHistories, #id, onDelete: KeyAction.cascade)();
  IntColumn get foodId => integer().nullable().references(Foods, #id)(); // 매칭된 음식 ID (null이면 매칭 실패)
  
  // AI 인식 결과
  TextColumn get detectedLabel => text()(); // AI가 인식한 라벨명
  RealColumn get confidence => real()(); // 신뢰도 (0.0 ~ 1.0)
  
  // 바운딩 박스 정보 (객체 탐지의 경우)
  RealColumn get boundingBoxX => real().nullable()(); // 정규화된 좌표 (0.0 ~ 1.0)
  RealColumn get boundingBoxY => real().nullable()();
  RealColumn get boundingBoxWidth => real().nullable()();
  RealColumn get boundingBoxHeight => real().nullable()();
  
  // 추정된 포션 정보
  RealColumn get estimatedGrams => real().nullable()(); // AI가 추정한 분량
  TextColumn get portionEstimateMethod => text().nullable()(); // 추정 방법 ('visual_size', 'default', 'manual')
  
  // 사용자 수정 사항
  IntColumn get correctedFoodId => integer().nullable().references(Foods, #id)(); // 사용자가 수정한 음식 ID
  RealColumn get correctedGrams => real().nullable()(); // 사용자가 수정한 분량
  TextColumn get userNotes => text().nullable().withLength(max: 300)(); // 사용자 메모
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
}

/// AI 인식 성능 분석을 위한 피드백 테이블
@DataClassName('RecognitionFeedback')
class RecognitionFeedbacks extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  IntColumn get resultId => integer().references(RecognitionResults, #id, onDelete: KeyAction.cascade)();
  TextColumn get userId => text().withLength(min: 1, max: 50)();
  
  // 피드백 타입
  TextColumn get feedbackType => text()(); // 'correct', 'incorrect', 'partially_correct', 'missing'
  IntColumn get correctnessScore => integer().nullable()(); // 1-5 점수
  
  // 구체적인 피드백
  TextColumn get correctFoodName => text().nullable()(); // 올바른 음식명 (사용자 제공)
  RealColumn get actualGrams => real().nullable()(); // 실제 분량 (사용자 제공)
  TextColumn get comments => text().nullable().withLength(max: 500)(); // 추가 의견
  
  // 이미지 품질 피드백
  IntColumn get imageQualityScore => integer().nullable()(); // 1-5 (1: 매우 나쁨, 5: 매우 좋음)
  TextColumn get imageIssues => text().nullable()(); // 'blurry', 'dark', 'cropped', 'multiple_foods' 등
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
}