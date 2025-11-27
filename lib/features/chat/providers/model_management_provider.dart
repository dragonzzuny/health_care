import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/llm/model_downloader.dart';

class ModelManagementState {
  final Map<ModelType, ModelInfo> modelInfos;
  final Map<ModelType, DownloadStatus> modelStatuses;
  final Map<ModelType, DownloadProgress?> downloadProgresses;
  final bool isLoading;
  final String? error;

  const ModelManagementState({
    required this.modelInfos,
    this.modelStatuses = const {},
    this.downloadProgresses = const {},
    this.isLoading = false,
    this.error,
  });

  ModelManagementState copyWith({
    Map<ModelType, ModelInfo>? modelInfos,
    Map<ModelType, DownloadStatus>? modelStatuses,
    Map<ModelType, DownloadProgress?>? downloadProgresses,
    bool? isLoading,
    String? error,
  }) {
    return ModelManagementState(
      modelInfos: modelInfos ?? this.modelInfos,
      modelStatuses: modelStatuses ?? this.modelStatuses,
      downloadProgresses: downloadProgresses ?? this.downloadProgresses,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ModelManagementNotifier extends StateNotifier<ModelManagementState> {
  final ModelDownloader _downloader;

  ModelManagementNotifier(this._downloader)
      : super(ModelManagementState(
          modelInfos: {
            for (var type in ModelType.values)
              type: _downloader.getModelInfo(type),
          },
        )) {
    checkModelStatuses();
  }

  Future<void> checkModelStatuses() async {
    state = state.copyWith(isLoading: true);

    try {
      await _downloader.checkAndUpdateStatuses();

      final statuses = <ModelType, DownloadStatus>{};
      for (final type in ModelType.values) {
        statuses[type] = _downloader.getDownloadStatus(type);
      }

      state = state.copyWith(
        modelStatuses: statuses,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> downloadModel(ModelType type) async {
    final currentStatuses = Map<ModelType, DownloadStatus>.from(state.modelStatuses);
    currentStatuses[type] = DownloadStatus.downloading;
    state = state.copyWith(modelStatuses: currentStatuses);

    final success = await _downloader.downloadModel(
      type,
      onProgress: (progress) {
        final progresses = Map<ModelType, DownloadProgress?>.from(state.downloadProgresses);
        progresses[type] = progress;
        state = state.copyWith(downloadProgresses: progresses);
      },
      onError: (error) {
        state = state.copyWith(error: error);
      },
    );

    if (success) {
      final statuses = Map<ModelType, DownloadStatus>.from(state.modelStatuses);
      statuses[type] = DownloadStatus.downloaded;
      final progresses = Map<ModelType, DownloadProgress?>.from(state.downloadProgresses);
      progresses[type] = null;
      state = state.copyWith(
        modelStatuses: statuses,
        downloadProgresses: progresses,
      );
    } else {
      final statuses = Map<ModelType, DownloadStatus>.from(state.modelStatuses);
      statuses[type] = DownloadStatus.failed;
      final progresses = Map<ModelType, DownloadProgress?>.from(state.downloadProgresses);
      progresses[type] = null;
      state = state.copyWith(
        modelStatuses: statuses,
        downloadProgresses: progresses,
      );
    }
  }

  Future<bool> deleteModel(ModelType type) async {
    final success = await _downloader.deleteModel(type);

    if (success) {
      final statuses = Map<ModelType, DownloadStatus>.from(state.modelStatuses);
      statuses[type] = DownloadStatus.notDownloaded;
      state = state.copyWith(modelStatuses: statuses);
    }

    return success;
  }

  void cancelDownload(ModelType type) {
    _downloader.cancelDownload(type);
    final statuses = Map<ModelType, DownloadStatus>.from(state.modelStatuses);
    statuses[type] = DownloadStatus.notDownloaded;
    final progresses = Map<ModelType, DownloadProgress?>.from(state.downloadProgresses);
    progresses[type] = null;
    state = state.copyWith(
      modelStatuses: statuses,
      downloadProgresses: progresses,
    );
  }
}

final modelManagementProvider =
    StateNotifierProvider<ModelManagementNotifier, ModelManagementState>((ref) {
  final downloader = ref.watch(modelDownloaderProvider);
  return ModelManagementNotifier(downloader);
});
