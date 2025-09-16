import 'package:flutter_test/flutter_test.dart';

// 만보기 관련 유틸리티 함수들 테스트
class StepTrackerUtilsTest {
  static int calculatePoints(int steps) {
    // 1000걸음당 10포인트
    return (steps ~/ 1000) * 10;
  }

  static double calculateCalories(int steps, double weight) {
    // 대략적인 칼로리 계산: 걸음 수 * 0.04 * 체중(kg) / 70
    return steps * 0.04 * weight / 70;
  }

  static double calculateDistance(int steps, double stepLength) {
    // 거리 = 걸음 수 * 보폭(m)
    return steps * stepLength / 1000; // km 단위로 반환
  }

  static String getActivityLevel(int steps) {
    if (steps < 5000) return '비활동적';
    if (steps < 7500) return '저활동적';
    if (steps < 10000) return '활동적';
    if (steps < 12500) return '매우 활동적';
    return '고활동적';
  }

  static double getGoalProgress(int currentSteps, int goalSteps) {
    if (goalSteps == 0) return 0.0;
    return (currentSteps / goalSteps).clamp(0.0, 1.0);
  }
}

void main() {
  group('Step Tracker Utils Tests', () {
    test('Points calculation test', () {
      expect(StepTrackerUtilsTest.calculatePoints(0), 0);
      expect(StepTrackerUtilsTest.calculatePoints(999), 0);
      expect(StepTrackerUtilsTest.calculatePoints(1000), 10);
      expect(StepTrackerUtilsTest.calculatePoints(5500), 50);
      expect(StepTrackerUtilsTest.calculatePoints(10000), 100);
    });

    test('Calories calculation test', () {
      // 70kg 사람이 1000걸음 걸었을 때 약 40칼로리
      double calories = StepTrackerUtilsTest.calculateCalories(1000, 70.0);
      expect(calories, closeTo(40.0, 1.0));

      // 60kg 사람이 5000걸음 걸었을 때
      calories = StepTrackerUtilsTest.calculateCalories(5000, 60.0);
      expect(calories, closeTo(171.4, 1.0));
    });

    test('Distance calculation test', () {
      // 1000걸음, 보폭 0.7m -> 0.7km
      double distance = StepTrackerUtilsTest.calculateDistance(1000, 0.7);
      expect(distance, closeTo(0.7, 0.01));

      // 10000걸음, 보폭 0.75m -> 7.5km
      distance = StepTrackerUtilsTest.calculateDistance(10000, 0.75);
      expect(distance, closeTo(7.5, 0.01));
    });

    test('Activity level classification test', () {
      expect(StepTrackerUtilsTest.getActivityLevel(3000), '비활동적');
      expect(StepTrackerUtilsTest.getActivityLevel(6000), '저활동적');
      expect(StepTrackerUtilsTest.getActivityLevel(8500), '활동적');
      expect(StepTrackerUtilsTest.getActivityLevel(11000), '매우 활동적');
      expect(StepTrackerUtilsTest.getActivityLevel(15000), '고활동적');
    });

    test('Goal progress calculation test', () {
      expect(StepTrackerUtilsTest.getGoalProgress(0, 10000), 0.0);
      expect(StepTrackerUtilsTest.getGoalProgress(5000, 10000), 0.5);
      expect(StepTrackerUtilsTest.getGoalProgress(10000, 10000), 1.0);
      expect(StepTrackerUtilsTest.getGoalProgress(15000, 10000), 1.0); // 목표 초과시 1.0으로 제한
      expect(StepTrackerUtilsTest.getGoalProgress(5000, 0), 0.0); // 목표가 0일 때
    });
  });
}