import 'dart:developer' as developer;
import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import 'dart:io';

class RecognitionRepository {
  final AppDatabase _db;

  RecognitionRepository(this._db);

  /// AI 인식 이력 생성
  Future<int> createRecognitionHistory({
    required String userId,
    required String imagePath,
    required String modelVersion,
    String? imageHash,
    double? processingTimeMs,
  }) async {
    return await _db.into(_db.recognitionHistories).insert(
          RecognitionHistoriesCompanion(
            userId: Value(userId),
            imagePath: Value(imagePath),
            imageHash: Value(imageHash),
            modelVersion: Value(modelVersion),
            processingTimeMs: Value(processingTimeMs),
            status: const Value('pending'),
          ),
        );
  }

  /// 인식 결과 추가
  Future<int> addRecognitionResult({
    required int historyId,
    required String detectedLabel,
    required double confidence,
    int? foodId,
    double? boundingBoxX,
    double? boundingBoxY,
    double? boundingBoxWidth,
    double? boundingBoxHeight,
    double? estimatedGrams,
    String? portionEstimateMethod,
  }) async {
    return await _db.into(_db.recognitionResults).insert(
          RecognitionResultsCompanion(
            historyId: Value(historyId),
            detectedLabel: Value(detectedLabel),
            confidence: Value(confidence),
            foodId: Value(foodId),
            boundingBoxX: Value(boundingBoxX),
            boundingBoxY: Value(boundingBoxY),
            boundingBoxWidth: Value(boundingBoxWidth),
            boundingBoxHeight: Value(boundingBoxHeight),
            estimatedGrams: Value(estimatedGrams),
            portionEstimateMethod: Value(portionEstimateMethod),
          ),
        );
  }

  /// 인식 이력 상태 업데이트
  Future<bool> updateRecognitionStatus(
    int historyId,
    String status, {
    String? errorMessage,
  }) async {
    final updated = await (_db.update(_db.recognitionHistories)
          ..where((rh) => rh.id.equals(historyId)))
        .write(RecognitionHistoriesCompanion(
      status: Value(status),
      errorMessage: Value(errorMessage),
      updatedAt: Value(DateTime.now()),
    ));
    return updated > 0;
  }

  /// 사용자 확인/수정 처리
  Future<bool> confirmRecognition(
    int historyId, {
    bool userConfirmed = true,
    bool userCorrected = false,
    Map<int, RecognitionCorrection>? corrections,
  }) async {
    return await _db.transaction(() async {
      // 이력 상태 업데이트
      await (_db.update(_db.recognitionHistories)
            ..where((rh) => rh.id.equals(historyId)))
          .write(RecognitionHistoriesCompanion(
        userConfirmed: Value(userConfirmed),
        userCorrected: Value(userCorrected),
        status: const Value('confirmed'),
        updatedAt: Value(DateTime.now()),
      ));

      // 수정 사항이 있다면 적용
      if (corrections != null && corrections.isNotEmpty) {
        for (final entry in corrections.entries) {
          final resultId = entry.key;
          final correction = entry.value;

          await (_db.update(_db.recognitionResults)
                ..where((rr) => rr.id.equals(resultId)))
              .write(RecognitionResultsCompanion(
            correctedFoodId: Value(correction.correctedFoodId),
            correctedGrams: Value(correction.correctedGrams),
            userNotes: Value(correction.userNotes),
          ));
        }
      }

      return true;
    });
  }

  /// 사용자별 인식 이력 조회
  Future<List<RecognitionHistoryWithResults>> getRecognitionHistories(
    String userId, {
    int limit = 50,
    int offset = 0,
  }) async {
    // 먼저 이력들을 조회
    final histories = await (_db.select(_db.recognitionHistories)
          ..where((rh) => rh.userId.equals(userId))
          ..orderBy([
            (rh) => OrderingTerm(
                expression: rh.recognizedAt, mode: OrderingMode.desc)
          ])
          ..limit(limit, offset: offset))
        .get();

    // 각 이력에 대한 결과들을 조회
    final result = <RecognitionHistoryWithResults>[];
    for (final history in histories) {
      final results = await getRecognitionResults(history.id);
      result.add(RecognitionHistoryWithResults(
        history: history,
        results: results,
      ));
    }

    return result;
  }

  /// 특정 이력의 인식 결과 조회
  Future<List<RecognitionResultWithFood>> getRecognitionResults(
      int historyId) async {
    final query = _db.select(_db.recognitionResults).join([
      leftOuterJoin(
        _db.foods,
        _db.foods.id.equalsExp(_db.recognitionResults.foodId),
      )
    ])
      ..where(_db.recognitionResults.historyId.equals(historyId))
      ..orderBy([
        OrderingTerm(
            expression: _db.recognitionResults.confidence,
            mode: OrderingMode.desc)
      ]);

    final results = await query.get();
    return results
        .map((row) => RecognitionResultWithFood(
              result: row.readTable(_db.recognitionResults),
              food: row.readTableOrNull(_db.foods),
            ))
        .toList();
  }

  /// 특정 날짜의 인식 이력 조회
  Future<List<RecognitionHistoryWithResults>> getRecognitionHistoriesByDate(
    String userId,
    DateTime date,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final histories = await (_db.select(_db.recognitionHistories)
          ..where((rh) =>
              rh.userId.equals(userId) &
              rh.recognizedAt.isBiggerOrEqualValue(startOfDay) &
              rh.recognizedAt.isSmallerThanValue(endOfDay))
          ..orderBy([
            (rh) => OrderingTerm(
                expression: rh.recognizedAt, mode: OrderingMode.desc)
          ]))
        .get();

    final result = <RecognitionHistoryWithResults>[];
    for (final history in histories) {
      final results = await getRecognitionResults(history.id);
      result.add(RecognitionHistoryWithResults(
        history: history,
        results: results,
      ));
    }

    return result;
  }

  /// 인식 피드백 추가
  Future<int> addRecognitionFeedback({
    required int resultId,
    required String userId,
    required String feedbackType,
    int? correctnessScore,
    String? correctFoodName,
    double? actualGrams,
    String? comments,
    int? imageQualityScore,
    String? imageIssues,
  }) async {
    return await _db.into(_db.recognitionFeedbacks).insert(
          RecognitionFeedbacksCompanion(
            resultId: Value(resultId),
            userId: Value(userId),
            feedbackType: Value(feedbackType),
            correctnessScore: Value(correctnessScore),
            correctFoodName: Value(correctFoodName),
            actualGrams: Value(actualGrams),
            comments: Value(comments),
            imageQualityScore: Value(imageQualityScore),
            imageIssues: Value(imageIssues),
          ),
        );
  }

  /// 인식 성능 통계 조회
  Future<RecognitionStatistics> getRecognitionStatistics(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = '''
      SELECT 
        COUNT(*) as total_recognitions,
        AVG(rr.confidence) as avg_confidence,
        SUM(CASE WHEN rh.user_confirmed = 1 THEN 1 ELSE 0 END) as confirmed_count,
        SUM(CASE WHEN rh.user_corrected = 1 THEN 1 ELSE 0 END) as corrected_count,
        AVG(rh.processing_time_ms) as avg_processing_time,
        SUM(CASE WHEN rh.status = 'completed' THEN 1 ELSE 0 END) as success_count,
        SUM(CASE WHEN rh.status = 'failed' THEN 1 ELSE 0 END) as failed_count
      FROM recognition_histories rh
      LEFT JOIN recognition_results rr ON rh.id = rr.history_id
      WHERE rh.user_id = ?
    ''';

    final params = <dynamic>[userId];

    if (startDate != null) {
      query += ' AND rh.recognized_at >= ?';
      params.add(startDate);
    }

    if (endDate != null) {
      query += ' AND rh.recognized_at <= ?';
      params.add(endDate);
    }

    final result = await _db
        .customSelect(query,
            variables:
                params.map((p) => Variable.withString(p.toString())).toList())
        .getSingle();

    return RecognitionStatistics(
      totalRecognitions: result.data['total_recognitions'] as int,
      averageConfidence:
          (result.data['avg_confidence'] as num?)?.toDouble() ?? 0,
      confirmedCount: result.data['confirmed_count'] as int,
      correctedCount: result.data['corrected_count'] as int,
      averageProcessingTime:
          (result.data['avg_processing_time'] as num?)?.toDouble(),
      successCount: result.data['success_count'] as int,
      failedCount: result.data['failed_count'] as int,
    );
  }

  /// 자주 인식되는 음식 TOP 조회
  Future<List<FoodRecognitionFrequency>> getTopRecognizedFoods(
    String userId, {
    int limit = 10,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = '''
      SELECT 
        f.name_ko as food_name,
        f.id as food_id,
        COUNT(*) as recognition_count,
        AVG(rr.confidence) as avg_confidence
      FROM recognition_results rr
      JOIN recognition_histories rh ON rr.history_id = rh.id
      LEFT JOIN foods f ON rr.food_id = f.id
      WHERE rh.user_id = ? AND rr.food_id IS NOT NULL
    ''';

    final params = <dynamic>[userId];

    if (startDate != null) {
      query += ' AND rh.recognized_at >= ?';
      params.add(startDate);
    }

    if (endDate != null) {
      query += ' AND rh.recognized_at <= ?';
      params.add(endDate);
    }

    query += '''
      GROUP BY f.id, f.name_ko
      ORDER BY recognition_count DESC
      LIMIT ?
    ''';
    params.add(limit);

    final results = await _db
        .customSelect(query,
            variables:
                params.map((p) => Variable.withString(p.toString())).toList())
        .get();

    return results
        .map((row) => FoodRecognitionFrequency(
              foodId: row.data['food_id'] as int,
              foodName: row.data['food_name'] as String,
              recognitionCount: row.data['recognition_count'] as int,
              averageConfidence: (row.data['avg_confidence'] as num).toDouble(),
            ))
        .toList();
  }

  /// 이미지 파일 정리 (오래된 이미지 삭제)
  Future<int> cleanupOldImages({int daysToKeep = 30}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: daysToKeep));

    final oldHistories = await (_db.select(_db.recognitionHistories)
          ..where((rh) =>
              rh.recognizedAt.isSmallerThanValue(cutoffDate) &
              rh.status.equals('completed')))
        .get();

    int deletedCount = 0;
    for (final history in oldHistories) {
      try {
        final file = File(history.imagePath);
        if (await file.exists()) {
          await file.delete();
          deletedCount++;
        }
      } catch (e) {
        // 파일 삭제 실패는 무시하고 계속 진행
        developer.log('Failed to delete image file: ${history.imagePath}, error: $e');
      }
    }

    return deletedCount;
  }

  /// 중복 이미지 체크 (해시 기반)
  Future<RecognitionHistory?> findDuplicateImage(String imageHash) async {
    return await (_db.select(_db.recognitionHistories)
          ..where((rh) => rh.imageHash.equals(imageHash))
          ..orderBy([
            (rh) => OrderingTerm(
                expression: rh.recognizedAt, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .getSingleOrNull();
  }
}

/// 인식 수정 정보를 담는 클래스
class RecognitionCorrection {
  final int? correctedFoodId;
  final double? correctedGrams;
  final String? userNotes;

  const RecognitionCorrection({
    this.correctedFoodId,
    this.correctedGrams,
    this.userNotes,
  });
}

/// 인식 이력과 결과를 함께 담는 클래스
class RecognitionHistoryWithResults {
  final RecognitionHistory history;
  final List<RecognitionResultWithFood> results;

  const RecognitionHistoryWithResults({
    required this.history,
    required this.results,
  });

  /// 가장 높은 신뢰도의 결과
  RecognitionResultWithFood? get topResult {
    if (results.isEmpty) return null;
    return results
        .reduce((a, b) => a.result.confidence > b.result.confidence ? a : b);
  }

  /// 확정된 결과들 (사용자가 수정했거나 확인한 것들)
  List<RecognitionResultWithFood> get confirmedResults {
    return results
        .where((r) =>
            r.result.correctedFoodId != null ||
            (history.userConfirmed && r.result.foodId != null))
        .toList();
  }
}

/// 인식 결과와 음식 정보를 함께 담는 클래스
class RecognitionResultWithFood {
  final RecognitionResult result;
  final Food? food;

  const RecognitionResultWithFood({
    required this.result,
    this.food,
  });

  /// 최종 음식 ID (수정된 것이 있으면 수정된 것, 없으면 원본)
  int? get finalFoodId => result.correctedFoodId ?? result.foodId;

  /// 최종 분량 (수정된 것이 있으면 수정된 것, 없으면 추정값)
  double? get finalGrams => result.correctedGrams ?? result.estimatedGrams;

  /// 사용자가 수정했는지 여부
  bool get isUserCorrected =>
      result.correctedFoodId != null || result.correctedGrams != null;
}

/// 인식 성능 통계 클래스
class RecognitionStatistics {
  final int totalRecognitions;
  final double averageConfidence;
  final int confirmedCount;
  final int correctedCount;
  final double? averageProcessingTime;
  final int successCount;
  final int failedCount;

  const RecognitionStatistics({
    required this.totalRecognitions,
    required this.averageConfidence,
    required this.confirmedCount,
    required this.correctedCount,
    this.averageProcessingTime,
    required this.successCount,
    required this.failedCount,
  });

  /// 성공률
  double get successRate =>
      totalRecognitions > 0 ? successCount / totalRecognitions : 0;

  /// 확인률
  double get confirmationRate =>
      totalRecognitions > 0 ? confirmedCount / totalRecognitions : 0;

  /// 수정률
  double get correctionRate =>
      confirmedCount > 0 ? correctedCount / confirmedCount : 0;
}

/// 음식별 인식 빈도 클래스
class FoodRecognitionFrequency {
  final int foodId;
  final String foodName;
  final int recognitionCount;
  final double averageConfidence;

  const FoodRecognitionFrequency({
    required this.foodId,
    required this.foodName,
    required this.recognitionCount,
    required this.averageConfidence,
  });
}
