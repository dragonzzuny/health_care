import 'dart:ui';

class Detection {
  final Rect bbox; // image coordinate space
  final String label;
  final double score; // 0..1

  const Detection({required this.bbox, required this.label, required this.score});
}

class RecognizedFoodItem {
  final String label;
  final double confidence; // 0..1
  final int grams; // editable amount

  // Per 100g nutrition (if available)
  final double kcalPer100g;
  final double carbsPer100g;
  final double proteinPer100g;
  final double fatPer100g;

  const RecognizedFoodItem({
    required this.label,
    required this.confidence,
    required this.grams,
    required this.kcalPer100g,
    required this.carbsPer100g,
    required this.proteinPer100g,
    required this.fatPer100g,
  });

  RecognizedFoodItem copyWith({int? grams}) => RecognizedFoodItem(
        label: label,
        confidence: confidence,
        grams: grams ?? this.grams,
        kcalPer100g: kcalPer100g,
        carbsPer100g: carbsPer100g,
        proteinPer100g: proteinPer100g,
        fatPer100g: fatPer100g,
      );

  double get calories => kcalPer100g * grams / 100.0;
  double get carbs => carbsPer100g * grams / 100.0;
  double get protein => proteinPer100g * grams / 100.0;
  double get fat => fatPer100g * grams / 100.0;
}
