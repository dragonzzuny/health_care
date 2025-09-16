import 'dart:math';

class MockActivityData {
  static const String userId = 'user_001';
  
  // 일주일치 활동 데이터
  static List<Map<String, dynamic>> getWeeklyActivityData() {
    final activities = <Map<String, dynamic>>[];
    final now = DateTime.now();
    final random = Random(123); // 일관된 데이터를 위한 시드
    
    // 요일별 활동 패턴 (월요일이 가장 활발, 주말이 상대적으로 느슨)
    final weekdayMultipliers = [1.0, 1.1, 0.9, 1.2, 0.8, 0.6, 0.7]; // 일~토
    
    for (int dayOffset = 6; dayOffset >= 0; dayOffset--) {
      final date = now.subtract(Duration(days: dayOffset));
      final dayOfWeek = date.weekday % 7; // 일요일 = 0, 월요일 = 1, ...
      final multiplier = weekdayMultipliers[dayOfWeek];
      
      // 기본 걸음 수: 6000~9000보 (목표 10000보)
      final baseSteps = 6000 + random.nextInt(3000);
      final steps = (baseSteps * multiplier).round();
      
      // 활동 시간 (분)
      final lightActivityMinutes = (120 + random.nextInt(60)) * multiplier; // 가벼운 활동
      final moderateActivityMinutes = (30 + random.nextInt(40)) * multiplier; // 중간 강도
      final vigorousActivityMinutes = dayOffset % 3 == 0 ? (15 + random.nextInt(20)) * multiplier : 0; // 고강도 (3일에 한번)
      
      // 칼로리 소모 계산 (대략적)
      final caloriesBurned = (steps * 0.04) + // 걸음당 0.04kcal
                           (lightActivityMinutes * 2.5) + // 가벼운 활동
                           (moderateActivityMinutes * 4.0) + // 중간 강도
                           (vigorousActivityMinutes * 7.0); // 고강도
      
      activities.add({
        'userId': userId,
        'date': DateTime(date.year, date.month, date.day),
        'steps': steps,
        'distanceMeters': (steps * 0.75).round(), // 걸음 수의 0.75m
        'caloriesBurned': caloriesBurned.round(),
        'activeMinutes': (moderateActivityMinutes + vigorousActivityMinutes).round(),
        'lightActivityMinutes': lightActivityMinutes.round(),
        'moderateActivityMinutes': moderateActivityMinutes.round(),
        'vigorousActivityMinutes': vigorousActivityMinutes.round(),
        'sedentaryMinutes': (1440 - lightActivityMinutes - moderateActivityMinutes - vigorousActivityMinutes).round(),
        'heartRateAverage': 72 + random.nextInt(8), // 72~80 bpm
        'heartRateMax': 140 + random.nextInt(20), // 140~160 bpm
      });
    }
    
    return activities;
  }

  // 운동 세션 데이터
  static List<Map<String, dynamic>> getWorkoutSessions() {
    final workouts = <Map<String, dynamic>>[];
    final now = DateTime.now();
    
    // 최근 2주간 운동 세션 (주 3회)
    final workoutTypes = [
      {
        'type': 'running',
        'name': '조깅',
        'duration': 30,
        'calories': 300,
        'description': '근처 공원에서 가벼운 조깅',
      },
      {
        'type': 'strength_training',
        'name': '웨이트 트레이닝',
        'duration': 45,
        'calories': 280,
        'description': '헬스장에서 근력 운동',
      },
      {
        'type': 'cycling',
        'name': '자전거 타기',
        'duration': 40,
        'calories': 350,
        'description': '한강 자전거 도로',
      },
      {
        'type': 'swimming',
        'name': '수영',
        'duration': 35,
        'calories': 400,
        'description': '구민 수영장에서',
      },
    ];

    // 주 3회, 최근 2주간
    final workoutDays = [1, 3, 5]; // 월, 수, 금
    
    for (int weekOffset = 0; weekOffset < 2; weekOffset++) {
      for (int dayIndex in workoutDays) {
        final workoutDate = now.subtract(Duration(days: (weekOffset * 7) + (7 - dayIndex)));
        final workoutType = workoutTypes[(weekOffset * 3 + workoutDays.indexOf(dayIndex)) % workoutTypes.length];
        
        workouts.add({
          'userId': userId,
          'date': DateTime(workoutDate.year, workoutDate.month, workoutDate.day),
          'startTime': DateTime(workoutDate.year, workoutDate.month, workoutDate.day, 18 + (dayIndex % 2), 30),
          'endTime': DateTime(workoutDate.year, workoutDate.month, workoutDate.day, 18 + (dayIndex % 2), 30 + (workoutType['duration'] as int)),
          'type': workoutType['type'],
          'name': workoutType['name'],
          'duration': workoutType['duration'],
          'caloriesBurned': workoutType['calories'],
          'notes': workoutType['description'],
          'intensity': dayIndex == 5 ? 'high' : 'moderate', // 금요일은 고강도
        });
      }
    }
    
    return workouts;
  }

  // 일일 목표 및 달성률
  static Map<String, dynamic> getDailyGoals() {
    return {
      'userId': userId,
      'stepsGoal': 10000,
      'caloriesBurnedGoal': 400,
      'activeMinutesGoal': 60,
      'workoutsPerWeekGoal': 3,
      'distanceGoal': 7500, // 미터
    };
  }

  // 최근 7일 목표 달성률
  static List<Map<String, dynamic>> getWeeklyProgress() {
    final progress = <Map<String, dynamic>>[];
    final activities = getWeeklyActivityData();
    final goals = getDailyGoals();
    
    for (var activity in activities) {
      final stepsProgress = (activity['steps'] as int) / (goals['stepsGoal'] as int);
      final caloriesProgress = (activity['caloriesBurned'] as int) / (goals['caloriesBurnedGoal'] as int);
      final activeMinutesProgress = (activity['activeMinutes'] as int) / (goals['activeMinutesGoal'] as int);
      final distanceProgress = (activity['distanceMeters'] as int) / (goals['distanceGoal'] as int);
      
      progress.add({
        'date': activity['date'],
        'stepsProgress': stepsProgress.clamp(0.0, 1.5), // 최대 150%
        'caloriesProgress': caloriesProgress.clamp(0.0, 1.5),
        'activeMinutesProgress': activeMinutesProgress.clamp(0.0, 1.5),
        'distanceProgress': distanceProgress.clamp(0.0, 1.5),
        'overallProgress': ([stepsProgress, caloriesProgress, activeMinutesProgress, distanceProgress]
                              .reduce((a, b) => a + b)) / 4,
      });
    }
    
    return progress;
  }

  // 체중 기록 (주 2회 측정)
  static List<Map<String, dynamic>> getWeightHistory() {
    final weights = <Map<String, dynamic>>[];
    final now = DateTime.now();
    final startWeight = 78.0; // kg
    final targetWeight = 70.0; // kg
    
    // 최근 4주간 주 2회 측정 (수요일, 일요일)
    for (int weekOffset = 0; weekOffset < 4; weekOffset++) {
      // 수요일 측정
      final wedDate = now.subtract(Duration(days: (weekOffset * 7) + 3));
      final wedWeight = startWeight - (weekOffset * 0.4) + (Random(42).nextDouble() * 0.6 - 0.3);
      
      weights.add({
        'userId': userId,
        'date': DateTime(wedDate.year, wedDate.month, wedDate.day),
        'weight': double.parse(wedWeight.toStringAsFixed(1)),
        'bodyFatPercentage': 18.5 - (weekOffset * 0.2), // 체지방률도 감소
        'muscleMass': 58.0 + (weekOffset * 0.1), // 근육량 증가
        'notes': weekOffset == 0 ? '목표까지 ${(wedWeight - targetWeight).toStringAsFixed(1)}kg 남음' : null,
      });
      
      // 일요일 측정
      final sunDate = now.subtract(Duration(days: (weekOffset * 7)));
      final sunWeight = startWeight - (weekOffset * 0.4) - 0.2 + (Random(43).nextDouble() * 0.4 - 0.2);
      
      weights.add({
        'userId': userId,
        'date': DateTime(sunDate.year, sunDate.month, sunDate.day),
        'weight': double.parse(sunWeight.toStringAsFixed(1)),
        'bodyFatPercentage': 18.3 - (weekOffset * 0.2),
        'muscleMass': 58.1 + (weekOffset * 0.1),
        'notes': '주말 측정',
      });
    }
    
    return weights.reversed.toList(); // 시간순 정렬
  }
}