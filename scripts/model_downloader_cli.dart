import 'dart:io';
import 'package:healthcare_app/core/llm/model_downloader.dart';

/// Simple CLI to download LLM models.
/// Usage: dart run scripts/model_downloader_cli.dart <model>
/// Available models: gemma, exaone
Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart run scripts/model_downloader_cli.dart <gemma|exaone>');
    exit(0);
  }

  final downloader = ModelDownloader();
  await downloader.checkAndUpdateStatuses();

  ModelType? type;
  switch (args.first.toLowerCase()) {
    case 'gemma':
      type = ModelType.gemma1B;
      break;
    case 'exaone':
      type = ModelType.exaone24B;
      break;
    default:
      print('Unknown model: ${args.first}');
      exit(1);
  }

  print('Starting download for $type');
  final ok = await downloader.downloadModel(
    type,
    onProgress: (p) {
      final percent = p.percentage.toStringAsFixed(1);
      stdout.write('\r$percent% - ${p.speedDisplay} ETA: ${p.etaDisplay}   ');
    },
    onError: (e) {
      stderr.writeln('\nError: $e');
    },
  );

  if (ok) {
    stdout.writeln('\nDownload completed.');
  } else {
    stdout.writeln('\nDownload failed.');
  }
}
