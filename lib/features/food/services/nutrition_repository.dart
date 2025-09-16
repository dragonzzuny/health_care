import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class NutritionPer100g {
  final double kcal;
  final double carbs;
  final double protein;
  final double fat;
  final double fiber;

  const NutritionPer100g({
    required this.kcal,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.fiber,
  });
}

/// Loads nutrition data from asset JSON if available, else falls back to
/// a small built-in map. Keys should be lowercase canonical names.
class NutritionRepository {
  Map<String, NutritionPer100g>? _cache;
  final Map<String, String> _synonyms = const {
    // Korean synonyms mapping to canonical keys
    '사과': 'apple',
    '바나나': 'banana',
    '김치': 'kimchi',
    '라면': 'ramen',
    '비빔밥': 'bibimbap',
  };

  Future<void> _ensureLoaded() async {
    if (_cache != null) return;
    try {
      final jsonStr = await rootBundle.loadString('assets/nutrition/korean_food_db_min.json');
      final data = json.decode(jsonStr) as Map<String, dynamic>;
      _cache = data.map((k, v) {
        final m = v as Map<String, dynamic>;
        return MapEntry(
          k.toLowerCase(),
          NutritionPer100g(
            kcal: (m['kcal_per_100g'] as num).toDouble(),
            carbs: (m['carbs_g'] as num).toDouble(),
            protein: (m['protein_g'] as num).toDouble(),
            fat: (m['fat_g'] as num).toDouble(),
            fiber: (m['fiber_g'] as num).toDouble(),
          ),
        );
      });
    } catch (_) {
      // Fallback small dataset
      _cache = {
        'apple': const NutritionPer100g(kcal: 52, carbs: 14.0, protein: 0.3, fat: 0.2, fiber: 2.4),
        'banana': const NutritionPer100g(kcal: 89, carbs: 23.0, protein: 1.1, fat: 0.3, fiber: 2.6),
        'kimchi': const NutritionPer100g(kcal: 15, carbs: 2.4, protein: 1.1, fat: 0.5, fiber: 1.6),
        'ramen': const NutritionPer100g(kcal: 436, carbs: 66.0, protein: 10.0, fat: 15.0, fiber: 3.0),
        'bibimbap': const NutritionPer100g(kcal: 169, carbs: 26.0, protein: 5.6, fat: 4.5, fiber: 2.8),
      };
    }
  }

  Future<NutritionPer100g?> findPer100g(String rawLabel) async {
    await _ensureLoaded();
    final label = rawLabel.toLowerCase().trim();
    final canonical = _synonyms[label] ?? label;
    return _cache![canonical];
  }
}

