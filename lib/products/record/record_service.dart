import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:whistler/products/record/record_manager.dart';

/// This Dart code defines a class `RecordService` that extends `RecordManager` and implements several
/// methods related to recording and playing audio. Here is a breakdown of what each method does:
final class RecordService extends RecordManager {
  /// Refresh Wave Function while recording is in progress.
  @override
  void refreshWave(RecorderController recorderController, bool isRecording) {
    if (isRecording) recorderController.refresh();
  }

  /// Allows the get directory to return the path of the audio file.
  @override
  Future<String> getDirectory(Directory appDirectory) async {
    appDirectory = await getApplicationDocumentsDirectory();
    final path = '${appDirectory.path}/${const Uuid().v4()}.m4a';
    return path;
  }

  /// Allows start recording
  @override
  Future<void> startRecord(RecorderController recorderController,
      bool isRecording, Directory appDirectory) async {
    if (isRecording) {
      final newPath = await getDirectory(appDirectory);
      await recorderController.record(path: newPath);
    }
    recorderController.reset();
  }

  /// Allows stop recording
  @override
  Future<String> stopRecord(RecorderController recorderController, String path,
      bool isRecording) async {
    if (!isRecording) {
      path = await recorderController.stop(false) ?? '';
      recorderController.reset();
      return path;
    }
    return '';
  }

  /// Allows to initialize the recorder controller
  @override
  void initializeControllers(RecorderController recorderController) {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.amr_wb
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100
      ..bitRate = 48000
      ..updateFrequency = const Duration(milliseconds: 10);
  }

  /// Allows to prepare the player
  @override
  Future<void> preparePlayer(File file, Directory appDirectory, int index,
      PlayerController controller, PlayerWaveStyle playerWaveStyle) async {
    file = File('${appDirectory.path}/audio$index.mp3');

    controller.preparePlayer(
      path: appDirectory.path,
      shouldExtractWaveform: index.isEven,
    );

    controller.extractWaveformData(
      path: appDirectory.path,
      noOfSamples: playerWaveStyle.getSamplesForWidth(200),
    );
  }
}
