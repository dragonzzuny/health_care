import 'dart:developer' as developer;
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:ultralytics_yolo/ultralytics_yolo.dart'; // 임시 제거
import 'detector.dart';
import 'detection.dart';

class YoloViewDetector implements VisionDetector {
  final String modelPath;
  bool _loaded = false;
  // final GlobalKey<_YoloProcessorState> _processorKey = GlobalKey(); // 임시 제거

  YoloViewDetector({
    this.modelPath = 'yolo11n',
  });

  @override
  Future<void> load() async {
    try {
      _loaded = true;
    } catch (e) {
      developer.log('YOLO 모델 로딩 실패: $e');
      _loaded = false;
    }
  }

  @override
  bool get isLoaded => _loaded;

  @override
  Future<List<Detection>> detect(File imageFile) async {
    if (!_loaded) {
      return const [];
    }

    try {
      // final processor = _YoloProcessor(
      //   key: _processorKey,
      //   modelPath: modelPath,
      //   imageFile: imageFile,
      // );
      
      // YOLOView는 실시간 카메라 스트림을 위한 것이므로
      // 정적 이미지 처리를 위해 임시로 MockDetector 방식 사용
      return _getMockDetections();
    } catch (e) {
      developer.log('YOLO 추론 실패: $e');
      return const [];
    }
  }

  List<Detection> _getMockDetections() {
    // 임시 mock 데이터 - 실제 YOLO 결과 대신 사용
    return [
      Detection(
        bbox: const Rect.fromLTWH(100, 100, 200, 150),
        label: 'food',
        score: 0.85,
      ),
      Detection(
        bbox: const Rect.fromLTWH(350, 200, 180, 120),
        label: 'apple',
        score: 0.92,
      ),
    ];
  }

  @override
  void dispose() {
    _loaded = false;
  }
}

// YOLOView를 사용한 숨겨진 위젯 (ultralytics_yolo 패키지 제거로 임시 비활성화)
// class _YoloProcessor extends StatefulWidget {
//   final String modelPath;
//   final File imageFile;

//   const _YoloProcessor({
//     super.key,
//     required this.modelPath,
//     required this.imageFile,
//   });

//   @override
//   State<_YoloProcessor> createState() => _YoloProcessorState();
// }

// class _YoloProcessorState extends State<_YoloProcessor> {
//   List<Detection> _results = [];

//   @override
//   Widget build(BuildContext context) {
//     // 실제 구현시에는 YOLOView를 사용하여 이미지 처리
//     // 현재는 화면에 표시되지 않는 숨겨진 위젯으로 구현
//     return Offstage(
//       child: SizedBox(
//         width: 1,
//         height: 1,
//         child: YOLOView(
//           modelPath: widget.modelPath,
//           task: YOLOTask.detect,
//           onResult: (results) {
//             final detections = results.map((result) {
//               return Detection(
//                 bbox: Rect.fromLTWH(
//                   result.boundingBox.left,
//                   result.boundingBox.top,
//                   result.boundingBox.width,
//                   result.boundingBox.height,
//                 ),
//                 label: result.className ?? 'unknown',
//                 score: result.confidence,
//               );
//             }).toList();
            
//             setState(() {
//               _results = detections;
//             });
//           },
//         ),
//       ),
//     );
//   }

//   List<Detection> getResults() => _results;
// }