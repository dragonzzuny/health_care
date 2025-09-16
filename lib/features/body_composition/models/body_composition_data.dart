import 'package:freezed_annotation/freezed_annotation.dart';

part 'body_composition_data.freezed.dart';
part 'body_composition_data.g.dart';

@freezed
class BodyComposition with _$BodyComposition {
  const factory BodyComposition({
    required String id,
    required DateTime measurementDate,
    required double weight, // kg
    required double height, // cm
    required double bodyFatPercentage, // %
    required double muscleMass, // kg
    required double visceralFatLevel, // level
    required double bmr, // kcal (기초대사율)
    required double bodyWaterPercentage, // %
    required double proteinPercentage, // %
    required double mineralPercentage, // %
    required double bmi,
    String? notes,
    @Default(false) bool isFromInBodyScan,
    String? inBodyImagePath,
    DateTime? createdAt,
  }) = _BodyComposition;

  factory BodyComposition.fromJson(Map<String, dynamic> json) => _$BodyCompositionFromJson(json);
}

@freezed
class BodyCompositionStats with _$BodyCompositionStats {
  const factory BodyCompositionStats({
    required List<BodyComposition> measurements,
    required DateTime startDate,
    required DateTime endDate,
    required double averageWeight,
    required double averageBodyFat,
    required double averageMuscleMass,
    required double weightChange,
    required double bodyFatChange,
    required double muscleMassChange,
    required BodyComposition? latestMeasurement,
    required BodyComposition? firstMeasurement,
  }) = _BodyCompositionStats;

  factory BodyCompositionStats.fromJson(Map<String, dynamic> json) => _$BodyCompositionStatsFromJson(json);
}

@freezed
class BodyMetrics with _$BodyMetrics {
  const factory BodyMetrics({
    required String id,
    required DateTime recordDate,
    required double weight,
    required double height,
    double? bodyFatPercentage,
    double? muscleMass,
    double? waistSize,
    double? chestSize,
    double? armSize,
    double? thighSize,
    String? notes,
    DateTime? createdAt,
  }) = _BodyMetrics;

  factory BodyMetrics.fromJson(Map<String, dynamic> json) => _$BodyMetricsFromJson(json);
}

enum BodyType {
  underweight('저체중', 'Under Weight'),
  normal('정상', 'Normal'),
  overweight('과체중', 'Over Weight'),
  obese('비만', 'Obese');

  const BodyType(this.koreanLabel, this.englishLabel);
  final String koreanLabel;
  final String englishLabel;
}

enum FitnessLevel {
  beginner('초심자', '운동을 시작한지 6개월 미만'),
  intermediate('중급자', '규칙적인 운동을 6개월~2년'),
  advanced('상급자', '2년 이상의 운동 경험');

  const FitnessLevel(this.label, this.description);
  final String label;
  final String description;
}

@freezed
class UserBodyProfile with _$UserBodyProfile {
  const factory UserBodyProfile({
    required String userId,
    required String name,
    required int age,
    required String gender, // 'M' or 'F'
    required double height,
    required double currentWeight,
    required double targetWeight,
    required FitnessLevel fitnessLevel,
    String? medicalConditions,
    List<String>? allergies,
    List<String>? fitnessGoals,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserBodyProfile;

  factory UserBodyProfile.fromJson(Map<String, dynamic> json) => _$UserBodyProfileFromJson(json);
}

// InBody 스캔 결과를 위한 확장된 모델
@freezed
class InBodyResult with _$InBodyResult {
  const factory InBodyResult({
    required String id,
    required DateTime scanDate,
    required double weight,
    required double height,
    required double bodyFatMass, // 체지방량 (kg)
    required double leanBodyMass, // 제지방량 (kg)
    required double totalBodyWater, // 체수분 (L)
    required double protein, // 단백질 (kg)
    required double mineral, // 무기질 (kg)
    required double skeletalMuscleMass, // 골격근량 (kg)
    required double bodyFatPercentage,
    required double pbf, // Percent Body Fat
    required double vfl, // 내장지방레벨
    required double bmr, // 기초대사율
    required double wholeBodyPhaseAngle, // 전신위상각
    required Map<String, double> segmentalLeanMass, // 부위별 근육량
    required Map<String, double> segmentalFatMass, // 부위별 지방량
    String? imagePath,
    String? notes,
    DateTime? createdAt,
  }) = _InBodyResult;

  factory InBodyResult.fromJson(Map<String, dynamic> json) => _$InBodyResultFromJson(json);
}

// 체성분 분석 리포트
@freezed
class BodyCompositionReport with _$BodyCompositionReport {
  const factory BodyCompositionReport({
    required BodyComposition currentMeasurement,
    BodyComposition? previousMeasurement,
    required BodyType bodyType,
    required double idealWeight,
    required double weightToLose,
    required double weightToGain,
    required List<String> recommendations,
    required Map<String, String> metrics,
    required DateTime generatedAt,
  }) = _BodyCompositionReport;

  factory BodyCompositionReport.fromJson(Map<String, dynamic> json) => _$BodyCompositionReportFromJson(json);
}

// 유틸리티 함수들
class BodyCompositionUtils {
  static double calculateBMI(double weight, double height) {
    final heightInM = height / 100;
    return weight / (heightInM * heightInM);
  }

  static BodyType getBodyType(double bmi) {
    if (bmi < 18.5) return BodyType.underweight;
    if (bmi < 23.0) return BodyType.normal;
    if (bmi < 25.0) return BodyType.overweight;
    return BodyType.obese;
  }

  static double calculateIdealWeight(double height, String gender) {
    final heightInM = height / 100;
    if (gender.toLowerCase() == 'm') {
      return 22.0 * heightInM * heightInM; // 남성
    } else {
      return 21.0 * heightInM * heightInM; // 여성
    }
  }

  static String getBodyFatCategory(double bodyFatPercentage, String gender) {
    if (gender.toLowerCase() == 'm') {
      if (bodyFatPercentage < 6) return '매우 낮음';
      if (bodyFatPercentage < 14) return '낮음';
      if (bodyFatPercentage < 18) return '정상';
      if (bodyFatPercentage < 25) return '높음';
      return '매우 높음';
    } else {
      if (bodyFatPercentage < 16) return '매우 낮음';
      if (bodyFatPercentage < 21) return '낮음';
      if (bodyFatPercentage < 25) return '정상';
      if (bodyFatPercentage < 32) return '높음';
      return '매우 높음';
    }
  }

  static List<String> generateRecommendations(BodyComposition measurement, String gender) {
    final recommendations = <String>[];
    final bmi = measurement.bmi;
    final bodyFat = measurement.bodyFatPercentage;

    // BMI 기반 권장사항
    if (bmi < 18.5) {
      recommendations.add('체중 증가를 위한 균형잡힌 식단과 근력 운동을 권장합니다.');
    } else if (bmi >= 25.0) {
      recommendations.add('체중 감량을 위한 유산소 운동과 식단 관리를 권장합니다.');
    }

    // 체지방률 기반 권장사항
    final bodyFatCategory = getBodyFatCategory(bodyFat, gender);
    switch (bodyFatCategory) {
      case '매우 높음':
        recommendations.add('체지방 감소를 위한 고강도 유산소 운동과 근력 운동을 병행하세요.');
        break;
      case '높음':
        recommendations.add('규칙적인 운동과 단백질 섭취 증가를 권장합니다.');
        break;
      case '정상':
        recommendations.add('현재 체성분을 유지하기 위한 꾸준한 운동을 계속하세요.');
        break;
      case '낮음':
        recommendations.add('근육량 증가를 위한 근력 운동과 충분한 칼로리 섭취를 권장합니다.');
        break;
    }

    // 근육량 기반 권장사항
    if (measurement.muscleMass < 30) {
      recommendations.add('근육량 증가를 위한 근력 운동과 단백질 보충을 권장합니다.');
    }

    // 내장지방 기반 권장사항
    if (measurement.visceralFatLevel > 10) {
      recommendations.add('내장지방 감소를 위한 유산소 운동과 식단 개선이 필요합니다.');
    }

    return recommendations;
  }
}