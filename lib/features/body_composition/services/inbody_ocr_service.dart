import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';
import '../../../core/services/mlkit_ocr_service.dart';
import '../../../core/services/api_config_service.dart';
import '../models/body_composition_data.dart';

class InBodyOCRService {
  static final InBodyOCRService _instance = InBodyOCRService._internal();
  factory InBodyOCRService() => _instance;
  InBodyOCRService._internal();

  final Logger _logger = Logger();
  final MLKitOCRService _mlkitOCR = MLKitOCRService();
  final ApiConfigService _apiConfig = ApiConfigService();

  static const String _visionApiUrl = 'https://vision.googleapis.com/v1/images:annotate';

  /// InBody 결과지 이미지에서 텍스트 추출 (스마트 OCR 선택)
  Future<Map<String, dynamic>> extractTextFromInBodyImage(File imageFile) async {
    try {
      _logger.i('InBody 이미지 텍스트 추출 시작');

      // OCR 서비스 설정 확인
      final ocrConfig = await _getOCRConfiguration();

      if (!ocrConfig.hasAnyOCRService) {
        return {
          'success': false,
          'error': '아직 OCR 서비스를 사용할 수 없습니다',
          'message': 'InBody 결과지 자동 인식 기능을 사용하려면 Google Cloud Vision API 키가 필요합니다.',
          'solution': 'API 키를 설정하시거나 수동으로 데이터를 입력해주세요.',
        };
      }

      Map<String, dynamic> result;

      // 1차: ML Kit 시도 (빠른 오프라인 처리)
      if (ocrConfig.canUseMLKit) {
        _logger.i('ML Kit를 사용하여 텍스트 추출 시도');
        result = await _extractWithMLKit(imageFile);

        // ML Kit 결과가 충분히 좋으면 반환
        if (result['success'] == true &&
            result['confidence'] != null &&
            result['confidence'] >= 0.7) {
          result['ocrMethod'] = 'mlkit';
          return result;
        }
      }

      // 2차: Cloud Vision API 시도 (더 정확한 처리)
      if (ocrConfig.canUseCloudVision) {
        _logger.i('Cloud Vision API를 사용하여 텍스트 추출 시도');
        result = await _extractWithCloudVision(imageFile, ocrConfig.apiKey!);
        result['ocrMethod'] = 'cloud_vision';
        return result;
      }

      // ML Kit 결과가 있다면 그것을 반환 (낮은 신뢰도라도)
      if (ocrConfig.canUseMLKit) {
        result = await _extractWithMLKit(imageFile);
        result['ocrMethod'] = 'mlkit_fallback';
        result['warning'] = 'Cloud Vision API를 사용할 수 없어 ML Kit 결과를 반환합니다';
        return result;
      }

      return {
        'success': false,
        'error': '모든 OCR 서비스 시도가 실패했습니다',
      };

    } catch (e) {
      _logger.e('InBody OCR 오류: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// ML Kit를 사용한 텍스트 추출
  Future<Map<String, dynamic>> _extractWithMLKit(File imageFile) async {
    try {
      final extractedText = await _mlkitOCR.extractTextFromImage(imageFile);

      if (extractedText.isEmpty) {
        return {
          'success': false,
          'error': '이미지에서 텍스트를 찾을 수 없습니다',
        };
      }

      final parsedData = _mlkitOCR.parseInBodyData(extractedText);
      final parseResult = InBodyParseResult.validate(parsedData);

      return {
        'success': true,
        'data': parsedData,
        'rawText': extractedText,
        'confidence': parseResult.confidence,
        'missingFields': parseResult.missingFields,
        'isValid': parseResult.isValid,
      };
    } catch (e) {
      _logger.e('ML Kit OCR 오류: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// OCR 서비스 설정 확인
  Future<OCRServiceConfig> _getOCRConfiguration() async {
    final hasApiKey = await _apiConfig.hasCloudVisionApiKey();
    final apiKey = hasApiKey ? await _apiConfig.getCloudVisionApiKey() : null;

    return OCRServiceConfig(
      useCloudVision: hasApiKey,
      apiKey: apiKey,
      mlkitAvailable: true, // ML Kit는 항상 사용 가능
    );
  }

  /// Cloud Vision API를 사용한 텍스트 추출
  Future<Map<String, dynamic>> _extractWithCloudVision(File imageFile, String apiKey) async {
    try {
      // 이미지 전처리
      final processedImage = await _preprocessImage(imageFile);

      // Google Vision API 호출
      final extractedText = await _callGoogleVisionAPI(processedImage, apiKey);

      // 추출된 텍스트에서 InBody 데이터 파싱
      final parsedData = _parseInBodyData(extractedText);

      return {
        'success': true,
        'data': parsedData,
        'rawText': extractedText,
        'confidence': 1.0, // Cloud Vision은 일반적으로 높은 신뢰도
        'source': 'cloud_vision',
      };
    } catch (e) {
      _logger.e('Cloud Vision API 오류: $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// 공개 메서드: Cloud Vision API만 사용하여 텍스트 추출 (테스트용)
  Future<Map<String, dynamic>> extractTextWithCloudVisionOnly(File imageFile) async {
    final apiKey = await _apiConfig.getCloudVisionApiKey();
    if (apiKey == null || !_apiConfig.isValidApiKey(apiKey)) {
      return {
        'success': false,
        'error': 'Cloud Vision API 키가 설정되지 않았거나 유효하지 않습니다',
      };
    }

    return await _extractWithCloudVision(imageFile, apiKey);
  }

  /// OCR 서비스 상태를 확인합니다 (UI에서 사용)
  Future<Map<String, dynamic>> getOCRServiceStatus() async {
    final config = await _getOCRConfiguration();

    return {
      'available': config.hasAnyOCRService,
      'services': {
        'mlkit': config.canUseMLKit,
        'cloudVision': config.canUseCloudVision,
      },
      'primaryService': config.primaryOCRService,
      'message': _getStatusMessage(config),
      'recommendation': _getRecommendation(config),
    };
  }

  String _getStatusMessage(OCRServiceConfig config) {
    if (config.canUseCloudVision && config.canUseMLKit) {
      return '고정밀 OCR 서비스가 활성화되어 있습니다';
    } else if (config.canUseMLKit) {
      return '기본 OCR 서비스를 사용할 수 있습니다';
    } else {
      return 'OCR 서비스를 사용할 수 없습니다';
    }
  }

  String _getRecommendation(OCRServiceConfig config) {
    if (config.canUseCloudVision) {
      return '최고 품질의 인식 결과를 제공합니다';
    } else if (config.canUseMLKit) {
      return 'Google Cloud Vision API 키를 설정하면 더 정확한 인식이 가능합니다';
    } else {
      return 'API 키를 설정하시거나 수동으로 데이터를 입력해주세요';
    }
  }

  // 이미지 전처리 (OCR 정확도 향상)
  Future<File> _preprocessImage(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    final image = img.decodeImage(imageBytes);

    if (image == null) throw Exception('이미지를 읽을 수 없습니다');

    // 이미지 크기 조정 (OCR 최적화)
    final resized = img.copyResize(image, width: 1200);

    // 대비 및 밝기 조정
    final enhanced = img.adjustColor(
      resized,
      contrast: 1.2,
      brightness: 1.1,
    );

    // 노이즈 제거
    final filtered = img.gaussianBlur(enhanced, radius: 1);

    // 임시 파일로 저장
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/processed_inbody_${DateTime.now().millisecondsSinceEpoch}.jpg');
    await tempFile.writeAsBytes(img.encodeJpg(filtered, quality: 90));

    return tempFile;
  }

  // Google Vision API 호출
  Future<String> _callGoogleVisionAPI(File imageFile, String apiKey) async {
    final imageBytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(imageBytes);

    final requestBody = {
      'requests': [
        {
          'image': {
            'content': base64Image,
          },
          'features': [
            {
              'type': 'TEXT_DETECTION',
              'maxResults': 1,
            }
          ],
          'imageContext': {
            'languageHints': ['ko', 'en'] // 한국어, 영어 지원
          }
        }
      ]
    };

    final response = await http.post(
      Uri.parse('$_visionApiUrl?key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final textAnnotations = responseData['responses'][0]['textAnnotations'];

      if (textAnnotations != null && textAnnotations.isNotEmpty) {
        return textAnnotations[0]['description'] as String;
      } else {
        throw Exception('텍스트를 인식할 수 없습니다');
      }
    } else {
      throw Exception('Google Vision API 호출 실패: ${response.statusCode}');
    }
  }

  // InBody 데이터 파싱
  Map<String, dynamic> _parseInBodyData(String extractedText) {
    final data = <String, dynamic>{};
    final lines = extractedText.split('\n');

    try {
      // 체중 추출
      data['weight'] = _extractValue(lines, ['체중', 'Weight', 'Wt'], 'kg');

      // 골격근량 추출
      data['skeletalMuscleMass'] = _extractValue(lines, ['골격근량', 'Skeletal Muscle Mass', 'SMM'], 'kg');

      // 체지방량 추출
      data['bodyFatMass'] = _extractValue(lines, ['체지방량', 'Body Fat Mass', 'BFM'], 'kg');

      // 체지방률 추출
      data['bodyFatPercentage'] = _extractValue(lines, ['체지방률', 'Percent Body Fat', 'PBF'], '%');

      // 내장지방레벨 추출
      data['visceralFatLevel'] = _extractValue(lines, ['내장지방레벨', 'Visceral Fat Level', 'VFL'], '');

      // 기초대사율 추출
      data['bmr'] = _extractValue(lines, ['기초대사율', 'Basal Metabolic Rate', 'BMR'], 'kcal');

      // 총체수분 추출
      data['totalBodyWater'] = _extractValue(lines, ['총체수분', 'Total Body Water', 'TBW'], 'L');

      // 단백질 추출
      data['protein'] = _extractValue(lines, ['단백질', 'Protein'], 'kg');

      // 무기질 추출
      data['mineral'] = _extractValue(lines, ['무기질', 'Mineral'], 'kg');

      // 제지방량 추출
      data['leanBodyMass'] = _extractValue(lines, ['제지방량', 'Lean Body Mass', 'LBM'], 'kg');

      // 계산된 값들
      if (data['weight'] != null) {
        data['bodyWaterPercentage'] = data['totalBodyWater'] != null
            ? (data['totalBodyWater'] / data['weight']) * 100
            : null;
        data['proteinPercentage'] = data['protein'] != null
            ? (data['protein'] / data['weight']) * 100
            : null;
        data['mineralPercentage'] = data['mineral'] != null
            ? (data['mineral'] / data['weight']) * 100
            : null;
      }

      // 부위별 데이터 (팔, 다리, 몸통)
      data['segmentalLeanMass'] = _extractSegmentalData(lines, ['Right Arm', 'Left Arm', 'Trunk', 'Right Leg', 'Left Leg'], 'kg');
      data['segmentalFatMass'] = _extractSegmentalFatData(lines);

      // 전신위상각
      data['wholeBodyPhaseAngle'] = _extractValue(lines, ['전신위상각', 'Whole Body Phase Angle'], '°');

    } catch (e) {
      _logger.e('InBody 데이터 파싱 오류: $e');
    }

    return data;
  }

  // 특정 키워드로 값 추출
  double? _extractValue(List<String> lines, List<String> keywords, String unit) {
    for (final line in lines) {
      for (final keyword in keywords) {
        if (line.contains(keyword)) {
          // 숫자 패턴 찾기
          final pattern = unit.isNotEmpty
              ? RegExp(r'(\d+\.?\d*)\s*' + RegExp.escape(unit))
              : RegExp(r'(\d+\.?\d*)');

          final match = pattern.firstMatch(line);
          if (match != null) {
            return double.tryParse(match.group(1)!);
          }
        }
      }
    }
    return null;
  }

  // 부위별 근육량 데이터 추출
  Map<String, double> _extractSegmentalData(List<String> lines, List<String> bodyParts, String unit) {
    final segmentalData = <String, double>{};

    for (final part in bodyParts) {
      final value = _extractValue(lines, [part], unit);
      if (value != null) {
        segmentalData[part] = value;
      }
    }

    return segmentalData;
  }

  // 부위별 지방량 데이터 추출
  Map<String, double> _extractSegmentalFatData(List<String> lines) {
    // InBody 결과지의 부위별 지방량 패턴에 맞게 구현
    return <String, double>{};
  }

  // OCR 결과를 InBodyResult 객체로 변환
  InBodyResult? createInBodyResultFromOCR(
    Map<String, dynamic> ocrData,
    String imagePath,
    double height,
  ) {
    try {
      final data = ocrData['data'] as Map<String, dynamic>;

      // 필수 데이터 검증
      if (data['weight'] == null || data['skeletalMuscleMass'] == null) {
        throw Exception('필수 데이터가 누락되었습니다');
      }

      return InBodyResult(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        scanDate: DateTime.now(),
        weight: data['weight']?.toDouble() ?? 0.0,
        height: height,
        bodyFatMass: data['bodyFatMass']?.toDouble() ?? 0.0,
        leanBodyMass: data['leanBodyMass'] ??
            (data['weight'] - (data['bodyFatMass'] ?? 0.0)),
        totalBodyWater: data['totalBodyWater']?.toDouble() ?? 0.0,
        protein: data['protein']?.toDouble() ?? 0.0,
        mineral: data['mineral']?.toDouble() ?? 0.0,
        skeletalMuscleMass: data['skeletalMuscleMass']?.toDouble() ?? 0.0,
        bodyFatPercentage: data['bodyFatPercentage']?.toDouble() ?? 0.0,
        pbf: data['bodyFatPercentage']?.toDouble() ?? 0.0,
        vfl: data['visceralFatLevel']?.toDouble() ?? 0.0,
        bmr: data['bmr']?.toDouble() ?? 0.0,
        wholeBodyPhaseAngle: data['wholeBodyPhaseAngle']?.toDouble() ?? 0.0,
        segmentalLeanMass: Map<String, double>.from(data['segmentalLeanMass'] ?? {}),
        segmentalFatMass: Map<String, double>.from(data['segmentalFatMass'] ?? {}),
        imagePath: imagePath,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      _logger.e('InBodyResult 생성 오류: $e');
      return null;
    }
  }

  // OCR 결과 검증
  bool validateOCRResult(Map<String, dynamic> ocrData) {
    final data = ocrData['data'] as Map<String, dynamic>?;
    if (data == null) return false;

    // 최소한의 필수 데이터가 있는지 확인
    final requiredFields = ['weight', 'bodyFatPercentage', 'skeletalMuscleMass'];
    return requiredFields.every((field) => data[field] != null);
  }


  // 데모용 Mock OCR (개발/테스트용)
  Future<Map<String, dynamic>> mockInBodyOCR() async {
    await Future.delayed(const Duration(seconds: 2)); // API 호출 시뮬레이션

    return {
      'success': true,
      'data': {
        'weight': 70.5,
        'skeletalMuscleMass': 32.8,
        'bodyFatMass': 12.3,
        'bodyFatPercentage': 17.4,
        'visceralFatLevel': 8.0,
        'bmr': 1650.0,
        'totalBodyWater': 42.1,
        'protein': 11.2,
        'mineral': 3.8,
        'leanBodyMass': 58.2,
        'bodyWaterPercentage': 59.7,
        'proteinPercentage': 15.9,
        'mineralPercentage': 5.4,
        'wholeBodyPhaseAngle': 6.2,
        'segmentalLeanMass': {
          'Right Arm': 3.2,
          'Left Arm': 3.1,
          'Trunk': 24.8,
          'Right Leg': 9.8,
          'Left Leg': 9.9,
        },
        'segmentalFatMass': {
          'Right Arm': 0.8,
          'Left Arm': 0.7,
          'Trunk': 7.2,
          'Right Leg': 2.1,
          'Left Leg': 1.9,
        },
      },
      'rawText': 'InBody 결과지 텍스트...',
    };
  }
}