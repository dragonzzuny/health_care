import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_model.dart';
import '../models/health_data_model.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.signcare.com/v1')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Authentication
  @POST('/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST('/auth/register')
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @POST('/auth/refresh')
  Future<AuthResponse> refreshToken(@Body() RefreshTokenRequest request);

  @POST('/auth/logout')
  Future<void> logout();

  // User Profile
  @GET('/users/profile')
  Future<User> getUserProfile();

  @PUT('/users/profile')
  Future<User> updateUserProfile(@Body() UserProfile profile);

  @POST('/users/profile/image')
  @MultiPart()
  Future<String> uploadProfileImage(@Part() File image);

  // Health Data
  @GET('/health/data')
  Future<List<HealthData>> getHealthData(
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
  );

  @POST('/health/data')
  Future<HealthData> createHealthData(@Body() HealthData data);

  @PUT('/health/data/{id}')
  Future<HealthData> updateHealthData(
    @Path('id') String id,
    @Body() HealthData data,
  );

  @DELETE('/health/data/{id}')
  Future<void> deleteHealthData(@Path('id') String id);

  // Food Recognition
  @POST('/food/recognize')
  @MultiPart()
  Future<FoodRecognitionResponse> recognizeFood(@Part() File image);

  @GET('/food/search')
  Future<List<FoodItem>> searchFood(@Query('query') String query);

  @POST('/food/entries')
  Future<FoodEntry> createFoodEntry(@Body() FoodEntry entry);

  // Exercise
  @GET('/exercise/recommendations')
  Future<List<ExerciseRecommendation>> getExerciseRecommendations();

  @POST('/exercise/entries')
  Future<ExerciseEntry> createExerciseEntry(@Body() ExerciseEntry entry);

  // Body Measurements
  @POST('/body/measurements')
  Future<BodyMeasurement> createBodyMeasurement(@Body() BodyMeasurement measurement);

  @POST('/body/scan')
  @MultiPart()
  Future<BodyScanResult> scanBody(@Part() File frontImage, @Part() File sideImage);

  // Sleep Tracking
  @POST('/sleep/data')
  Future<SleepData> createSleepData(@Body() SleepData data);

  @GET('/sleep/analysis')
  Future<SleepAnalysis> getSleepAnalysis(
    @Query('start_date') String startDate,
    @Query('end_date') String endDate,
  );

  // AI Chat
  @POST('/chat/message')
  Future<ChatResponse> sendChatMessage(@Body() ChatRequest request);

  @GET('/chat/history')
  Future<List<ChatMessage>> getChatHistory(@Query('limit') int limit);

  // Reports
  @GET('/reports/weekly')
  Future<WeeklyReport> getWeeklyReport(@Query('date') String date);

  @GET('/reports/monthly')
  Future<MonthlyReport> getMonthlyReport(@Query('date') String date);

  @GET('/reports/yearly')
  Future<YearlyReport> getYearlyReport(@Query('year') int year);

  // Challenges
  @GET('/challenges')
  Future<List<Challenge>> getChallenges();

  @POST('/challenges/{id}/join')
  Future<void> joinChallenge(@Path('id') String challengeId);

  @POST('/challenges/{id}/progress')
  Future<void> updateChallengeProgress(
    @Path('id') String challengeId,
    @Body() ChallengeProgress progress,
  );

  // Notifications
  @GET('/notifications')
  Future<List<Notification>> getNotifications();

  @PUT('/notifications/{id}/read')
  Future<void> markNotificationAsRead(@Path('id') String notificationId);
}

// Request/Response Models
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

class RegisterRequest {
  final String email;
  final String password;
  final String name;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
      };
}

class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {
        'refresh_token': refreshToken,
      };
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class FoodRecognitionResponse {
  final List<FoodItem> recognizedFoods;
  final double confidence;

  FoodRecognitionResponse({
    required this.recognizedFoods,
    required this.confidence,
  });

  factory FoodRecognitionResponse.fromJson(Map<String, dynamic> json) {
    return FoodRecognitionResponse(
      recognizedFoods: (json['recognized_foods'] as List)
          .map((e) => FoodItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      confidence: (json['confidence'] as num).toDouble(),
    );
  }
}

class FoodItem {
  final String id;
  final String name;
  final double caloriesPerGram;
  final double carbsPerGram;
  final double proteinPerGram;
  final double fatPerGram;
  final double fiberPerGram;

  FoodItem({
    required this.id,
    required this.name,
    required this.caloriesPerGram,
    required this.carbsPerGram,
    required this.proteinPerGram,
    required this.fatPerGram,
    required this.fiberPerGram,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] as String,
      name: json['name'] as String,
      caloriesPerGram: (json['calories_per_gram'] as num).toDouble(),
      carbsPerGram: (json['carbs_per_gram'] as num).toDouble(),
      proteinPerGram: (json['protein_per_gram'] as num).toDouble(),
      fatPerGram: (json['fat_per_gram'] as num).toDouble(),
      fiberPerGram: (json['fiber_per_gram'] as num).toDouble(),
    );
  }
}

class ExerciseRecommendation {
  final String id;
  final String name;
  final String type;
  final String description;
  final int durationMinutes;
  final double estimatedCalories;
  final String difficulty;
  final List<String> targetMuscles;

  ExerciseRecommendation({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.durationMinutes,
    required this.estimatedCalories,
    required this.difficulty,
    required this.targetMuscles,
  });

  factory ExerciseRecommendation.fromJson(Map<String, dynamic> json) {
    return ExerciseRecommendation(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      durationMinutes: json['duration_minutes'] as int,
      estimatedCalories: (json['estimated_calories'] as num).toDouble(),
      difficulty: json['difficulty'] as String,
      targetMuscles: List<String>.from(json['target_muscles'] as List),
    );
  }
}

class BodyScanResult {
  final String id;
  final Map<String, double> measurements;
  final double bodyFatPercentage;
  final String bodyType;
  final List<String> recommendations;

  BodyScanResult({
    required this.id,
    required this.measurements,
    required this.bodyFatPercentage,
    required this.bodyType,
    required this.recommendations,
  });

  factory BodyScanResult.fromJson(Map<String, dynamic> json) {
    return BodyScanResult(
      id: json['id'] as String,
      measurements: Map<String, double>.from(json['measurements'] as Map),
      bodyFatPercentage: (json['body_fat_percentage'] as num).toDouble(),
      bodyType: json['body_type'] as String,
      recommendations: List<String>.from(json['recommendations'] as List),
    );
  }
}

class SleepAnalysis {
  final double averageSleepDuration;
  final double sleepEfficiency;
  final Map<String, double> sleepStagePercentages;
  final List<String> insights;
  final List<String> recommendations;

  SleepAnalysis({
    required this.averageSleepDuration,
    required this.sleepEfficiency,
    required this.sleepStagePercentages,
    required this.insights,
    required this.recommendations,
  });

  factory SleepAnalysis.fromJson(Map<String, dynamic> json) {
    return SleepAnalysis(
      averageSleepDuration: (json['average_sleep_duration'] as num).toDouble(),
      sleepEfficiency: (json['sleep_efficiency'] as num).toDouble(),
      sleepStagePercentages: Map<String, double>.from(json['sleep_stage_percentages'] as Map),
      insights: List<String>.from(json['insights'] as List),
      recommendations: List<String>.from(json['recommendations'] as List),
    );
  }
}

class ChatRequest {
  final String message;
  final String? context;

  ChatRequest({required this.message, this.context});

  Map<String, dynamic> toJson() => {
        'message': message,
        'context': context,
      };
}

class ChatResponse {
  final String message;
  final String? context;
  final List<String>? suggestions;

  ChatResponse({
    required this.message,
    this.context,
    this.suggestions,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      message: json['message'] as String,
      context: json['context'] as String?,
      suggestions: json['suggestions'] != null
          ? List<String>.from(json['suggestions'] as List)
          : null,
    );
  }
}

class ChatMessage {
  final String id;
  final String message;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      message: json['message'] as String,
      isUser: json['is_user'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

// Report Models
class WeeklyReport {
  final String id;
  final DateTime weekStart;
  final DateTime weekEnd;
  final Map<String, dynamic> summary;
  final List<String> insights;
  final List<String> recommendations;

  WeeklyReport({
    required this.id,
    required this.weekStart,
    required this.weekEnd,
    required this.summary,
    required this.insights,
    required this.recommendations,
  });

  factory WeeklyReport.fromJson(Map<String, dynamic> json) {
    return WeeklyReport(
      id: json['id'] as String,
      weekStart: DateTime.parse(json['week_start'] as String),
      weekEnd: DateTime.parse(json['week_end'] as String),
      summary: json['summary'] as Map<String, dynamic>,
      insights: List<String>.from(json['insights'] as List),
      recommendations: List<String>.from(json['recommendations'] as List),
    );
  }
}

class MonthlyReport {
  final String id;
  final DateTime monthStart;
  final DateTime monthEnd;
  final Map<String, dynamic> summary;
  final List<String> insights;
  final List<String> recommendations;

  MonthlyReport({
    required this.id,
    required this.monthStart,
    required this.monthEnd,
    required this.summary,
    required this.insights,
    required this.recommendations,
  });

  factory MonthlyReport.fromJson(Map<String, dynamic> json) {
    return MonthlyReport(
      id: json['id'] as String,
      monthStart: DateTime.parse(json['month_start'] as String),
      monthEnd: DateTime.parse(json['month_end'] as String),
      summary: json['summary'] as Map<String, dynamic>,
      insights: List<String>.from(json['insights'] as List),
      recommendations: List<String>.from(json['recommendations'] as List),
    );
  }
}

class YearlyReport {
  final String id;
  final int year;
  final Map<String, dynamic> summary;
  final List<String> insights;
  final List<String> recommendations;

  YearlyReport({
    required this.id,
    required this.year,
    required this.summary,
    required this.insights,
    required this.recommendations,
  });

  factory YearlyReport.fromJson(Map<String, dynamic> json) {
    return YearlyReport(
      id: json['id'] as String,
      year: json['year'] as int,
      summary: json['summary'] as Map<String, dynamic>,
      insights: List<String>.from(json['insights'] as List),
      recommendations: List<String>.from(json['recommendations'] as List),
    );
  }
}

// Challenge Models
class Challenge {
  final String id;
  final String title;
  final String description;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, dynamic> target;
  final bool isJoined;
  final ChallengeProgress? progress;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.target,
    required this.isJoined,
    this.progress,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      target: json['target'] as Map<String, dynamic>,
      isJoined: json['is_joined'] as bool,
      progress: json['progress'] != null
          ? ChallengeProgress.fromJson(json['progress'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ChallengeProgress {
  final String challengeId;
  final double currentValue;
  final double targetValue;
  final double progressPercentage;
  final DateTime lastUpdated;

  ChallengeProgress({
    required this.challengeId,
    required this.currentValue,
    required this.targetValue,
    required this.progressPercentage,
    required this.lastUpdated,
  });

  factory ChallengeProgress.fromJson(Map<String, dynamic> json) {
    return ChallengeProgress(
      challengeId: json['challenge_id'] as String,
      currentValue: (json['current_value'] as num).toDouble(),
      targetValue: (json['target_value'] as num).toDouble(),
      progressPercentage: (json['progress_percentage'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['last_updated'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'challenge_id': challengeId,
        'current_value': currentValue,
        'target_value': targetValue,
        'progress_percentage': progressPercentage,
        'last_updated': lastUpdated.toIso8601String(),
      };
}

// Notification Model
class Notification {
  final String id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      isRead: json['is_read'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

