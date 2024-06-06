import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:whistler/domain/service/record/record_manager.dart';

final class RecordService extends RecordManager {
  String? path;

  @override
  void refreshWave(RecorderController recorderController, bool isRecording) {
    if (isRecording) recorderController.refresh();
  }

  @override
  Future<String> getDirectory(Directory appDirectory) async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = '${appDirectory.path}/${const Uuid().v4()}.m4a';
    return path!;
  }

  @override
  Future<void> startRecord(RecorderController recorderController, String path,
      bool isRecording) async {
    if (isRecording) {
      await recorderController.record(path: path);
    }
    recorderController.reset();
  }

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

  @override
  void initializeControllers(RecorderController recorderController) {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  @override
  Future<void> preparePlayer(File file, Directory appDirectory, int index,
      PlayerController controller, PlayerWaveStyle playerWaveStyle) async {
    file = File('${appDirectory.path}/audio$index.mp3');
    print('File in path : ${file.path}');

    // Prepare player with extracting waveform if index is even.
    controller.preparePlayer(
      path: appDirectory.path,
      shouldExtractWaveform: index.isEven,
    );
    // Extracting waveform separately if index is odd.
    if (index.isOdd) {
      controller
          .extractWaveformData(
            path: appDirectory.path,
            noOfSamples: playerWaveStyle.getSamplesForWidth(200),
          )
          .then((waveformData) => print(waveformData.toString()));
    }
  }
}
