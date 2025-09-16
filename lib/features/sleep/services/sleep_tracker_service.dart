import 'package:shared_preferences/shared_preferences.dart';
import 'package:health/health.dart';
import 'dart:convert';
import '../models/sleep_data.dart';

class SleepTrackerService {
  static final SleepTrackerService _instance = SleepTrackerService._internal();
  factory SleepTrackerService() => _instance;
  SleepTrackerService._internal();

  Health health = Health();
  static const String _sleepSessionsKey = 'sleep_sessions';
  static const String _sleepGoalKey = 'sleep_goal';
  static const String _activeSleepSessionKey = 'active_sleep_session';

  Future<bool> requestSleepPermissions() async {
    List<HealthDataType> types = [
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_AWAKE,
    ];

    List<HealthDataAccess> permissions = [
      HealthDataAccess.READ,
    ];

    return await health.requestAuthorization(types, permissions: permissions);
  }

  // 잠자리에 들기 시작
  Future<String> startSleep() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    final bedTime = DateTime.now();

    await prefs.setString(_activeSleepSessionKey, json.encode({
      'id': sessionId,
      'bedTime': bedTime.toIso8601String(),
    }));

    return sessionId;
  }

  // 잠에서 깨기 및 수면 세션 완료
  Future<SleepSession?> endSleep(SleepQuality quality, {String? notes}) async {
    final prefs = await SharedPreferences.getInstance();
    final activeSessionJson = prefs.getString(_activeSleepSessionKey);

    if (activeSessionJson == null) return null;

    final activeSession = json.decode(activeSessionJson);
    final bedTime = DateTime.parse(activeSession['bedTime']);
    final wakeTime = DateTime.now();
    final sleepDuration = wakeTime.difference(bedTime);

    final session = SleepSession(
      id: activeSession['id'],
      bedTime: bedTime,
      wakeTime: wakeTime,
      sleepDuration: sleepDuration,
      quality: quality,
      notes: notes,
      isManualEntry: false,
      createdAt: DateTime.now(),
    );

    await _saveSleepSession(session);
    await prefs.remove(_activeSleepSessionKey);

    return session;
  }

  // 수동으로 수면 기록 추가
  Future<SleepSession> addManualSleepRecord({
    required DateTime bedTime,
    required DateTime wakeTime,
    required SleepQuality quality,
    String? notes,
  }) async {
    final sleepDuration = wakeTime.difference(bedTime);
    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();

    final session = SleepSession(
      id: sessionId,
      bedTime: bedTime,
      wakeTime: wakeTime,
      sleepDuration: sleepDuration,
      quality: quality,
      notes: notes,
      isManualEntry: true,
      createdAt: DateTime.now(),
    );

    await _saveSleepSession(session);
    return session;
  }

  // 현재 수면 중인지 확인
  Future<bool> isSleeping() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_activeSleepSessionKey) != null;
  }

  // 현재 수면 세션 정보 가져오기
  Future<Map<String, dynamic>?> getCurrentSleepSession() async {
    final prefs = await SharedPreferences.getInstance();
    final activeSessionJson = prefs.getString(_activeSleepSessionKey);

    if (activeSessionJson == null) return null;

    final activeSession = json.decode(activeSessionJson);
    final bedTime = DateTime.parse(activeSession['bedTime']);
    final currentTime = DateTime.now();
    final elapsedTime = currentTime.difference(bedTime);

    return {
      'id': activeSession['id'],
      'bedTime': bedTime,
      'elapsedTime': elapsedTime,
    };
  }

  // 수면 기록 저장
  Future<void> _saveSleepSession(SleepSession session) async {
    final prefs = await SharedPreferences.getInstance();
    final sessions = await getSleepSessions();
    sessions.add(session);

    final sessionsJson = sessions.map((s) => s.toJson()).toList();
    await prefs.setString(_sleepSessionsKey, json.encode(sessionsJson));
  }

  // 모든 수면 기록 가져오기
  Future<List<SleepSession>> getSleepSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = prefs.getString(_sleepSessionsKey);

    if (sessionsJson == null) return [];

    final sessionsList = json.decode(sessionsJson) as List;
    return sessionsList.map((s) => SleepSession.fromJson(s)).toList();
  }

  // 특정 기간의 수면 기록 가져오기
  Future<List<SleepSession>> getSleepSessionsInRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final allSessions = await getSleepSessions();
    return allSessions.where((session) {
      return session.bedTime.isAfter(startDate) && session.bedTime.isBefore(endDate);
    }).toList();
  }

  // 오늘의 수면 기록 가져오기 (Health 앱 우선)
  Future<SleepSession?> getTodaySleep() async {
    try {
      // 먼저 Health 앱에서 수면 데이터 시도
      final healthSleep = await getSleepFromHealthApp();
      if (healthSleep != null) {
        return healthSleep;
      }
    } catch (e) {
      print('Health 앱에서 수면 데이터 읽기 실패: $e');
    }

    // Health 앱 데이터가 없으면 수동 기록 확인
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    final sessions = await getSleepSessionsInRange(
      startDate: startOfDay,
      endDate: endOfDay,
    );

    return sessions.isNotEmpty ? sessions.last : null;
  }

  // Health 앱에서 수면 데이터 읽기
  Future<SleepSession?> getSleepFromHealthApp() async {
    final today = DateTime.now();
    final yesterday = today.subtract(Duration(days: 1));
    final startTime = DateTime(yesterday.year, yesterday.month, yesterday.day, 18, 0); // 어제 오후 6시부터
    final endTime = DateTime(today.year, today.month, today.day, 12, 0); // 오늘 낮 12시까지

    List<HealthDataPoint> sleepData = await health.getHealthDataFromTypes(
      types: [HealthDataType.SLEEP_IN_BED, HealthDataType.SLEEP_ASLEEP],
      startTime: startTime,
      endTime: endTime,
    );

    if (sleepData.isEmpty) return null;

    // 수면 데이터를 시간순으로 정렬
    sleepData.sort((a, b) => a.dateFrom.compareTo(b.dateFrom));

    // 첫 번째와 마지막 데이터로 수면 시간 계산
    final bedTime = sleepData.first.dateFrom;
    final wakeTime = sleepData.last.dateTo;
    final sleepDuration = wakeTime.difference(bedTime);

    return SleepSession(
      id: 'health_${bedTime.millisecondsSinceEpoch}',
      bedTime: bedTime,
      wakeTime: wakeTime,
      sleepDuration: sleepDuration,
      quality: SleepQuality.good, // Health 앱에서는 품질 정보가 없으므로 기본값
      notes: 'Health 앱에서 자동 수집',
      isManualEntry: false,
      createdAt: DateTime.now(),
    );
  }

  // 주간 수면 통계 생성
  Future<SleepStats> getWeeklySleepStats() async {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final sessions = await getSleepSessionsInRange(
      startDate: startDate,
      endDate: endDate,
    );

    if (sessions.isEmpty) {
      return SleepStats(
        averageSleepDuration: Duration.zero,
        totalSleepTime: Duration.zero,
        totalSessions: 0,
        averageQualityScore: 0.0,
        startDate: startDate,
        endDate: endDate,
        sessions: [],
      );
    }

    final totalSleepTime = sessions.fold<Duration>(
      Duration.zero,
      (total, session) => total + session.sleepDuration,
    );

    final averageSleepDuration = Duration(
      milliseconds: (totalSleepTime.inMilliseconds / sessions.length).round(),
    );

    final averageQualityScore = sessions.fold<double>(
      0.0,
      (total, session) => total + session.quality.score,
    ) / sessions.length;

    return SleepStats(
      averageSleepDuration: averageSleepDuration,
      totalSleepTime: totalSleepTime,
      totalSessions: sessions.length,
      averageQualityScore: averageQualityScore,
      startDate: startDate,
      endDate: endDate,
      sessions: sessions,
    );
  }

  // 수면 목표 설정
  Future<void> setSleepGoal(SleepGoal goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sleepGoalKey, json.encode(goal.toJson()));
  }

  // 수면 목표 가져오기
  Future<SleepGoal?> getSleepGoal() async {
    final prefs = await SharedPreferences.getInstance();
    final goalJson = prefs.getString(_sleepGoalKey);

    if (goalJson == null) return null;

    return SleepGoal.fromJson(json.decode(goalJson));
  }

  // 수면 기록 삭제
  Future<void> deleteSleepSession(String sessionId) async {
    final sessions = await getSleepSessions();
    sessions.removeWhere((session) => session.id == sessionId);

    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = sessions.map((s) => s.toJson()).toList();
    await prefs.setString(_sleepSessionsKey, json.encode(sessionsJson));
  }

  // 수면 세션 업데이트
  Future<void> updateSleepSession(SleepSession updatedSession) async {
    final sessions = await getSleepSessions();
    final index = sessions.indexWhere((session) => session.id == updatedSession.id);

    if (index != -1) {
      sessions[index] = updatedSession;

      final prefs = await SharedPreferences.getInstance();
      final sessionsJson = sessions.map((s) => s.toJson()).toList();
      await prefs.setString(_sleepSessionsKey, json.encode(sessionsJson));
    }
  }

  // 추천 취침 시간 계산 (목표 기상 시간 기준)
  Duration getRecommendedBedtime(Duration targetWakeTime, Duration targetSleepDuration) {
    final wakeTimeInMinutes = targetWakeTime.inMinutes;
    final sleepDurationInMinutes = targetSleepDuration.inMinutes;
    final bedTimeInMinutes = wakeTimeInMinutes - sleepDurationInMinutes;

    // 다음 날로 넘어가는 경우 처리
    final adjustedBedTime = bedTimeInMinutes < 0
        ? bedTimeInMinutes + (24 * 60)
        : bedTimeInMinutes;

    return Duration(minutes: adjustedBedTime);
  }
}