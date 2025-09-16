import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../models/body_composition_data.dart';
import '../services/body_composition_service.dart';
import '../services/inbody_ocr_service.dart';

// Body Composition Service Provider
final bodyCompositionServiceProvider = Provider<BodyCompositionService>((ref) {
  return BodyCompositionService();
});

// InBody OCR Service Provider
final inBodyOCRServiceProvider = Provider<InBodyOCRService>((ref) {
  return InBodyOCRService();
});

// All Body Compositions Provider
final bodyCompositionsProvider = FutureProvider<List<BodyComposition>>((ref) async {
  final service = ref.read(bodyCompositionServiceProvider);
  return await service.getBodyCompositions();
});

// Latest Body Composition Provider
final latestBodyCompositionProvider = FutureProvider<BodyComposition?>((ref) async {
  final service = ref.read(bodyCompositionServiceProvider);
  return await service.getLatestBodyComposition();
});

// Body Composition Stats Provider
final bodyCompositionStatsProvider = FutureProvider<BodyCompositionStats>((ref) async {
  final service = ref.read(bodyCompositionServiceProvider);
  return await service.getBodyCompositionStats();
});

// User Body Profile Provider
final userBodyProfileProvider = FutureProvider<UserBodyProfile?>((ref) async {
  final service = ref.read(bodyCompositionServiceProvider);
  return await service.getUserBodyProfile();
});

// Body Metrics Provider
final bodyMetricsProvider = FutureProvider<List<BodyMetrics>>((ref) async {
  final service = ref.read(bodyCompositionServiceProvider);
  return await service.getBodyMetrics();
});

// InBody Results Provider
final inBodyResultsProvider = FutureProvider<List<InBodyResult>>((ref) async {
  final service = ref.read(bodyCompositionServiceProvider);
  return await service.getInBodyResults();
});

// Body Composition Manager State Notifier
class BodyCompositionManagerNotifier extends StateNotifier<AsyncValue<List<BodyComposition>>> {
  BodyCompositionManagerNotifier(this.ref) : super(const AsyncValue.loading()) {
    _loadBodyCompositions();
  }

  final Ref ref;

  Future<void> _loadBodyCompositions() async {
    try {
      final service = ref.read(bodyCompositionServiceProvider);
      final compositions = await service.getBodyCompositions();
      state = AsyncValue.data(compositions);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 수동 체성분 기록 추가
  Future<BodyComposition?> addManualBodyComposition({
    required double weight,
    required double height,
    required double bodyFatPercentage,
    required double muscleMass,
    required double visceralFatLevel,
    required double bmr,
    required double bodyWaterPercentage,
    String? notes,
  }) async {
    try {
      final service = ref.read(bodyCompositionServiceProvider);
      final composition = await service.createManualBodyComposition(
        weight: weight,
        height: height,
        bodyFatPercentage: bodyFatPercentage,
        muscleMass: muscleMass,
        visceralFatLevel: visceralFatLevel,
        bmr: bmr,
        bodyWaterPercentage: bodyWaterPercentage,
        notes: notes,
      );

      // 상태 및 관련 프로바이더들 새로고침
      await _loadBodyCompositions();
      ref.invalidate(latestBodyCompositionProvider);
      ref.invalidate(bodyCompositionStatsProvider);

      return composition;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  // InBody 스캔 결과 처리
  Future<InBodyResult?> processInBodyScan(File imageFile, double height) async {
    try {
      final ocrService = ref.read(inBodyOCRServiceProvider);
      final bodyService = ref.read(bodyCompositionServiceProvider);

      // OCR 처리
      final ocrResult = await ocrService.extractTextFromInBodyImage(imageFile);

      if (!ocrResult['success']) {
        throw Exception('InBody 이미지 분석 실패: ${ocrResult['error']}');
      }

      // OCR 결과 검증
      if (!ocrService.validateOCRResult(ocrResult)) {
        throw Exception('InBody 결과지에서 필요한 정보를 찾을 수 없습니다');
      }

      // InBody 결과 생성
      final inBodyResult = ocrService.createInBodyResultFromOCR(
        ocrResult,
        imageFile.path,
        height,
      );

      if (inBodyResult == null) {
        throw Exception('InBody 결과 생성 실패');
      }

      // 결과 저장
      await bodyService.saveInBodyResult(inBodyResult);

      // 상태 새로고침
      await _loadBodyCompositions();
      ref.invalidate(latestBodyCompositionProvider);
      ref.invalidate(bodyCompositionStatsProvider);
      ref.invalidate(inBodyResultsProvider);

      return inBodyResult;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  // Mock InBody 스캔 (개발/테스트용)
  Future<InBodyResult?> processMockInBodyScan(double height) async {
    try {
      final ocrService = ref.read(inBodyOCRServiceProvider);
      final bodyService = ref.read(bodyCompositionServiceProvider);

      // Mock OCR 결과
      final ocrResult = await ocrService.mockInBodyOCR();

      // InBody 결과 생성
      final inBodyResult = ocrService.createInBodyResultFromOCR(
        ocrResult,
        'mock_inbody_scan.jpg',
        height,
      );

      if (inBodyResult == null) {
        throw Exception('Mock InBody 결과 생성 실패');
      }

      // 결과 저장
      await bodyService.saveInBodyResult(inBodyResult);

      // 상태 새로고침
      await _loadBodyCompositions();
      ref.invalidate(latestBodyCompositionProvider);
      ref.invalidate(bodyCompositionStatsProvider);
      ref.invalidate(inBodyResultsProvider);

      return inBodyResult;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  // 체성분 기록 삭제
  Future<void> deleteBodyComposition(String compositionId) async {
    try {
      final service = ref.read(bodyCompositionServiceProvider);
      await service.deleteBodyComposition(compositionId);

      // 상태 및 관련 프로바이더들 새로고침
      await _loadBodyCompositions();
      ref.invalidate(latestBodyCompositionProvider);
      ref.invalidate(bodyCompositionStatsProvider);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 사용자 신체 프로필 저장
  Future<void> saveUserBodyProfile(UserBodyProfile profile) async {
    try {
      final service = ref.read(bodyCompositionServiceProvider);
      await service.saveUserBodyProfile(profile);

      // 관련 프로바이더 새로고침
      ref.invalidate(userBodyProfileProvider);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 신체 측정 기록 추가
  Future<void> addBodyMetrics(BodyMetrics metrics) async {
    try {
      final service = ref.read(bodyCompositionServiceProvider);
      await service.saveBodyMetrics(metrics);

      // 관련 프로바이더 새로고침
      ref.invalidate(bodyMetricsProvider);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // 체성분 분석 리포트 생성
  Future<BodyCompositionReport?> generateReport(BodyComposition composition) async {
    try {
      final service = ref.read(bodyCompositionServiceProvider);
      return await service.generateReport(composition);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  // 데이터 새로고침
  void refreshData() {
    _loadBodyCompositions();
    ref.invalidate(latestBodyCompositionProvider);
    ref.invalidate(bodyCompositionStatsProvider);
    ref.invalidate(userBodyProfileProvider);
    ref.invalidate(bodyMetricsProvider);
    ref.invalidate(inBodyResultsProvider);
  }
}

final bodyCompositionManagerProvider = StateNotifierProvider<BodyCompositionManagerNotifier, AsyncValue<List<BodyComposition>>>((ref) {
  return BodyCompositionManagerNotifier(ref);
});

// Current BMI Provider
final currentBMIProvider = FutureProvider<double?>((ref) async {
  final latestComposition = await ref.read(latestBodyCompositionProvider.future);
  return latestComposition?.bmi;
});

// Body Type Provider
final currentBodyTypeProvider = FutureProvider<BodyType?>((ref) async {
  final bmi = await ref.read(currentBMIProvider.future);
  if (bmi == null) return null;
  return BodyCompositionUtils.getBodyType(bmi);
});

// Weight Change Provider (지난 30일)
final monthlyWeightChangeProvider = FutureProvider<double?>((ref) async {
  final stats = await ref.read(bodyCompositionStatsProvider.future);
  return stats.weightChange;
});

// Body Fat Change Provider (지난 30일)
final monthlyBodyFatChangeProvider = FutureProvider<double?>((ref) async {
  final stats = await ref.read(bodyCompositionStatsProvider.future);
  return stats.bodyFatChange;
});

// Muscle Mass Change Provider (지난 30일)
final monthlyMuscleMassChangeProvider = FutureProvider<double?>((ref) async {
  final stats = await ref.read(bodyCompositionStatsProvider.future);
  return stats.muscleMassChange;
});

// Ideal Weight Provider
final idealWeightProvider = FutureProvider<double?>((ref) async {
  final profile = await ref.read(userBodyProfileProvider.future);
  if (profile == null) return null;

  return BodyCompositionUtils.calculateIdealWeight(profile.height, profile.gender);
});

// Weight Goal Progress Provider
final weightGoalProgressProvider = FutureProvider<double?>((ref) async {
  final profile = await ref.read(userBodyProfileProvider.future);
  final latestComposition = await ref.read(latestBodyCompositionProvider.future);

  if (profile == null || latestComposition == null) return null;

  final currentWeight = latestComposition.weight;
  final targetWeight = profile.targetWeight;
  final startWeight = profile.currentWeight;

  if (startWeight == targetWeight) return 1.0;

  final totalProgress = (startWeight - currentWeight) / (startWeight - targetWeight);
  return totalProgress.clamp(0.0, 1.0);
});

// Recent Measurements Provider (최근 5개)
final recentMeasurementsProvider = FutureProvider<List<BodyComposition>>((ref) async {
  final compositions = await ref.read(bodyCompositionsProvider.future);
  return compositions.take(5).toList();
});

// Data Export Provider
final bodyCompositionExportProvider = FutureProvider<String>((ref) async {
  final service = ref.read(bodyCompositionServiceProvider);
  return await service.exportBodyCompositionData();
});