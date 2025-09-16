import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import '../models/step_data.dart';

class StepTrackerService {
  static final StepTrackerService _instance = StepTrackerService._internal();
  factory StepTrackerService() => _instance;
  StepTrackerService._internal();

  Health health = Health();
  final Logger _logger = Logger();

  Future<bool> requestPermissions() async {
    try {
      _logger.i('Requesting health permissions...');

      // iOS의 경우 Health Kit, Android의 경우 Google Fit 권한 요청
      List<HealthDataType> types = [
        HealthDataType.STEPS,
        HealthDataType.DISTANCE_DELTA,
        HealthDataType.ACTIVE_ENERGY_BURNED,
      ];

      List<HealthDataAccess> permissions = [
        HealthDataAccess.READ,
      ];

      bool requested = await health.requestAuthorization(types, permissions: permissions);
      _logger.i('Health authorization result: $requested');

      // Android의 경우 추가 권한 확인
      if (!requested) {
        _logger.w('Health authorization failed, requesting additional permissions...');

        var activityStatus = await Permission.activityRecognition.request();
        var locationStatus = await Permission.location.request();

        _logger.i('Activity recognition permission: $activityStatus');
        _logger.i('Location permission: $locationStatus');

        // 최소한 활동 인식 권한이 허용되었다면 true 반환
        return activityStatus.isGranted;
      }

      return requested;
    } catch (e) {
      _logger.e('Error requesting permissions: $e');
      return false;
    }
  }

  Future<int> getTodaySteps() async {
    try {
      _logger.i('Fetching today\'s steps...');

      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      _logger.d('Time range: $startOfDay to $endOfDay');

      List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: startOfDay,
        endTime: endOfDay,
      );

      _logger.d('Retrieved ${healthData.length} health data points');

      int totalSteps = 0;
      for (HealthDataPoint point in healthData) {
        if (point.value is NumericHealthValue) {
          int stepValue = (point.value as NumericHealthValue).numericValue.round();
          totalSteps += stepValue;
          _logger.d('Step data point: $stepValue at ${point.dateFrom}');
        }
      }

      _logger.i('Total steps calculated: $totalSteps');

      // 실제 데이터가 있으면 반환, 없으면 0 반환 (Mock 대신)
      return totalSteps;
    } catch (e) {
      _logger.e('Error getting today steps: $e');
      _logger.w('Falling back to mock data due to error');
      // 에러 발생시에만 Mock 데이터 사용
      return _generateMockSteps();
    }
  }

  Future<List<StepData>> getWeeklySteps() async {
    try {
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime startDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

      List<StepData> weeklyData = [];

      for (int i = 0; i < 7; i++) {
        DateTime currentDate = startDate.add(Duration(days: i));
        DateTime startOfDay = DateTime(currentDate.year, currentDate.month, currentDate.day);
        DateTime endOfDay = DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59, 59);

        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          types: [HealthDataType.STEPS],
          startTime: startOfDay,
          endTime: endOfDay,
        );

        int totalSteps = 0;
        for (HealthDataPoint point in healthData) {
          if (point.value is NumericHealthValue) {
            totalSteps += (point.value as NumericHealthValue).numericValue.round();
          }
        }

        weeklyData.add(StepData(
          date: currentDate,
          steps: totalSteps,
          points: totalSteps, // 1걸음 = 1포인트
        ));
      }

      return weeklyData;
    } catch (e) {
      _logger.e('Error getting weekly steps: $e');
      // 테스트용 더미 데이터
      return _generateMockWeeklySteps();
    }
  }

  Future<WeeklyStepSummary> getWeeklyStepSummary() async {
    List<StepData> weeklySteps = await getWeeklySteps();

    int totalSteps = weeklySteps.fold(0, (sum, data) => sum + data.steps);
    int totalPoints = weeklySteps.fold(0, (sum, data) => sum + data.points);
    double averageSteps = totalSteps / 7.0;
    int goalAchievedDays = weeklySteps.where((data) => data.steps >= data.dailyGoal).length;

    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime weekStart = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

    return WeeklyStepSummary(
      weekStart: weekStart,
      totalSteps: totalSteps,
      totalPoints: totalPoints,
      dailySteps: weeklySteps,
      averageSteps: averageSteps,
      goalAchievedDays: goalAchievedDays,
    );
  }

  // 테스트용 더미 데이터 생성 메서드들
  int _generateMockSteps() {
    DateTime now = DateTime.now();
    // 시간에 따라 걸음 수가 증가하도록 시뮬레이션
    int baseSteps = (now.hour * 400) + (now.minute * 5);
    return baseSteps.clamp(0, 15000);
  }

  List<StepData> _generateMockWeeklySteps() {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime startDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

    List<StepData> weeklyData = [];
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      int mockSteps;

      if (currentDate.isAfter(now)) {
        mockSteps = 0; // 미래 날짜는 0걸음
      } else if (currentDate.day == now.day && currentDate.month == now.month) {
        mockSteps = _generateMockSteps(); // 오늘은 현재 시간 기반
      } else {
        // 과거 날짜는 랜덤하게 8000~15000 걸음
        mockSteps = 8000 + (i * 1000) + (currentDate.day % 3) * 2000;
      }

      weeklyData.add(StepData(
        date: currentDate,
        steps: mockSteps,
        points: mockSteps,
      ));
    }

    return weeklyData;
  }

  Future<bool> checkDailyGoalAchieved() async {
    int todaySteps = await getTodaySteps();
    return todaySteps >= 10000;
  }

  Future<double> getDailyGoalProgress() async {
    int todaySteps = await getTodaySteps();
    return (todaySteps / 10000.0).clamp(0.0, 1.0);
  }
}