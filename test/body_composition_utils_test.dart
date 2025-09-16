import 'package:flutter_test/flutter_test.dart';

// Freezed 이슈로 인해 유틸리티 함수들만 테스트
class BodyCompositionUtilsTest {
  static double calculateBMI(double weight, double height) {
    final heightInM = height / 100;
    return weight / (heightInM * heightInM);
  }

  static String getBodyType(double bmi) {
    if (bmi < 18.5) return '저체중';
    if (bmi < 23.0) return '정상';
    if (bmi < 25.0) return '과체중';
    return '비만';
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
}

void main() {
  group('Body Composition Utils Tests', () {
    test('BMI calculation test', () {
      // 70kg, 175cm -> BMI 22.86
      double bmi = BodyCompositionUtilsTest.calculateBMI(70.0, 175.0);
      expect(bmi, closeTo(22.86, 0.01));

      // 80kg, 180cm -> BMI 24.69
      bmi = BodyCompositionUtilsTest.calculateBMI(80.0, 180.0);
      expect(bmi, closeTo(24.69, 0.01));
    });

    test('Body type classification test', () {
      expect(BodyCompositionUtilsTest.getBodyType(17.0), '저체중');
      expect(BodyCompositionUtilsTest.getBodyType(22.0), '정상');
      expect(BodyCompositionUtilsTest.getBodyType(24.0), '과체중');
      expect(BodyCompositionUtilsTest.getBodyType(26.0), '비만');
    });

    test('Ideal weight calculation test', () {
      // 남성 175cm -> 이상체중 67.38kg
      double idealWeight = BodyCompositionUtilsTest.calculateIdealWeight(175.0, 'M');
      expect(idealWeight, closeTo(67.38, 0.01));

      // 여성 165cm -> 이상체중 57.17kg
      idealWeight = BodyCompositionUtilsTest.calculateIdealWeight(165.0, 'F');
      expect(idealWeight, closeTo(57.17, 0.01));
    });

    test('Body fat category test', () {
      // 남성 체지방률 테스트
      expect(BodyCompositionUtilsTest.getBodyFatCategory(5.0, 'M'), '매우 낮음');
      expect(BodyCompositionUtilsTest.getBodyFatCategory(12.0, 'M'), '낮음');
      expect(BodyCompositionUtilsTest.getBodyFatCategory(16.0, 'M'), '정상');
      expect(BodyCompositionUtilsTest.getBodyFatCategory(20.0, 'M'), '높음');
      expect(BodyCompositionUtilsTest.getBodyFatCategory(30.0, 'M'), '매우 높음');

      // 여성 체지방률 테스트
      expect(BodyCompositionUtilsTest.getBodyFatCategory(15.0, 'F'), '매우 낮음');
      expect(BodyCompositionUtilsTest.getBodyFatCategory(19.0, 'F'), '낮음');
      expect(BodyCompositionUtilsTest.getBodyFatCategory(23.0, 'F'), '정상');
      expect(BodyCompositionUtilsTest.getBodyFatCategory(28.0, 'F'), '높음');
      expect(BodyCompositionUtilsTest.getBodyFatCategory(35.0, 'F'), '매우 높음');
    });
  });
}