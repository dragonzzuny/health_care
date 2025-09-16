import 'dart:io';
import 'detection.dart';

abstract class VisionDetector {
  Future<void> load();
  bool get isLoaded;
  Future<List<Detection>> detect(File imageFile);
  void dispose() {} // 기본 구현: 빈 메서드
}

