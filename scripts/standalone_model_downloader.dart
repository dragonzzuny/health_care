#!/usr/bin/env dart

import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

// Model configurations without Flutter dependencies
const Map<String, Map<String, dynamic>> models = {
  'gemma': {
    'name': 'Gemma2 2B Instruct',
    'url': 'https://huggingface.co/bartowski/gemma-2-2b-it-GGUF/resolve/main/gemma-2-2b-it-Q4_K_M.gguf',
    'filename': 'gemma-2-2b-it-Q4_K_M.gguf',
    'size': 1200 * 1024 * 1024, // ~1.2GB
  },
  'exaone': {
    'name': 'EXAONE 3.5 2.4B Instruct',
    'url': 'https://huggingface.co/LGAI-EXAONE/EXAONE-3.5-2.4B-Instruct-GGUF/resolve/main/EXAONE-3.5-2.4B-Instruct-Q4_K_M.gguf',
    'filename': 'EXAONE-3.5-2.4B-Instruct-Q4_K_M.gguf', 
    'size': 1400 * 1024 * 1024, // ~1.4GB
  },
};

String formatBytes(int bytes) {
  if (bytes < 1024) return '${bytes} B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
}

String formatSpeed(double bytesPerSecond) {
  if (bytesPerSecond < 1024) return '${bytesPerSecond.toStringAsFixed(1)} B/s';
  if (bytesPerSecond < 1024 * 1024) return '${(bytesPerSecond / 1024).toStringAsFixed(1)} KB/s';
  return '${(bytesPerSecond / (1024 * 1024)).toStringAsFixed(1)} MB/s';
}

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;
  
  if (hours > 0) return '${hours}h ${minutes}m ${seconds}s';
  if (minutes > 0) return '${minutes}m ${seconds}s';
  return '${seconds}s';
}

Future<Directory> getModelsDirectory() async {
  final home = Platform.environment['HOME'] ??
      Platform.environment['USERPROFILE'] ??
      Directory.current.path;
  final modelsDir = Directory(path.join(home, '.signcare_models'));
  if (!await modelsDir.exists()) {
    await modelsDir.create(recursive: true);
  }
  return modelsDir;
}

Future<void> downloadModel(String modelKey) async {
  if (!models.containsKey(modelKey)) {
    print('❌ Unknown model: $modelKey');
    print('Available models: ${models.keys.join(', ')}');
    exit(1);
  }

  final model = models[modelKey]!;
  final modelName = model['name'];
  final url = model['url'];
  final filename = model['filename'];
  final expectedSize = model['size'] as int;

  print('🤖 Downloading $modelName...');
  print('📍 URL: $url');
  print('📁 File: $filename');
  print('📦 Expected size: ${formatBytes(expectedSize)}');

  final modelsDir = await getModelsDirectory();
  final targetFile = File(path.join(modelsDir.path, filename));

  // Check if already downloaded
  if (await targetFile.exists()) {
    final stat = await targetFile.stat();
    if (stat.size >= expectedSize * 0.95) { // Allow 5% variance
      print('✅ Model already downloaded: ${targetFile.path}');
      print('📊 File size: ${formatBytes(stat.size)}');
      return;
    } else {
      print('⚠️  Incomplete download detected, redownloading...');
      await targetFile.delete();
    }
  }

  print('🌐 Starting download from Hugging Face...');
  final startTime = DateTime.now();
  
  try {
    final request = http.Request('GET', Uri.parse(url));
    request.headers['User-Agent'] = 'SignCare-ModelDownloader/1.0.0';
    
    final streamedResponse = await http.Client().send(request);
    
    if (streamedResponse.statusCode != 200) {
      throw Exception('HTTP ${streamedResponse.statusCode}: ${streamedResponse.reasonPhrase}');
    }

    final contentLength = streamedResponse.contentLength ?? expectedSize;
    final output = targetFile.openWrite();
    
    int downloaded = 0;
    int lastDownloaded = 0;
    DateTime lastUpdate = DateTime.now();
    
    await for (List<int> chunk in streamedResponse.stream) {
      output.add(chunk);
      downloaded += chunk.length;
      
      final now = DateTime.now();
      final timeDiff = now.difference(lastUpdate).inMilliseconds;
      
      if (timeDiff >= 1000 || downloaded == contentLength) { // Update every second
        final percentage = (downloaded / contentLength * 100).toStringAsFixed(1);
        final totalFormatted = formatBytes(contentLength);
        final downloadedFormatted = formatBytes(downloaded);
        
        final bytesDiff = downloaded - lastDownloaded;
        final speed = bytesDiff / (timeDiff / 1000.0);
        final speedFormatted = formatSpeed(speed);
        
        final remaining = contentLength - downloaded;
        final eta = speed > 0 ? Duration(seconds: (remaining / speed).round()) : Duration.zero;
        final etaFormatted = formatDuration(eta);

        // Clear line and print progress
        stdout.write('\r📥 $percentage% ($downloadedFormatted / $totalFormatted) | $speedFormatted | ETA: $etaFormatted     ');
        
        lastDownloaded = downloaded;
        lastUpdate = now;
      }
    }
    
    await output.close();

    print('\n✅ Download completed successfully!');
    
    // Verify file
    final stat = await targetFile.stat();
    print('📊 Final file size: ${formatBytes(stat.size)}');
    
    if (stat.size < expectedSize * 0.9) {
      print('⚠️  Warning: Downloaded file seems smaller than expected');
      print('   Expected: ~${formatBytes(expectedSize)}');
      print('   Actual: ${formatBytes(stat.size)}');
    }

    final totalTime = DateTime.now().difference(startTime);
    print('⏱️  Total download time: ${formatDuration(totalTime)}');
    print('🎯 Model saved to: ${targetFile.path}');
    print('');
    print('🚀 You can now use the model in SignCare app!');
    print('   The app will automatically detect the downloaded model.');

  } catch (e) {
    print('\n❌ Download failed: $e');
    
    // Clean up partial download
    if (await targetFile.exists()) {
      await targetFile.delete();
      print('🧹 Cleaned up partial download');
    }
    exit(1);
  }
}

Future<void> listModels() async {
  print('📋 Available models for SignCare:');
  print('');
  
  final modelsDir = await getModelsDirectory();
  
  for (final entry in models.entries) {
    final modelKey = entry.key;
    final model = entry.value;
    final filename = model['filename'];
    final modelFile = File(path.join(modelsDir.path, filename));
    final isDownloaded = await modelFile.exists();
    
    final statusIcon = isDownloaded ? '✅' : '⬜';
    final statusText = isDownloaded ? 'Downloaded' : 'Not Downloaded';
    
    print('$statusIcon ${model['name']}');
    print('   Size: ${formatBytes(model['size'])}');
    print('   Status: $statusText');
    if (isDownloaded) {
      final stat = await modelFile.stat();
      print('   Path: ${modelFile.path}');
      print('   Actual size: ${formatBytes(stat.size)}');
    }
    print('   Command: dart run scripts/standalone_model_downloader.dart $modelKey');
    print('');
  }
  
  print('💡 Models are stored in: ${modelsDir.path}');
}

void printUsage() {
  print('🏥 SignCare Standalone Model Downloader v1.0.0');
  print('================================================');
  print('');
  print('Usage:');
  print('  dart run scripts/standalone_model_downloader.dart <command>');
  print('');
  print('Commands:');
  print('  gemma   - Download Gemma2 2B model (~1.2GB)');
  print('  exaone  - Download EXAONE 3.5 2.4B model (~1.4GB)');
  print('  list    - Show all available models and their status');
  print('  help    - Show this help message');
  print('');
  print('Examples:');
  print('  dart run scripts/standalone_model_downloader.dart gemma');
  print('  dart run scripts/standalone_model_downloader.dart list');
  print('');
  print('Note: This downloader works independently of Flutter.');
}

Future<void> main(List<String> args) async {
  if (args.isEmpty || args.first == 'help' || args.first == '--help') {
    printUsage();
    exit(0);
  }

  final command = args.first.toLowerCase();
  
  if (command == 'list') {
    await listModels();
    exit(0);
  }

  if (models.containsKey(command)) {
    await downloadModel(command);
  } else {
    print('❌ Unknown command: $command');
    printUsage();
    exit(1);
  }
}