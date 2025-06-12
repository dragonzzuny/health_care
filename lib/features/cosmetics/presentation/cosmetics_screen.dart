import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';

class CosmeticsScreen extends ConsumerStatefulWidget {
  const CosmeticsScreen({super.key});

  @override
  ConsumerState<CosmeticsScreen> createState() => _CosmeticsScreenState();
}

class _CosmeticsScreenState extends ConsumerState<CosmeticsScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();
  
  List<CosmeticProduct> _products = [];
  List<String> _userAllergies = ['파라벤', '황산염', '인공향료'];
  bool _isProcessing = false;

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _scanCosmetic() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image == null) return;

      setState(() {
        _isProcessing = true;
      });

      final inputImage = InputImage.fromFilePath(image.path);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      await _processIngredients(recognizedText.text);
    } catch (e) {
      _showError('스캔 중 오류가 발생했습니다: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _processIngredients(String text) async {
    final ingredients = await _extractIngredients(text);
    final allergyAnalysis = _analyzeAllergies(ingredients);
    
    final product = CosmeticProduct(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _extractProductName(text) ?? '스캔된 제품',
      brand: _extractBrand(text) ?? '알 수 없음',
      ingredients: ingredients,
      allergyRisk: allergyAnalysis,
      scanDate: DateTime.now(),
    );

    setState(() {
      _products.add(product);
    });

    if (allergyAnalysis.hasRisk) {
      _showAllergyWarning(allergyAnalysis);
    } else {
      _showSuccess('제품이 안전하게 분석되었습니다');
    }
  }

  Future<List<String>> _extractIngredients(String text) async {
    // Simulate ingredient extraction from OCR text
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Common cosmetic ingredients for demo
    final commonIngredients = [
      'Water', 'Glycerin', 'Dimethicone', 'Cetyl Alcohol', 'Stearyl Alcohol',
      'Sodium Lauryl Sulfate', 'Parabens', 'Fragrance', 'Phenoxyethanol',
      'Tocopherol', 'Hyaluronic Acid', 'Niacinamide', 'Retinol'
    ];
    
    final extractedIngredients = <String>[];
    final lowerText = text.toLowerCase();
    
    for (final ingredient in commonIngredients) {
      if (lowerText.contains(ingredient.toLowerCase())) {
        extractedIngredients.add(ingredient);
      }
    }
    
    // Add some random ingredients for demo
    if (extractedIngredients.isEmpty) {
      extractedIngredients.addAll([
        'Water', 'Glycerin', 'Dimethicone', 'Fragrance'
      ]);
    }
    
    return extractedIngredients;
  }

  String? _extractProductName(String text) {
    // Simple product name extraction
    final lines = text.split('\n');
    for (final line in lines) {
      if (line.length > 5 && line.length < 50 && 
          !line.contains('ingredients') && 
          !line.contains('성분')) {
        return line.trim();
      }
    }
    return null;
  }

  String? _extractBrand(String text) {
    // Common cosmetic brands for demo
    final brands = ['로레알', '랑콤', '에스티로더', '클리니크', '맥', '메이블린'];
    final lowerText = text.toLowerCase();
    
    for (final brand in brands) {
      if (lowerText.contains(brand.toLowerCase())) {
        return brand;
      }
    }
    return null;
  }

  AllergyAnalysis _analyzeAllergies(List<String> ingredients) {
    final riskyIngredients = <String>[];
    final warnings = <String>[];
    
    for (final ingredient in ingredients) {
      for (final allergy in _userAllergies) {
        if (ingredient.toLowerCase().contains(allergy.toLowerCase()) ||
            _isRelatedIngredient(ingredient, allergy)) {
          riskyIngredients.add(ingredient);
          warnings.add('$ingredient - $allergy 알레르기 위험');
        }
      }
    }
    
    return AllergyAnalysis(
      hasRisk: riskyIngredients.isNotEmpty,
      riskyIngredients: riskyIngredients,
      warnings: warnings,
      riskLevel: _calculateRiskLevel(riskyIngredients.length),
    );
  }

  bool _isRelatedIngredient(String ingredient, String allergy) {
    final relations = {
      '파라벤': ['methylparaben', 'propylparaben', 'butylparaben'],
      '황산염': ['sodium lauryl sulfate', 'sodium laureth sulfate'],
      '인공향료': ['fragrance', 'parfum', 'perfume'],
    };
    
    final relatedIngredients = relations[allergy] ?? [];
    return relatedIngredients.any((related) => 
        ingredient.toLowerCase().contains(related.toLowerCase()));
  }

  RiskLevel _calculateRiskLevel(int riskyCount) {
    if (riskyCount == 0) return RiskLevel.safe;
    if (riskyCount <= 2) return RiskLevel.low;
    if (riskyCount <= 4) return RiskLevel.medium;
    return RiskLevel.high;
  }

  void _showAllergyWarning(AllergyAnalysis analysis) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.warning,
              color: _getRiskColor(analysis.riskLevel),
            ),
            const SizedBox(width: 8),
            const Text('알레르기 위험'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이 제품에는 알레르기를 유발할 수 있는 성분이 포함되어 있습니다:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            ...analysis.warnings.map((warning) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(child: Text(warning)),
                ],
              ),
            )),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  Color _getRiskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.safe:
        return Colors.green;
      case RiskLevel.low:
        return Colors.orange;
      case RiskLevel.medium:
        return Colors.deepOrange;
      case RiskLevel.high:
        return Colors.red;
    }
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('화장품 성분 분석'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showAllergySettings(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Scan Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: _isProcessing ? null : _scanCosmetic,
              icon: _isProcessing 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.camera_alt),
              label: Text(_isProcessing ? '분석 중...' : '화장품 성분 스캔'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          
          // User Allergies
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '내 알레르기 정보',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: _userAllergies.map((allergy) => Chip(
                        label: Text(allergy),
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                        labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Products List
          Expanded(
            child: _products.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.face_retouching_natural,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '분석된 제품이 없습니다',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '화장품 성분표를 스캔해보세요',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return _buildProductCard(product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(CosmeticProduct product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.brand,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getRiskColor(product.allergyRisk.riskLevel).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _getRiskColor(product.allergyRisk.riskLevel),
                    ),
                  ),
                  child: Text(
                    _getRiskText(product.allergyRisk.riskLevel),
                    style: TextStyle(
                      color: _getRiskColor(product.allergyRisk.riskLevel),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Risk warnings
            if (product.allergyRisk.hasRisk) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.red, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          '알레르기 위험 성분',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...product.allergyRisk.warnings.map((warning) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        '• $warning',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red.shade700,
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
            
            // Ingredients
            ExpansionTile(
              title: Text(
                '성분 목록 (${product.ingredients.length}개)',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: product.ingredients.map((ingredient) {
                      final isRisky = product.allergyRisk.riskyIngredients.contains(ingredient);
                      return Chip(
                        label: Text(ingredient),
                        backgroundColor: isRisky 
                            ? Colors.red.withOpacity(0.1)
                            : Theme.of(context).colorScheme.surfaceContainerHighest,
                        labelStyle: TextStyle(
                          color: isRisky 
                              ? Colors.red 
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRiskText(RiskLevel level) {
    switch (level) {
      case RiskLevel.safe:
        return '안전';
      case RiskLevel.low:
        return '낮은 위험';
      case RiskLevel.medium:
        return '중간 위험';
      case RiskLevel.high:
        return '높은 위험';
    }
  }

  void _showAllergySettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알레르기 설정'),
        content: const Text('알레르기 정보 수정 기능은 준비 중입니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}

enum RiskLevel { safe, low, medium, high }

class AllergyAnalysis {
  final bool hasRisk;
  final List<String> riskyIngredients;
  final List<String> warnings;
  final RiskLevel riskLevel;

  const AllergyAnalysis({
    required this.hasRisk,
    required this.riskyIngredients,
    required this.warnings,
    required this.riskLevel,
  });
}

class CosmeticProduct {
  final String id;
  final String name;
  final String brand;
  final List<String> ingredients;
  final AllergyAnalysis allergyRisk;
  final DateTime scanDate;

  const CosmeticProduct({
    required this.id,
    required this.name,
    required this.brand,
    required this.ingredients,
    required this.allergyRisk,
    required this.scanDate,
  });
}

