import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:logger/logger.dart';

class MLKitOCRService {
  static final MLKitOCRService _instance = MLKitOCRService._internal();
  factory MLKitOCRService() => _instance;
  MLKitOCRService._internal();

  final Logger _logger = Logger();
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);

  /// 이미지에서 텍스트를 추출합니다
  Future<String> extractTextFromImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      _logger.i('텍스트 인식 완료: ${recognizedText.text.length}자');
      return recognizedText.text;
    } catch (e) {
      _logger.e('텍스트 인식 오류: $e');
      rethrow;
    }
  }

  /// 인식된 텍스트에서 특정 패턴을 찾아 값을 추출합니다
  String? extractValueByPattern(String text, RegExp pattern) {
    final match = pattern.firstMatch(text);
    return match?.group(1);
  }

  /// InBody 결과지에서 주요 데이터를 추출합니다
  Map<String, dynamic> parseInBodyData(String text) {
    final data = <String, dynamic>{};

    // 체중 추출 패턴
    final weightPattern = RegExp(r'체중.*?(\d+\.?\d*)\s*kg', caseSensitive: false);
    final weightValue = extractValueByPattern(text, weightPattern);
    if (weightValue != null) {
      data['weight'] = double.tryParse(weightValue);
    }

    // 체지방률 추출 패턴
    final bodyFatPattern = RegExp(r'체지방.*?(\d+\.?\d*)\s*%', caseSensitive: false);
    final bodyFatValue = extractValueByPattern(text, bodyFatPattern);
    if (bodyFatValue != null) {
      data['bodyFatPercentage'] = double.tryParse(bodyFatValue);
    }

    // 골격근량 추출 패턴
    final musclePattern = RegExp(r'골격근량.*?(\d+\.?\d*)\s*kg', caseSensitive: false);
    final muscleValue = extractValueByPattern(text, musclePattern);
    if (muscleValue != null) {
      data['skeletalMuscleMass'] = double.tryParse(muscleValue);
    }

    // 기초대사율 추출 패턴
    final bmrPattern = RegExp(r'기초대사율.*?(\d+)\s*kcal', caseSensitive: false);
    final bmrValue = extractValueByPattern(text, bmrPattern);
    if (bmrValue != null) {
      data['bmr'] = double.tryParse(bmrValue);
    }

    // 체수분 추출 패턴
    final waterPattern = RegExp(r'체수분.*?(\d+\.?\d*)\s*%', caseSensitive: false);
    final waterValue = extractValueByPattern(text, waterPattern);
    if (waterValue != null) {
      data['bodyWaterPercentage'] = double.tryParse(waterValue);
    }

    // 내장지방 추출 패턴
    final visceralFatPattern = RegExp(r'내장지방.*?(\d+\.?\d*)', caseSensitive: false);
    final visceralFatValue = extractValueByPattern(text, visceralFatPattern);
    if (visceralFatValue != null) {
      data['visceralFatLevel'] = double.tryParse(visceralFatValue);
    }

    _logger.i('InBody 데이터 파싱 완료: ${data.keys.length}개 항목');
    return data;
  }

  /// 리소스 해제
  Future<void> dispose() async {
    await _textRecognizer.close();
  }
}

/// InBody 데이터 파싱 결과를 위한 클래스
class InBodyParseResult {
  final Map<String, dynamic> data;
  final List<String> missingFields;
  final double confidence;

  InBodyParseResult({
    required this.data,
    required this.missingFields,
    required this.confidence,
  });

  bool get isValid => missingFields.isEmpty;

  static InBodyParseResult validate(Map<String, dynamic> data) {
    final requiredFields = ['weight', 'bodyFatPercentage', 'skeletalMuscleMass'];
    final missingFields = requiredFields.where((field) => data[field] == null).toList();

    // 신뢰도 계산 (추출된 필수 필드 비율)
    final confidence = (requiredFields.length - missingFields.length) / requiredFields.length;

    return InBodyParseResult(
      data: data,
      missingFields: missingFields,
      confidence: confidence,
    );
  }
}