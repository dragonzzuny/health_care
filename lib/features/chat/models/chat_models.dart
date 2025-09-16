import 'package:flutter/material.dart';
import '../../../core/llm/llm_router.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final LLMModel? modelUsed;
  final double? confidence;
  final bool isError;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.modelUsed,
    this.confidence,
    this.isError = false,
  });

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    LLMModel? modelUsed,
    double? confidence,
    bool? isError,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      modelUsed: modelUsed ?? this.modelUsed,
      confidence: confidence ?? this.confidence,
      isError: isError ?? this.isError,
    );
  }

  // Get model display name for UI
  String get modelDisplayName {
    switch (modelUsed) {
      case LLMModel.gemma1B:
        return 'Gemma3';
      case LLMModel.exaone24B:
        return 'EXAONE';
      case LLMModel.gpt4o:
        return 'GPT-4o';
      case null:
        return '';
    }
  }

  // Get model color for UI display
  Color get modelColor {
    switch (modelUsed) {
      case LLMModel.gemma1B:
        return const Color(0xFF4CAF50); // Green for Gemma3 (local)
      case LLMModel.exaone24B:
        return const Color(0xFF2196F3); // Blue for EXAONE (local)
      case LLMModel.gpt4o:
        return const Color(0xFFFF9800); // Orange for GPT-4o (cloud)
      case null:
        return const Color(0xFF757575); // Grey for unknown
    }
  }

  // Get confidence level for UI display
  String get confidenceLevel {
    if (confidence == null) return '';
    if (confidence! >= 0.9) return '매우 확신';
    if (confidence! >= 0.8) return '확신';
    if (confidence! >= 0.7) return '보통';
    return '낮음';
  }
}