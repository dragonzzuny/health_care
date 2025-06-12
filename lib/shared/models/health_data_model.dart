// Health Data Model
class HealthData {
  final String id;
  final String userId;
  final DateTime date;
  final int? steps;
  final double? caloriesBurned;
  final double? distance; // km
  final int? activeMinutes;
  final double? waterIntake; // liters
  final SleepData? sleepData;
  final List<FoodEntry> foodEntries;
  final List<ExerciseEntry> exerciseEntries;
  final BodyMeasurement? bodyMeasurement;

  const HealthData({
    required this.id,
    required this.userId,
    required this.date,
    this.steps,
    this.caloriesBurned,
    this.distance,
    this.activeMinutes,
    this.waterIntake,
    this.sleepData,
    this.foodEntries = const [],
    this.exerciseEntries = const [],
    this.bodyMeasurement,
  });

  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      date: DateTime.parse(json['date'] as String),
      steps: json['steps'] as int?,
      caloriesBurned: (json['calories_burned'] as num?)?.toDouble(),
      distance: (json['distance'] as num?)?.toDouble(),
      activeMinutes: json['active_minutes'] as int?,
      waterIntake: (json['water_intake'] as num?)?.toDouble(),
      sleepData: json['sleep_data'] != null
          ? SleepData.fromJson(json['sleep_data'] as Map<String, dynamic>)
          : null,
      foodEntries: (json['food_entries'] as List?)
              ?.map((e) => FoodEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      exerciseEntries: (json['exercise_entries'] as List?)
              ?.map((e) => ExerciseEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      bodyMeasurement: json['body_measurement'] != null
          ? BodyMeasurement.fromJson(json['body_measurement'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'steps': steps,
      'calories_burned': caloriesBurned,
      'distance': distance,
      'active_minutes': activeMinutes,
      'water_intake': waterIntake,
      'sleep_data': sleepData?.toJson(),
      'food_entries': foodEntries.map((e) => e.toJson()).toList(),
      'exercise_entries': exerciseEntries.map((e) => e.toJson()).toList(),
      'body_measurement': bodyMeasurement?.toJson(),
    };
  }
}

// Sleep Data Model
class SleepData {
  final DateTime bedtime;
  final DateTime wakeTime;
  final Duration totalSleep;
  final Duration deepSleep;
  final Duration lightSleep;
  final Duration remSleep;
  final int sleepQuality; // 1-5 scale

  const SleepData({
    required this.bedtime,
    required this.wakeTime,
    required this.totalSleep,
    required this.deepSleep,
    required this.lightSleep,
    required this.remSleep,
    required this.sleepQuality,
  });

  factory SleepData.fromJson(Map<String, dynamic> json) {
    return SleepData(
      bedtime: DateTime.parse(json['bedtime'] as String),
      wakeTime: DateTime.parse(json['wake_time'] as String),
      totalSleep: Duration(minutes: json['total_sleep_minutes'] as int),
      deepSleep: Duration(minutes: json['deep_sleep_minutes'] as int),
      lightSleep: Duration(minutes: json['light_sleep_minutes'] as int),
      remSleep: Duration(minutes: json['rem_sleep_minutes'] as int),
      sleepQuality: json['sleep_quality'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bedtime': bedtime.toIso8601String(),
      'wake_time': wakeTime.toIso8601String(),
      'total_sleep_minutes': totalSleep.inMinutes,
      'deep_sleep_minutes': deepSleep.inMinutes,
      'light_sleep_minutes': lightSleep.inMinutes,
      'rem_sleep_minutes': remSleep.inMinutes,
      'sleep_quality': sleepQuality,
    };
  }

  String get sleepQualityText {
    switch (sleepQuality) {
      case 1:
        return '매우 나쁨';
      case 2:
        return '나쁨';
      case 3:
        return '보통';
      case 4:
        return '좋음';
      case 5:
        return '매우 좋음';
      default:
        return '알 수 없음';
    }
  }
}

// Food Entry Model
class FoodEntry {
  final String id;
  final String name;
  final String mealType; // breakfast, lunch, dinner, snack
  final DateTime timestamp;
  final double calories;
  final double carbs; // grams
  final double protein; // grams
  final double fat; // grams
  final double fiber; // grams
  final String? imageUrl;

  const FoodEntry({
    required this.id,
    required this.name,
    required this.mealType,
    required this.timestamp,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.fiber,
    this.imageUrl,
  });

  factory FoodEntry.fromJson(Map<String, dynamic> json) {
    return FoodEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      mealType: json['meal_type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      calories: (json['calories'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'meal_type': mealType,
      'timestamp': timestamp.toIso8601String(),
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
      'fiber': fiber,
      'image_url': imageUrl,
    };
  }
}

// Exercise Entry Model
class ExerciseEntry {
  final String id;
  final String name;
  final String type; // cardio, strength, flexibility, sports
  final DateTime startTime;
  final Duration duration;
  final double? caloriesBurned;
  final int? heartRateAvg;
  final int? heartRateMax;
  final String? notes;

  const ExerciseEntry({
    required this.id,
    required this.name,
    required this.type,
    required this.startTime,
    required this.duration,
    this.caloriesBurned,
    this.heartRateAvg,
    this.heartRateMax,
    this.notes,
  });

  factory ExerciseEntry.fromJson(Map<String, dynamic> json) {
    return ExerciseEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      startTime: DateTime.parse(json['start_time'] as String),
      duration: Duration(minutes: json['duration_minutes'] as int),
      caloriesBurned: (json['calories_burned'] as num?)?.toDouble(),
      heartRateAvg: json['heart_rate_avg'] as int?,
      heartRateMax: json['heart_rate_max'] as int?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'start_time': startTime.toIso8601String(),
      'duration_minutes': duration.inMinutes,
      'calories_burned': caloriesBurned,
      'heart_rate_avg': heartRateAvg,
      'heart_rate_max': heartRateMax,
      'notes': notes,
    };
  }
}

// Body Measurement Model
class BodyMeasurement {
  final String id;
  final DateTime date;
  final double weight; // kg
  final double? bodyFatPercentage;
  final double? muscleMass; // kg
  final double? visceralFat;
  final double? boneMass; // kg
  final double? waterPercentage;
  final int? basalMetabolicRate; // kcal

  const BodyMeasurement({
    required this.id,
    required this.date,
    required this.weight,
    this.bodyFatPercentage,
    this.muscleMass,
    this.visceralFat,
    this.boneMass,
    this.waterPercentage,
    this.basalMetabolicRate,
  });

  factory BodyMeasurement.fromJson(Map<String, dynamic> json) {
    return BodyMeasurement(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num).toDouble(),
      bodyFatPercentage: (json['body_fat_percentage'] as num?)?.toDouble(),
      muscleMass: (json['muscle_mass'] as num?)?.toDouble(),
      visceralFat: (json['visceral_fat'] as num?)?.toDouble(),
      boneMass: (json['bone_mass'] as num?)?.toDouble(),
      waterPercentage: (json['water_percentage'] as num?)?.toDouble(),
      basalMetabolicRate: json['basal_metabolic_rate'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'weight': weight,
      'body_fat_percentage': bodyFatPercentage,
      'muscle_mass': muscleMass,
      'visceral_fat': visceralFat,
      'bone_mass': boneMass,
      'water_percentage': waterPercentage,
      'basal_metabolic_rate': basalMetabolicRate,
    };
  }
}

