import 'dart:io';
import 'package:healthcare_app/core/llm/model_downloader.dart';

/// Enhanced CLI to download LLM models for SignCare.
/// Usage: dart run scripts/model_downloader_cli.dart <model>
/// Available models: gemma, exaone
Future<void> main(List<String> args) async {
  print('🏥 SignCare AI Model Downloader v1.1.0');
  print('==========================================');
  
  if (args.isEmpty || args.first == 'help' || args.first == '--help') {
    _printUsage();
    exit(0);
  }

  if (args.first == 'list') {
    await _listModels();
    exit(0);
  }

  final downloader = ModelDownloader();
  await downloader.checkAndUpdateStatuses();

  ModelType? type;
  String modelName;
  
  switch (args.first.toLowerCase()) {
    case 'gemma':
      type = ModelType.gemma1B;
      modelName = 'Gemma3 1B (Q4_K_M)';
      break;
    case 'exaone':
      type = ModelType.exaone24B;
      modelName = 'EXAONE 3.5 2.4B';
      break;
    default:
      print('❌ Unknown model: ${args.first}');
      _printUsage();
      exit(1);
  }

  // Check if already downloaded
  final isDownloaded = await downloader.isModelDownloaded(type);
  if (isDownloaded) {
    print('✅ $modelName is already downloaded!');
    print('🚀 You can now use it in the SignCare app.');
    exit(0);
  }

  // Check available space
  final hasSpace = await downloader.hasEnoughSpace(type);
  if (!hasSpace) {
    print('❌ Insufficient disk space for $modelName');
    final modelInfo = downloader.getModelInfo(type);
    print('   Required: ${modelInfo.displaySize}');
    exit(1);
  }

  print('🤖 Downloading $modelName...');
  print('📦 Size: ${downloader.getModelInfo(type).displaySize}');
  print('');

  final startTime = DateTime.now();
  final ok = await downloader.downloadModel(
    type,
    onProgress: (p) {
      final percent = p.percentage.toStringAsFixed(1).padLeft(5);
      final downloaded = _formatBytes(p.downloaded).padLeft(8);
      final total = _formatBytes(p.total).padLeft(8);
      final speed = p.speedDisplay.padLeft(10);
      final eta = p.etaDisplay.padLeft(8);
      
      stdout.write('\r📥 $percent% [$downloaded/$total] 🚀 $speed ⏱️  $eta   ');
    },
    onError: (e) {
      stderr.writeln('\n❌ Error: $e');
    },
  );

  print('\n');
  
  if (ok) {
    final duration = DateTime.now().difference(startTime);
    print('✅ Download completed successfully!');
    print('⏱️  Total time: ${_formatDuration(duration)}');
    print('🎯 Model is ready to use in SignCare app');
    print('');
    print('💡 Tip: The app will automatically detect and use the local model.');
  } else {
    print('❌ Download failed. Please check your internet connection and try again.');
    exit(1);
  }
}

void _printUsage() {
  print('');
  print('Usage:');
  print('  dart run scripts/model_downloader_cli.dart <command>');
  print('');
  print('Commands:');
  print('  gemma   - Download Gemma3 1B model (~0.7GB)');
  print('  exaone  - Download EXAONE 3.5 2.4B model (~1.4GB)');
  print('  list    - Show all available models');
  print('  help    - Show this help message');
  print('');
  print('Examples:');
  print('  dart run scripts/model_downloader_cli.dart gemma');
  print('  dart run scripts/model_downloader_cli.dart list');
}

Future<void> _listModels() async {
  print('Available models:');
  print('');
  
  final downloader = ModelDownloader();
  await downloader.checkAndUpdateStatuses();
  
  for (final type in ModelType.values) {
    final info = downloader.getModelInfo(type);
    final isDownloaded = await downloader.isModelDownloaded(type);
    
    final statusIcon = isDownloaded ? '✅' : '⬜';
    final statusText = isDownloaded ? 'Downloaded' : 'Not Downloaded';
    
    print('$statusIcon ${info.name}');
    print('   Size: ${info.displaySize}');
    print('   Status: $statusText');
    print('   Command: dart run scripts/model_downloader_cli.dart ${type.name.replaceAll('1B', '').replaceAll('24B', '').toLowerCase()}');
    print('');
  }
}

String _formatBytes(int bytes) {
  if (bytes < 1024) return '${bytes}B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
  if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
}

String _formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;
  
  if (hours > 0) return '${hours}h ${minutes}m ${seconds}s';
  if (minutes > 0) return '${minutes}m ${seconds}s';
  return '${seconds}s';
}
