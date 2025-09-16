import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/body_composition_data.dart';

class BodyCompositionService {
  static final BodyCompositionService _instance = BodyCompositionService._internal();
  factory BodyCompositionService() => _instance;
  BodyCompositionService._internal();

  static const String _bodyCompositionsKey = 'body_compositions';
  static const String _bodyMetricsKey = 'body_metrics';
  static const String _userBodyProfileKey = 'user_body_profile';
  static const String _inBodyResultsKey = 'inbody_results';

  // 체성분 측정 기록 저장
  Future<void> saveBodyComposition(BodyComposition composition) async {
    final prefs = await SharedPreferences.getInstance();
    final compositions = await getBodyCompositions();
    compositions.add(composition);
    compositions.sort((a, b) => b.measurementDate.compareTo(a.measurementDate));

    final compositionsJson = compositions.map((c) => c.toJson()).toList();
    await prefs.setString(_bodyCompositionsKey, json.encode(compositionsJson));
  }

  // 모든 체성분 기록 가져오기
  Future<List<BodyComposition>> getBodyCompositions() async {
    final prefs = await SharedPreferences.getInstance();
    final compositionsJson = prefs.getString(_bodyCompositionsKey);

    if (compositionsJson == null) return [];

    final compositionsList = json.decode(compositionsJson) as List;
    return compositionsList.map((c) => BodyComposition.fromJson(c)).toList();
  }

  // 최신 체성분 기록 가져오기
  Future<BodyComposition?> getLatestBodyComposition() async {
    final compositions = await getBodyCompositions();
    return compositions.isNotEmpty ? compositions.first : null;
  }

  // 특정 기간의 체성분 기록 가져오기
  Future<List<BodyComposition>> getBodyCompositionsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final allCompositions = await getBodyCompositions();
    return allCompositions.where((composition) {
      return composition.measurementDate.isAfter(startDate) &&
             composition.measurementDate.isBefore(endDate);
    }).toList();
  }

  // 체성분 통계 생성
  Future<BodyCompositionStats> getBodyCompositionStats({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    startDate ??= DateTime.now().subtract(const Duration(days: 90));
    endDate ??= DateTime.now();

    final compositions = await getBodyCompositionsInRange(
      startDate: startDate,
      endDate: endDate,
    );

    if (compositions.isEmpty) {
      return BodyCompositionStats(
        measurements: [],
        startDate: startDate,
        endDate: endDate,
        averageWeight: 0.0,
        averageBodyFat: 0.0,
        averageMuscleMass: 0.0,
        weightChange: 0.0,
        bodyFatChange: 0.0,
        muscleMassChange: 0.0,
        latestMeasurement: null,
        firstMeasurement: null,
      );
    }

    final averageWeight = compositions.fold<double>(0.0, (sum, c) => sum + c.weight) / compositions.length;
    final averageBodyFat = compositions.fold<double>(0.0, (sum, c) => sum + c.bodyFatPercentage) / compositions.length;
    final averageMuscleMass = compositions.fold<double>(0.0, (sum, c) => sum + c.muscleMass) / compositions.length;

    final latest = compositions.first;
    final first = compositions.last;

    return BodyCompositionStats(
      measurements: compositions,
      startDate: startDate,
      endDate: endDate,
      averageWeight: averageWeight,
      averageBodyFat: averageBodyFat,
      averageMuscleMass: averageMuscleMass,
      weightChange: latest.weight - first.weight,
      bodyFatChange: latest.bodyFatPercentage - first.bodyFatPercentage,
      muscleMassChange: latest.muscleMass - first.muscleMass,
      latestMeasurement: latest,
      firstMeasurement: first,
    );
  }

  // 체성분 기록 삭제
  Future<void> deleteBodyComposition(String compositionId) async {
    final compositions = await getBodyCompositions();
    compositions.removeWhere((c) => c.id == compositionId);

    final prefs = await SharedPreferences.getInstance();
    final compositionsJson = compositions.map((c) => c.toJson()).toList();
    await prefs.setString(_bodyCompositionsKey, json.encode(compositionsJson));
  }

  // 사용자 신체 프로필 저장
  Future<void> saveUserBodyProfile(UserBodyProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userBodyProfileKey, json.encode(profile.toJson()));
  }

  // 사용자 신체 프로필 가져오기
  Future<UserBodyProfile?> getUserBodyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString(_userBodyProfileKey);

    if (profileJson == null) return null;

    return UserBodyProfile.fromJson(json.decode(profileJson));
  }

  // 신체 측정 기록 저장
  Future<void> saveBodyMetrics(BodyMetrics metrics) async {
    final prefs = await SharedPreferences.getInstance();
    final metricsList = await getBodyMetrics();
    metricsList.add(metrics);
    metricsList.sort((a, b) => b.recordDate.compareTo(a.recordDate));

    final metricsJson = metricsList.map((m) => m.toJson()).toList();
    await prefs.setString(_bodyMetricsKey, json.encode(metricsJson));
  }

  // 신체 측정 기록 가져오기
  Future<List<BodyMetrics>> getBodyMetrics() async {
    final prefs = await SharedPreferences.getInstance();
    final metricsJson = prefs.getString(_bodyMetricsKey);

    if (metricsJson == null) return [];

    final metricsList = json.decode(metricsJson) as List;
    return metricsList.map((m) => BodyMetrics.fromJson(m)).toList();
  }

  // InBody 결과 저장
  Future<void> saveInBodyResult(InBodyResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final results = await getInBodyResults();
    results.add(result);
    results.sort((a, b) => b.scanDate.compareTo(a.scanDate));

    final resultsJson = results.map((r) => r.toJson()).toList();
    await prefs.setString(_inBodyResultsKey, json.encode(resultsJson));

    // InBody 결과를 기반으로 BodyComposition 생성
    final bodyComposition = BodyComposition(
      id: result.id,
      measurementDate: result.scanDate,
      weight: result.weight,
      height: result.height,
      bodyFatPercentage: result.bodyFatPercentage,
      muscleMass: result.skeletalMuscleMass,
      visceralFatLevel: result.vfl,
      bmr: result.bmr,
      bodyWaterPercentage: (result.totalBodyWater / result.weight) * 100,
      proteinPercentage: (result.protein / result.weight) * 100,
      mineralPercentage: (result.mineral / result.weight) * 100,
      bmi: BodyCompositionUtils.calculateBMI(result.weight, result.height),
      notes: result.notes,
      isFromInBodyScan: true,
      inBodyImagePath: result.imagePath,
      createdAt: result.createdAt,
    );

    await saveBodyComposition(bodyComposition);
  }

  // InBody 결과 가져오기
  Future<List<InBodyResult>> getInBodyResults() async {
    final prefs = await SharedPreferences.getInstance();
    final resultsJson = prefs.getString(_inBodyResultsKey);

    if (resultsJson == null) return [];

    final resultsList = json.decode(resultsJson) as List;
    return resultsList.map((r) => InBodyResult.fromJson(r)).toList();
  }

  // 체성분 분석 리포트 생성
  Future<BodyCompositionReport> generateReport(BodyComposition current) async {
    final compositions = await getBodyCompositions();
    final profile = await getUserBodyProfile();

    BodyComposition? previous;
    if (compositions.length > 1) {
      // 현재 측정 이전의 가장 최근 측정 찾기
      final previousMeasurements = compositions
          .where((c) => c.measurementDate.isBefore(current.measurementDate))
          .toList();
      if (previousMeasurements.isNotEmpty) {
        previous = previousMeasurements.first;
      }
    }

    final bodyType = BodyCompositionUtils.getBodyType(current.bmi);
    final idealWeight = BodyCompositionUtils.calculateIdealWeight(
      current.height,
      profile?.gender ?? 'M'
    );

    final weightToLose = current.weight > idealWeight ? current.weight - idealWeight : 0.0;
    final weightToGain = current.weight < idealWeight ? idealWeight - current.weight : 0.0;

    final recommendations = BodyCompositionUtils.generateRecommendations(
      current,
      profile?.gender ?? 'M'
    );

    final metrics = <String, String>{
      'BMI': current.bmi.toStringAsFixed(1),
      '체지방률': '${current.bodyFatPercentage.toStringAsFixed(1)}%',
      '근육량': '${current.muscleMass.toStringAsFixed(1)}kg',
      '내장지방레벨': current.visceralFatLevel.toStringAsFixed(0),
      '기초대사율': '${current.bmr.toStringAsFixed(0)}kcal',
      '체수분': '${current.bodyWaterPercentage.toStringAsFixed(1)}%',
    };

    return BodyCompositionReport(
      currentMeasurement: current,
      previousMeasurement: previous,
      bodyType: bodyType,
      idealWeight: idealWeight,
      weightToLose: weightToLose,
      weightToGain: weightToGain,
      recommendations: recommendations,
      metrics: metrics,
      generatedAt: DateTime.now(),
    );
  }

  // 수동 체성분 입력
  Future<BodyComposition> createManualBodyComposition({
    required double weight,
    required double height,
    required double bodyFatPercentage,
    required double muscleMass,
    required double visceralFatLevel,
    required double bmr,
    required double bodyWaterPercentage,
    String? notes,
  }) async {
    final composition = BodyComposition(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      measurementDate: DateTime.now(),
      weight: weight,
      height: height,
      bodyFatPercentage: bodyFatPercentage,
      muscleMass: muscleMass,
      visceralFatLevel: visceralFatLevel,
      bmr: bmr,
      bodyWaterPercentage: bodyWaterPercentage,
      proteinPercentage: muscleMass / weight * 100 * 0.22, // 근사치
      mineralPercentage: weight * 0.04 / weight * 100, // 근사치
      bmi: BodyCompositionUtils.calculateBMI(weight, height),
      notes: notes,
      isFromInBodyScan: false,
      createdAt: DateTime.now(),
    );

    await saveBodyComposition(composition);
    return composition;
  }

  // 체성분 데이터 내보내기 (CSV 형태)
  Future<String> exportBodyCompositionData() async {
    final compositions = await getBodyCompositions();
    final buffer = StringBuffer();

    // CSV 헤더
    buffer.writeln('날짜,체중(kg),체지방률(%),근육량(kg),내장지방레벨,BMI,기초대사율(kcal),메모');

    // 데이터 행
    for (final composition in compositions) {
      buffer.writeln(
        '${composition.measurementDate.toIso8601String().split('T')[0]},'
        '${composition.weight},'
        '${composition.bodyFatPercentage},'
        '${composition.muscleMass},'
        '${composition.visceralFatLevel},'
        '${composition.bmi.toStringAsFixed(1)},'
        '${composition.bmr},'
        '${composition.notes ?? ""}'
      );
    }

    return buffer.toString();
  }
}