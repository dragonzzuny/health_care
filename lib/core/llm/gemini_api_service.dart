import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class GeminiApiService {
  final Logger _logger = Logger();
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  
  String? _apiKey;
  String _defaultModelId = 'gemma-3-27b-it';
  
  GeminiApiService({String? apiKey, String? defaultModelId}) {
    _apiKey = apiKey;
    if (defaultModelId != null && defaultModelId.isNotEmpty) {
      _defaultModelId = _normalizeModelId(defaultModelId);
    }
    _setupDio();
  }
  
  void _setupDio() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };
    
    // Add interceptor for logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: false, // Don't log request body for privacy
        responseBody: false, // Don't log response body for privacy
        logPrint: (object) => _logger.d(object),
      ),
    );
  }
  
  void setApiKey(String apiKey) {
    _apiKey = apiKey;
  }
  
  bool get hasApiKey => _apiKey != null && _apiKey!.isNotEmpty;

  String get defaultModelId => _defaultModelId;

  void setDefaultModel(String modelId) {
    if (modelId.trim().isEmpty) return;
    _defaultModelId = _normalizeModelId(modelId);
    _logger.i('Gemini default model set to $_defaultModelId');
  }
  
  Future<String> generateContent({
    required String prompt,
    String? model,
    double temperature = 0.7,
    int maxOutputTokens = 1024,
    List<String>? stopSequences,
  }) async {
    if (!hasApiKey) {
      throw Exception('Gemini API key not provided');
    }
    
    try {
      final targetModel = _normalizeModelId(model ?? _defaultModelId);
      _logger.i('Generating content with Gemini API: $targetModel');
      _logger.d('Prompt preview: ${prompt.length > 100 ? prompt.substring(0, 100) + "..." : prompt}');
      
      final requestData = {
        'contents': [
          {
            'parts': [
              {
                'text': prompt,
              }
            ]
          }
        ],
        'generationConfig': {
          'temperature': temperature,
          'maxOutputTokens': maxOutputTokens,
          if (stopSequences != null) 'stopSequences': stopSequences,
        },
        'safetySettings': [
          {
            'category': 'HARM_CATEGORY_HARASSMENT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
          },
          {
            'category': 'HARM_CATEGORY_HATE_SPEECH',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
          },
          {
            'category': 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
          },
          {
            'category': 'HARM_CATEGORY_DANGEROUS_CONTENT',
            'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
          }
        ]
      };
      
      final response = await _dio.post(
        '/models/$targetModel:generateContent',
        data: requestData,
        options: Options(
          headers: {
            'X-goog-api-key': _apiKey,
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        
        // Extract the generated text
        final candidates = responseData['candidates'] as List<dynamic>?;
        if (candidates != null && candidates.isNotEmpty) {
          final firstCandidate = candidates[0] as Map<String, dynamic>;
          final content = firstCandidate['content'] as Map<String, dynamic>?;
          if (content != null) {
            final parts = content['parts'] as List<dynamic>?;
            if (parts != null && parts.isNotEmpty) {
              final firstPart = parts[0] as Map<String, dynamic>;
              final text = firstPart['text'] as String?;
              if (text != null) {
                _logger.i('Successfully generated ${text.length} characters');
                return text.trim();
              }
            }
          }
        }
        
        // Check for blocked content
        final promptFeedback = responseData['promptFeedback'] as Map<String, dynamic>?;
        if (promptFeedback != null) {
          final blockReason = promptFeedback['blockReason'] as String?;
          if (blockReason != null) {
            throw Exception('Content blocked by safety filter: $blockReason');
          }
        }
        
        throw Exception('No valid response generated');
        
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.statusMessage}');
      }
      
    } on DioException catch (e) {
      _logger.e('Gemini API request failed: ${e.message}');
      
      if (e.response != null) {
        _logger.e('Response status: ${e.response!.statusCode}');
        _logger.e('Response data: ${e.response!.data}');
        
        // Handle specific error cases
        if (e.response!.statusCode == 400) {
          final errorData = e.response!.data as Map<String, dynamic>?;
          if (errorData != null && errorData['error'] != null) {
            final error = errorData['error'] as Map<String, dynamic>;
            final message = error['message'] as String? ?? 'Bad request';
            throw Exception('API Error: $message');
          }
        } else if (e.response!.statusCode == 401) {
          throw Exception('Invalid API key');
        } else if (e.response!.statusCode == 403) {
          throw Exception('API access forbidden - check your API key permissions');
        } else if (e.response!.statusCode == 429) {
          throw Exception('Rate limit exceeded - please try again later');
        }
      }
      
      throw Exception('Network error: ${e.message}');
      
    } catch (e) {
      _logger.e('Unexpected error in Gemini API call: $e');
      rethrow;
    }
  }
  
  Future<String> generateHealthConsultation({
    required String userMessage,
    String? userContext,
    String? conversationHistory,
  }) async {
    // Build a health-focused prompt
    final promptBuilder = StringBuffer();
    
    promptBuilder.writeln('당신은 SignCare AI 건강상담사입니다. 다음 지침을 따라 응답해주세요:');
    promptBuilder.writeln();
    promptBuilder.writeln('1. 친근하고 전문적인 톤으로 응답하세요');
    promptBuilder.writeln('2. 건강 관련 정보를 정확하고 신뢰할 수 있게 제공하세요');
    promptBuilder.writeln('3. 심각한 증상의 경우 의료진 상담을 권하세요');
    promptBuilder.writeln('4. 개인 맞춤형 조언을 제공하되, 일반적인 건강 원칙을 기반으로 하세요');
    promptBuilder.writeln('5. 응답은 한국어로 작성하세요');
    promptBuilder.writeln();
    
    if (userContext != null && userContext.isNotEmpty) {
      promptBuilder.writeln('사용자 정보:');
      promptBuilder.writeln(userContext);
      promptBuilder.writeln();
    }
    
    if (conversationHistory != null && conversationHistory.isNotEmpty) {
      promptBuilder.writeln('이전 대화 내역:');
      promptBuilder.writeln(conversationHistory);
      promptBuilder.writeln();
    }
    
    promptBuilder.writeln('사용자 질문: $userMessage');
    promptBuilder.writeln();
    promptBuilder.writeln('AI 상담사 응답: [Gemma-3 via Gemini API]');
    
    return await generateContent(
      prompt: promptBuilder.toString(),
      temperature: 0.7,
      maxOutputTokens: 800,
      model: _defaultModelId,
    );
  }
  
  Future<bool> testConnection() async {
    if (!hasApiKey) {
      return false;
    }
    
    try {
      await generateContent(
        prompt: '안녕하세요, 연결 테스트입니다.',
        maxOutputTokens: 50,
        model: _defaultModelId,
      );
      return true;
    } catch (e) {
      _logger.w('Connection test failed: $e');
      return false;
    }
  }

  String _normalizeModelId(String raw) {
    final trimmed = raw.trim();
    if (trimmed.startsWith('models/')) {
      return trimmed.substring('models/'.length);
    }
    return trimmed;
  }
}
