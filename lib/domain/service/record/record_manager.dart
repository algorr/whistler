import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';

abstract class RecordManager {
  Future<String?> startOrStopRecord(
    RecorderController recorderController,
    bool isRecording,
  );
  Future<void> startRecord(
      RecorderController recorderController, String path, bool isRecording);
  Future<String> stopRecord(
      RecorderController recorderController, String path, bool isRecording);
  void refreshWave(RecorderController recorderController, bool isRecording);
  void initializeControllers(
    RecorderController recorderController,
  );
  Future<String> getDirectory(Directory appDirectory);
  Future<void> preparePlayer(File file, Directory appDirectory, int index,
      PlayerController controller, PlayerWaveStyle playerWaveStyle);
}
