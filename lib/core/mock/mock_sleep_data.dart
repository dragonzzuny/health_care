import 'dart:math';

class MockSleepData {
  static const String userId = 'user_001';
  
  // 최근 7일 수면 데이터
  static List<Map<String, dynamic>> getWeeklySleepData() {
    final sleepData = <Map<String, dynamic>>[];
    final now = DateTime.now();
    final random = Random(321); // 일관된 데이터를 위한 시드
    
    // 요일별 수면 패턴 (주말에 늦게 자고 늦게 일어남)
    final weekdaySleepPatterns = [
      {'bedtime': 23, 'wakeup': 7}, // 일요일
      {'bedtime': 22, 'wakeup': 6}, // 월요일
      {'bedtime': 22, 'wakeup': 6}, // 화요일
      {'bedtime': 23, 'wakeup': 6}, // 수요일
      {'bedtime': 22, 'wakeup': 6}, // 목요일
      {'bedtime': 24, 'wakeup': 8}, // 금요일 (늦게)
      {'bedtime': 24, 'wakeup': 8}, // 토요일 (늦게)
    ];
    
    for (int dayOffset = 6; dayOffset >= 0; dayOffset--) {
      final date = now.subtract(Duration(days: dayOffset));
      final dayOfWeek = date.weekday % 7; // 일요일 = 0
      final pattern = weekdaySleepPatterns[dayOfWeek];
      
      // 취침 시간 (전날)
      var bedtimeHour = pattern['bedtime'] as int;
      final bedtimeMinute = 30 + random.nextInt(60); // 30~90분 변동
      
      DateTime bedtime;
      if (bedtimeHour >= 24) {
        bedtime = DateTime(date.year, date.month, date.day, bedtimeHour - 24, bedtimeMinute);
      } else {
        bedtime = DateTime(date.year, date.month, date.day - 1, bedtimeHour, bedtimeMinute);
      }
      
      // 기상 시간
      final wakeupHour = pattern['wakeup'] as int;
      final wakeupMinute = random.nextInt(30); // 0~30분 변동
      final wakeup = DateTime(date.year, date.month, date.day, wakeupHour, wakeupMinute);
      
      // 수면 시간 계산
      final sleepDuration = wakeup.difference(bedtime);
      final totalSleepMinutes = sleepDuration.inMinutes - random.nextInt(30); // 실제 잠든 시간은 약간 적음
      
      // 수면 단계 분포 (분)
      final deepSleepMinutes = (totalSleepMinutes * (0.15 + random.nextDouble() * 0.1)).round(); // 15~25%
      final lightSleepMinutes = (totalSleepMinutes * (0.45 + random.nextDouble() * 0.1)).round(); // 45~55%
      final remSleepMinutes = (totalSleepMinutes * (0.2 + random.nextDouble() * 0.1)).round(); // 20~30%
      final awakeDuringNight = totalSleepMinutes - deepSleepMinutes - lightSleepMinutes - remSleepMinutes;
      
      // 수면 질 점수 (0-100)
      final sleepQualityScore = _calculateSleepQuality(
        totalSleepMinutes, 
        deepSleepMinutes, 
        awakeDuringNight,
        dayOfWeek
      );
      
      // 심박수 데이터
      final avgHeartRate = 55 + random.nextInt(10); // 50~65 bpm (수면 중)
      final restingHeartRate = avgHeartRate + 10 + random.nextInt(8); // 깨어있을 때
      
      sleepData.add({
        'userId': userId,
        'date': DateTime(date.year, date.month, date.day),
        'bedtime': bedtime,
        'wakeupTime': wakeup,
        'totalSleepMinutes': totalSleepMinutes,
        'deepSleepMinutes': deepSleepMinutes,
        'lightSleepMinutes': lightSleepMinutes,
        'remSleepMinutes': remSleepMinutes,
        'awakeMinutes': awakeDuringNight,
        'sleepQualityScore': sleepQualityScore,
        'averageHeartRate': avgHeartRate,
        'restingHeartRate': restingHeartRate,
        'sleepEfficiency': ((totalSleepMinutes / sleepDuration.inMinutes) * 100).round(),
        'timeToFallAsleep': 5 + random.nextInt(20), // 5~25분
        'numberOfAwakenings': random.nextInt(3) + (dayOfWeek > 4 ? 1 : 0), // 주말에 더 많이 깸
        'notes': _getSleepNotes(sleepQualityScore, dayOfWeek, dayOffset),
      });
    }
    
    return sleepData;
  }
  
  // 수면 질 점수 계산
  static int _calculateSleepQuality(int totalMinutes, int deepMinutes, int awakeMinutes, int dayOfWeek) {
    int score = 80; // 기본 점수
    
    // 총 수면 시간 평가 (7-8시간이 최적)
    final totalHours = totalMinutes / 60;
    if (totalHours >= 7 && totalHours <= 8) {
      score += 10;
    } else if (totalHours >= 6 && totalHours < 7) {
      score -= 5;
    } else if (totalHours < 6) {
      score -= 15;
    } else if (totalHours > 9) {
      score -= 10;
    }
    
    // 깊은 잠 비율 평가
    final deepSleepRatio = deepMinutes / totalMinutes;
    if (deepSleepRatio >= 0.15) {
      score += 5;
    } else {
      score -= 10;
    }
    
    // 중간에 깬 시간 평가
    if (awakeMinutes <= 30) {
      score += 5;
    } else if (awakeMinutes > 60) {
      score -= 15;
    }
    
    // 주말 효과 (스트레스 감소로 수면 질 향상)
    if (dayOfWeek == 0 || dayOfWeek == 6) { // 일요일, 토요일
      score += 5;
    }
    
    return score.clamp(30, 100);
  }
  
  // 수면 메모 생성
  static String? _getSleepNotes(int qualityScore, int dayOfWeek, int dayOffset) {
    if (qualityScore >= 85) {
      return dayOffset == 0 ? '오늘 밤 컨디션이 정말 좋았어요!' : 
             dayOffset == 1 ? '어제도 푹 잤네요' : null;
    } else if (qualityScore < 65) {
      final stressReasons = [
        '업무 스트레스로 잠들기 어려웠음',
        '카페인 섭취 영향으로 잠이 얕았음', 
        '늦은 저녁식사로 소화불량',
        '스마트폰 사용으로 늦게 잠듦',
        '주변 소음으로 자주 깸',
      ];
      return stressReasons[dayOffset % stressReasons.length];
    }
    return null;
  }
  
  // 수면 목표 및 설정
  static Map<String, dynamic> getSleepGoals() {
    return {
      'userId': userId,
      'targetBedtime': '23:00',
      'targetWakeupTime': '07:00',
      'targetSleepHours': 8.0,
      'targetSleepQualityScore': 80,
      'deepSleepGoalMinutes': 90, // 최소 90분
      'maxAwakeningsGoal': 2,
    };
  }
  
  // 수면 패턴 분석
  static Map<String, dynamic> getSleepAnalysis() {
    final weekData = getWeeklySleepData();
    
    // 평균 계산
    final avgTotalSleep = weekData.map((d) => d['totalSleepMinutes'] as int).reduce((a, b) => a + b) / weekData.length;
    final avgQuality = weekData.map((d) => d['sleepQualityScore'] as int).reduce((a, b) => a + b) / weekData.length;
    final avgDeepSleep = weekData.map((d) => d['deepSleepMinutes'] as int).reduce((a, b) => a + b) / weekData.length;
    final avgHeartRate = weekData.map((d) => d['averageHeartRate'] as int).reduce((a, b) => a + b) / weekData.length;
    
    // 수면 일관성 (취침/기상 시간 편차)
    final bedtimes = weekData.map((d) => (d['bedtime'] as DateTime).hour * 60 + (d['bedtime'] as DateTime).minute).toList();
    final wakeupTimes = weekData.map((d) => (d['wakeupTime'] as DateTime).hour * 60 + (d['wakeupTime'] as DateTime).minute).toList();
    
    final bedtimeVariation = _calculateVariation(bedtimes);
    final wakeupVariation = _calculateVariation(wakeupTimes);
    
    return {
      'weeklyAverages': {
        'totalSleepHours': (avgTotalSleep / 60).toStringAsFixed(1),
        'qualityScore': avgQuality.round(),
        'deepSleepMinutes': avgDeepSleep.round(),
        'averageHeartRate': avgHeartRate.round(),
      },
      'consistency': {
        'bedtimeVariation': bedtimeVariation, // 분 단위
        'wakeupVariation': wakeupVariation,
        'consistencyScore': _calculateConsistencyScore(bedtimeVariation, wakeupVariation),
      },
      'trends': {
        'qualityTrend': 'improving', // improving, declining, stable
        'durationTrend': 'stable',
        'consistencyTrend': 'improving',
      },
      'recommendations': _getSleepRecommendations(avgTotalSleep, avgQuality, bedtimeVariation),
    };
  }
  
  static double _calculateVariation(List<int> times) {
    if (times.length <= 1) return 0;
    final mean = times.reduce((a, b) => a + b) / times.length;
    final variance = times.map((t) => pow(t - mean, 2)).reduce((a, b) => a + b) / times.length;
    return sqrt(variance);
  }
  
  static int _calculateConsistencyScore(double bedtimeVar, double wakeupVar) {
    final avgVariation = (bedtimeVar + wakeupVar) / 2;
    if (avgVariation <= 30) return 90; // 30분 이내 변동
    if (avgVariation <= 60) return 75; // 1시간 이내
    if (avgVariation <= 90) return 60; // 1.5시간 이내
    return 45; // 그 이상
  }
  
  static List<String> _getSleepRecommendations(double avgSleep, double avgQuality, double bedtimeVar) {
    final recommendations = <String>[];
    
    if (avgSleep < 420) { // 7시간 미만
      recommendations.add('수면 시간을 늘려보세요. 최소 7시간은 주무세요.');
    }
    
    if (avgQuality < 75) {
      recommendations.add('수면의 질을 높이기 위해 취침 전 스마트폰 사용을 줄여보세요.');
      recommendations.add('저녁 늦은 시간 카페인 섭취를 피해보세요.');
    }
    
    if (bedtimeVar > 60) {
      recommendations.add('일정한 취침 시간을 유지해보세요.');
    }
    
    recommendations.add('규칙적인 운동은 수면의 질을 높여줍니다.');
    
    return recommendations;
  }
}