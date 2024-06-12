import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';

/// The `RecordManager` class in Dart provides methods for recording, stopping recording, refreshing
/// waveforms, initializing controllers, getting directories, and preparing players.
abstract class RecordManager {
  /// Starts recording functionality.
  Future<void> startRecord(RecorderController recorderController,
      bool isRecording, Directory appDirectory);

  /// Stops recording functionality.
  Future<String> stopRecord(
      RecorderController recorderController, String path, bool isRecording);

  /// Refresh the Voice Waveforms.
  void refreshWave(RecorderController recorderController, bool isRecording);

  /// Initializes the controllers of Recorder.
  void initializeControllers(
    RecorderController recorderController,
  );

  /// Gets the directory of the app.
  Future<String> getDirectory(Directory appDirectory);

  /// Prepares the player for play the audio.
  Future<void> preparePlayer(File file, Directory appDirectory, int index,
      PlayerController controller, PlayerWaveStyle playerWaveStyle);
}
