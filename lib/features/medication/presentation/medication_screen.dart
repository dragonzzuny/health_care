import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'dart:io';

class MedicationScreen extends ConsumerStatefulWidget {
  const MedicationScreen({super.key});

  @override
  ConsumerState<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends ConsumerState<MedicationScreen> {
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = TextRecognizer();
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  
  List<MedicationInfo> _medications = [];
  bool _isProcessing = false;

  @override
  void dispose() {
    _textRecognizer.close();
    _barcodeScanner.close();
    super.dispose();
  }

  Future<void> _scanMedication() async {
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
      
      // Try barcode scanning first
      final barcodes = await _barcodeScanner.processImage(inputImage);
      
      if (barcodes.isNotEmpty) {
        await _processBarcodeResult(barcodes.first);
      } else {
        // Fall back to OCR
        final recognizedText = await _textRecognizer.processImage(inputImage);
        await _processOCRResult(recognizedText);
      }
    } catch (e) {
      _showError('스캔 중 오류가 발생했습니다: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _processBarcodeResult(Barcode barcode) async {
    final medicationInfo = await _lookupMedicationByBarcode(barcode.displayValue ?? '');
    if (medicationInfo != null) {
      setState(() {
        _medications.add(medicationInfo);
      });
      _showSuccess('약물 정보가 추가되었습니다: ${medicationInfo.name}');
    } else {
      _showError('약물 정보를 찾을 수 없습니다');
    }
  }

  Future<void> _processOCRResult(RecognizedText recognizedText) async {
    final extractedText = recognizedText.text;
    final medicationInfo = await _extractMedicationFromText(extractedText);
    
    if (medicationInfo != null) {
      setState(() {
        _medications.add(medicationInfo);
      });
      _showSuccess('약물 정보가 추가되었습니다: ${medicationInfo.name}');
    } else {
      _showError('약물 정보를 인식할 수 없습니다');
    }
  }

  Future<MedicationInfo?> _lookupMedicationByBarcode(String barcode) async {
    // Simulate API call to medication database
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data
    final mockMedications = {
      '8801234567890': MedicationInfo(
        id: '1',
        name: '타이레놀',
        activeIngredient: '아세트아미노펜',
        dosage: '500mg',
        manufacturer: '한국얀센',
        description: '해열진통제',
        sideEffects: ['위장장애', '간독성'],
        contraindications: ['간질환', '알코올 중독'],
        interactions: ['와파린', '이소니아지드'],
      ),
    };
    
    return mockMedications[barcode];
  }

  Future<MedicationInfo?> _extractMedicationFromText(String text) async {
    // Simulate text analysis and medication extraction
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple keyword matching (in production, use more sophisticated NLP)
    if (text.toLowerCase().contains('타이레놀') || text.toLowerCase().contains('acetaminophen')) {
      return MedicationInfo(
        id: '2',
        name: '타이레놀',
        activeIngredient: '아세트아미노펜',
        dosage: '500mg',
        manufacturer: '한국얀센',
        description: '해열진통제',
        sideEffects: ['위장장애', '간독성'],
        contraindications: ['간질환', '알코올 중독'],
        interactions: ['와파린', '이소니아지드'],
      );
    }
    
    return null;
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
        title: const Text('약물 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () {
              // TODO: Navigate to medication reminder setup
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('복약 알림 설정 기능 준비 중입니다')),
              );
            },
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
              onPressed: _isProcessing ? null : _scanMedication,
              icon: _isProcessing 
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.camera_alt),
              label: Text(_isProcessing ? '처리 중...' : '약물 스캔하기'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          
          // Instructions
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
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '사용 방법',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('• 약물 포장지나 라벨을 카메라로 스캔하세요'),
                    const Text('• 바코드가 있는 경우 바코드를 중앙에 맞춰주세요'),
                    const Text('• 약물명이 선명하게 보이도록 촬영하세요'),
                    const Text('• 스캔 후 약물 정보를 확인하고 저장하세요'),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Medications List
          Expanded(
            child: _medications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medication_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '등록된 약물이 없습니다',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '약물을 스캔하여 정보를 등록해보세요',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _medications.length,
                    itemBuilder: (context, index) {
                      final medication = _medications[index];
                      return _buildMedicationCard(medication);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(MedicationInfo medication) {
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
                        medication.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${medication.activeIngredient} ${medication.dosage}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        medication.manufacturer,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _editMedication(medication);
                        break;
                      case 'delete':
                        _deleteMedication(medication);
                        break;
                      case 'reminder':
                        _setReminder(medication);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 8),
                          Text('수정'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'reminder',
                      child: Row(
                        children: [
                          Icon(Icons.alarm),
                          SizedBox(width: 8),
                          Text('알림 설정'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('삭제', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              medication.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            
            // Side Effects
            if (medication.sideEffects.isNotEmpty) ...[
              _buildInfoSection(
                '부작용',
                medication.sideEffects.join(', '),
                Icons.warning_amber,
                Colors.orange,
              ),
              const SizedBox(height: 8),
            ],
            
            // Contraindications
            if (medication.contraindications.isNotEmpty) ...[
              _buildInfoSection(
                '금기사항',
                medication.contraindications.join(', '),
                Icons.block,
                Colors.red,
              ),
              const SizedBox(height: 8),
            ],
            
            // Drug Interactions
            if (medication.interactions.isNotEmpty) ...[
              _buildInfoSection(
                '상호작용',
                medication.interactions.join(', '),
                Icons.sync_problem,
                Colors.blue,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String title, String content, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                content,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _editMedication(MedicationInfo medication) {
    // TODO: Implement medication editing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('약물 정보 수정 기능 준비 중입니다')),
    );
  }

  void _deleteMedication(MedicationInfo medication) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('약물 삭제'),
        content: Text('${medication.name}을(를) 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _medications.remove(medication);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('약물이 삭제되었습니다')),
              );
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _setReminder(MedicationInfo medication) {
    // TODO: Implement medication reminder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('복약 알림 설정 기능 준비 중입니다')),
    );
  }
}

class MedicationInfo {
  final String id;
  final String name;
  final String activeIngredient;
  final String dosage;
  final String manufacturer;
  final String description;
  final List<String> sideEffects;
  final List<String> contraindications;
  final List<String> interactions;

  const MedicationInfo({
    required this.id,
    required this.name,
    required this.activeIngredient,
    required this.dosage,
    required this.manufacturer,
    required this.description,
    required this.sideEffects,
    required this.contraindications,
    required this.interactions,
  });
}

