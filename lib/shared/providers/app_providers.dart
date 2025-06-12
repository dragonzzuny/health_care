import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../../core/constants/app_constants.dart';

// Dio Provider
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    connectTimeout: AppConstants.apiTimeout,
    receiveTimeout: AppConstants.apiTimeout,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Add interceptors
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (object) {
      // Use logger package in production
      print(object);
    },
  ));

  // Add auth interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString(AppConstants.userTokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Token expired, try to refresh
          final prefs = await SharedPreferences.getInstance();
          final refreshToken = prefs.getString('refresh_token');
          if (refreshToken != null) {
            try {
              final apiService = ApiService(dio);
              final response = await apiService.refreshToken(
                RefreshTokenRequest(refreshToken: refreshToken),
              );
              
              // Save new tokens
              await prefs.setString(AppConstants.userTokenKey, response.accessToken);
              await prefs.setString('refresh_token', response.refreshToken);
              
              // Retry original request
              final options = error.requestOptions;
              options.headers['Authorization'] = 'Bearer ${response.accessToken}';
              final retryResponse = await dio.fetch(options);
              handler.resolve(retryResponse);
              return;
            } catch (e) {
              // Refresh failed, redirect to login
              await prefs.clear();
              // TODO: Navigate to login screen
            }
          }
        }
        handler.next(error);
      },
    ),
  );

  return dio;
});

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio);
});

// Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized');
});

// Initialize SharedPreferences
final sharedPreferencesInitProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// Auth State Provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthStateNotifier(apiService, ref);
});

// Auth State
class AuthState {
  final bool isAuthenticated;
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Auth State Notifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;
  final Ref _ref;

  AuthStateNotifier(this._apiService, this._ref) : super(const AuthState()) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConstants.userTokenKey);
      
      if (token != null) {
        final user = await _apiService.getUserProfile();
        state = state.copyWith(
          isAuthenticated: true,
          user: user,
        );
      }
    } catch (e) {
      // Token is invalid, clear it
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await _apiService.login(
        LoginRequest(email: email, password: password),
      );
      
      // Save tokens
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.userTokenKey, response.accessToken);
      await prefs.setString('refresh_token', response.refreshToken);
      
      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> register(String email, String password, String name) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await _apiService.register(
        RegisterRequest(email: email, password: password, name: name),
      );
      
      // Save tokens
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.userTokenKey, response.accessToken);
      await prefs.setString('refresh_token', response.refreshToken);
      
      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (e) {
      // Ignore logout errors
    } finally {
      // Clear local data
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      state = const AuthState();
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    try {
      final updatedUser = await _apiService.updateUserProfile(profile);
      state = state.copyWith(user: updatedUser);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// Health Data Provider
final healthDataProvider = StateNotifierProvider<HealthDataNotifier, HealthDataState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return HealthDataNotifier(apiService);
});

class HealthDataState {
  final List<HealthData> data;
  final bool isLoading;
  final String? error;

  const HealthDataState({
    this.data = const [],
    this.isLoading = false,
    this.error,
  });

  HealthDataState copyWith({
    List<HealthData>? data,
    bool? isLoading,
    String? error,
  }) {
    return HealthDataState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HealthDataNotifier extends StateNotifier<HealthDataState> {
  final ApiService _apiService;

  HealthDataNotifier(this._apiService) : super(const HealthDataState());

  Future<void> loadHealthData(DateTime startDate, DateTime endDate) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final data = await _apiService.getHealthData(
        startDate.toIso8601String(),
        endDate.toIso8601String(),
      );
      
      state = state.copyWith(
        data: data,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> addHealthData(HealthData data) async {
    try {
      final newData = await _apiService.createHealthData(data);
      state = state.copyWith(
        data: [...state.data, newData],
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> updateHealthData(String id, HealthData data) async {
    try {
      final updatedData = await _apiService.updateHealthData(id, data);
      final newDataList = state.data.map((item) {
        return item.id == id ? updatedData : item;
      }).toList();
      
      state = state.copyWith(data: newDataList);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteHealthData(String id) async {
    try {
      await _apiService.deleteHealthData(id);
      final newDataList = state.data.where((item) => item.id != id).toList();
      state = state.copyWith(data: newDataList);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

// Food Recognition Provider
final foodRecognitionProvider = StateNotifierProvider<FoodRecognitionNotifier, FoodRecognitionState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return FoodRecognitionNotifier(apiService);
});

class FoodRecognitionState {
  final List<FoodItem> recognizedFoods;
  final bool isLoading;
  final String? error;

  const FoodRecognitionState({
    this.recognizedFoods = const [],
    this.isLoading = false,
    this.error,
  });

  FoodRecognitionState copyWith({
    List<FoodItem>? recognizedFoods,
    bool? isLoading,
    String? error,
  }) {
    return FoodRecognitionState(
      recognizedFoods: recognizedFoods ?? this.recognizedFoods,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class FoodRecognitionNotifier extends StateNotifier<FoodRecognitionState> {
  final ApiService _apiService;

  FoodRecognitionNotifier(this._apiService) : super(const FoodRecognitionState());

  Future<void> recognizeFood(File image) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await _apiService.recognizeFood(image);
      state = state.copyWith(
        recognizedFoods: response.recognizedFoods,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<List<FoodItem>> searchFood(String query) async {
    try {
      return await _apiService.searchFood(query);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return [];
    }
  }
}

// Chat Provider
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ChatNotifier(apiService);
});

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ChatNotifier extends StateNotifier<ChatState> {
  final ApiService _apiService;

  ChatNotifier(this._apiService) : super(const ChatState()) {
    _loadChatHistory();
  }

  Future<void> _loadChatHistory() async {
    try {
      final messages = await _apiService.getChatHistory(50);
      state = state.copyWith(messages: messages);
    } catch (e) {
      // Ignore initial load errors
    }
  }

  Future<void> sendMessage(String message, {String? context}) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final response = await _apiService.sendChatMessage(
        ChatRequest(message: message, context: context),
      );
      
      // Add user message and AI response
      final userMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message,
        isUser: true,
        timestamp: DateTime.now(),
      );
      
      final aiMessage = ChatMessage(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        message: response.message,
        isUser: false,
        timestamp: DateTime.now(),
      );
      
      state = state.copyWith(
        messages: [...state.messages, userMessage, aiMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearMessages() {
    state = state.copyWith(messages: []);
  }
}

