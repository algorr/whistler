import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whistler/domain/service/speech_to_text_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final RecorderController recorderController;

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  @override
  Widget build(BuildContext context) {
    // RecorderController controller = RecorderController();
    print('IsRecording : $isRecording');
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    //SpeechToTextService().getTextOfSpeech(filePath);
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.audio,
                    );
                    if (result != null) {
                      await SpeechToTextService()
                          .getTextOfEnglishSpeech(result.files.single.path!);
                    }
                  },
                  child: const Text('Try'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var status = await Permission.microphone.status;
                    print('Status : $status');
                    if (!status.isGranted) {
                      await Permission.microphone.request();
                      print('Permission granted');
                    }
                    if (status.isGranted) {
                      setState(() {
                        isRecording = !isRecording;
                        print('Başladı');
                        print('$isRecording');
                      });

                      _startOrStopRecording();

                      print('isRecording : $isRecording');
                    }
                  },
                  child: Text(isRecording ? 'Record' : 'Stop'),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.5,
              width: size.width,
              child: isRecording
                  ? AudioWaveforms(
                      recorderController: recorderController,
                      size: size,
                      enableGesture: true,
                      waveStyle: const WaveStyle(
                        waveColor: Colors.white,
                        extendWaveform: true,
                        showMiddleLine: false,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: const Color(0xFF1E1B26),
                      ),
                      padding: const EdgeInsets.only(left: 18),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                    )
                  : Container(
                      color: Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _startOrStopRecording() async {
    try {
      print('Start anında isRecording: $isRecording');
      if (isRecording) {
        recorderController.reset();

        path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path!).lengthSync()}");
        }
      } else {
        await recorderController.record(path: path); // Path is optional
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }
}
