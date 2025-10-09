import 'dart:math';

class MockFoodData {
  static const String userId = 'user_001';

  // 가상 사용자: 김건강 (35세, 남성, 체중감량 목표)
  static const Map<String, dynamic> userProfile = {
    'name': '김건강',
    'age': 35,
    'gender': 'male',
    'height': 175, // cm
    'weight': 78, // kg
    'targetWeight': 70, // kg
    'goal': 'weight_loss',
    'activityLevel': 'moderate',
    'dailyCalorieGoal': 1800.0,
    'dailyCarbsGoal': 180.0,
    'dailyProteinGoal': 90.0,
    'dailyFatGoal': 60.0,
    'dailyFiberGoal': 25.0,
  };

  // 7일치 식사 데이터 (최근 일주일)
  static List<Map<String, dynamic>> getWeeklyMealData() {
    final List<Map<String, dynamic>> meals = [];
    final now = DateTime.now();
    final random = Random(42); // 일관된 데이터를 위한 시드

    // 음식 ID와 이름 매핑 (한국음식 데이터베이스 기준)
    final breakfastOptions = [
      {'id': 1, 'name': '김치찌개', 'portion': 150.0}, // 한 그릇
      {'id': 2, 'name': '현미밥', 'portion': 100.0}, // 한 공기
      {'id': 8, 'name': '사과', 'portion': 150.0}, // 중간 크기 1개
    ];

    final lunchOptions = [
      {'id': 3, 'name': '비빔밥', 'portion': 250.0}, // 한 그릇
      {'id': 4, 'name': '된장찌개', 'portion': 120.0}, // 한 그릇
      {'id': 9, 'name': '바나나', 'portion': 120.0}, // 중간 크기 1개
    ];

    final dinnerOptions = [
      {'id': 5, 'name': '닭가슴살', 'portion': 150.0}, // 구운 것
      {'id': 6, 'name': '브로콜리', 'portion': 100.0}, // 한 컵
      {'id': 2, 'name': '현미밥', 'portion': 80.0}, // 작은 공기
    ];

    final snackOptions = [
      {'id': 9, 'name': '바나나', 'portion': 100.0},
      {'id': 10, 'name': '아몬드', 'portion': 30.0}, // 한 줌
      {'id': 8, 'name': '사과', 'portion': 120.0},
    ];

    for (int dayOffset = 6; dayOffset >= 0; dayOffset--) {
      final date = now.subtract(Duration(days: dayOffset));

      // 아침 식사 (7:30 AM)
      final breakfastTime = DateTime(date.year, date.month, date.day, 7, 30);
      final breakfast = breakfastOptions[dayOffset % breakfastOptions.length];
      meals.add({
        'userId': userId,
        'foodId': breakfast['id'],
        'foodName': breakfast['name'],
        'portionGrams': breakfast['portion'],
        'mealType': 'breakfast',
        'timestamp': breakfastTime,
        'notes': '집에서 준비한 건강한 아침식사',
      });

      // 점심 식사 (12:30 PM)
      final lunchTime = DateTime(date.year, date.month, date.day, 12, 30);
      final lunch = lunchOptions[dayOffset % lunchOptions.length];
      meals.add({
        'userId': userId,
        'foodId': lunch['id'],
        'foodName': lunch['name'],
        'portionGrams': lunch['portion'],
        'mealType': 'lunch',
        'timestamp': lunchTime,
        'notes': '직장 근처 식당에서',
      });

      // 저녁 식사 (7:00 PM)
      final dinnerTime = DateTime(date.year, date.month, date.day, 19, 0);
      final dinner = dinnerOptions[dayOffset % dinnerOptions.length];
      meals.add({
        'userId': userId,
        'foodId': dinner['id'],
        'foodName': dinner['name'],
        'portionGrams': dinner['portion'],
        'mealType': 'dinner',
        'timestamp': dinnerTime,
        'notes': '가족과 함께하는 저녁식사',
      });

      // 간식 (랜덤하게 하루 걸러 하루)
      if (dayOffset % 2 == 0) {
        final snackTime = DateTime(date.year, date.month, date.day, 15, 30);
        final snack = snackOptions[dayOffset % snackOptions.length];
        meals.add({
          'userId': userId,
          'foodId': snack['id'],
          'foodName': snack['name'],
          'portionGrams': snack['portion'],
          'mealType': 'snack',
          'timestamp': snackTime,
          'notes': '오후 간식',
        });
      }
    }

    return meals;
  }

  // 즐겨찾는 포션 데이터
  static List<Map<String, dynamic>> getFavoritePortions() {
    return [
      {
        'userId': userId,
        'foodId': 2, // 현미밥
        'portionGrams': 100.0,
        'nickname': '내가 먹는 밥 한공기',
        'usageCount': 15,
      },
      {
        'userId': userId,
        'foodId': 1, // 김치찌개
        'portionGrams': 150.0,
        'nickname': '적당한 한그릇',
        'usageCount': 8,
      },
      {
        'userId': userId,
        'foodId': 5, // 닭가슴살
        'portionGrams': 150.0,
        'nickname': '운동 후 단백질',
        'usageCount': 12,
      },
    ];
  }

  // 사용자 설정
  static Map<String, dynamic> getUserPreferences() {
    return {
      'userId': userId,
      'goal': userProfile['goal'],
      'activityLevel': userProfile['activityLevel'],
      'dailyCalorieGoal': userProfile['dailyCalorieGoal'],
      'dailyCarbsGoal': userProfile['dailyCarbsGoal'],
      'dailyProteinGoal': userProfile['dailyProteinGoal'],
      'dailyFatGoal': userProfile['dailyFatGoal'],
      'dailyFiberGoal': userProfile['dailyFiberGoal'],
      'height': userProfile['height'].toDouble(),
      'weight': userProfile['weight'].toDouble(),
      'targetWeight': userProfile['targetWeight'].toDouble(),
      'birthDate': DateTime(1988, 5, 15),
      'gender': userProfile['gender'],
    };
  }

  // 최근 식사 패턴 분석을 위한 통계 데이터
  static List<Map<String, dynamic>> getFoodStatistics() {
    return [
      {
        'userId': userId,
        'foodId': 2, // 현미밥
        'foodType': 'standard',
        'totalConsumptions': 20,
        'averagePortionGrams': 95.0,
        'preferenceScore': 0.8,
        'lastConsumedAt': DateTime.now().subtract(const Duration(hours: 12)),
        'firstConsumedAt': DateTime.now().subtract(const Duration(days: 30)),
      },
      {
        'userId': userId,
        'foodId': 1, // 김치찌개
        'foodType': 'standard',
        'totalConsumptions': 12,
        'averagePortionGrams': 145.0,
        'preferenceScore': 0.9,
        'lastConsumedAt': DateTime.now().subtract(const Duration(days: 1)),
        'firstConsumedAt': DateTime.now().subtract(const Duration(days: 25)),
      },
      {
        'userId': userId,
        'foodId': 5, // 닭가슴살
        'foodType': 'standard',
        'totalConsumptions': 18,
        'averagePortionGrams': 140.0,
        'preferenceScore': 0.7,
        'lastConsumedAt': DateTime.now().subtract(const Duration(days: 2)),
        'firstConsumedAt': DateTime.now().subtract(const Duration(days: 28)),
      },
    ];
  }

  // 영양 목표 달성 패턴 (최근 7일)
  static List<Map<String, dynamic>> getNutritionGoalProgress() {
    final progress = <Map<String, dynamic>>[];
    final now = DateTime.now();

    for (int dayOffset = 6; dayOffset >= 0; dayOffset--) {
      final date = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: dayOffset));

      // 랜덤하지만 현실적인 달성률 생성
      final calorieProgress = 0.75 + (dayOffset * 0.05) % 0.4; // 75% ~ 115%
      final proteinProgress = 0.8 + (dayOffset * 0.03) % 0.3; // 80% ~ 110%
      final carbsProgress = 0.7 + (dayOffset * 0.04) % 0.35; // 70% ~ 105%
      final fatProgress = 0.65 + (dayOffset * 0.06) % 0.45; // 65% ~ 110%

      progress.add({
        'date': date,
        'calorieGoalProgress': calorieProgress,
        'proteinGoalProgress': proteinProgress,
        'carbsGoalProgress': carbsProgress,
        'fatGoalProgress': fatProgress,
        'overallScore':
            (calorieProgress + proteinProgress + carbsProgress + fatProgress) /
                4,
      });
    }

    return progress;
  }
}
