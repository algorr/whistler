import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:typewritertext/v3/typewriter.dart';
import 'package:wave_blob/wave_blob.dart';
import 'package:whistler/domain/service/local/hive_local_service.dart';
import 'package:whistler/domain/service/speech_to_text_service.dart';
import 'package:whistler/features/model/response_model.dart';
import 'package:whistler/features/view/widget/chat_bubble.dart';
import 'package:whistler/features/viewmodel/service/local/cubit/hive_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final RecorderController recorderController;

  String? path;
  String? musicFile;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = false;
  late Directory appDirectory;
  ResponseModel? responseModel;
  String? recognizedText = '';
  final SpeechToTextService _speechToTextService = SpeechToTextService();
  List<String> apiResultTexts = [];
  PlayerController controller = PlayerController();

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

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
      setState(() {});
    } else {
      debugPrint("File not picked");
    }
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HiveCubit, HiveState>(
      builder: (context, state) {
        print('Home View de state: $state');

        return state is HiveInitial
            ? Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  title: const Text('Whistler',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.black,
                ),
                floatingActionButton: InkWell(
                  onTap: () {
                    _startOrStopRecording();
                  },
                  child: ClayAnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceIn,
                    color: Colors.black,
                    height: 80,
                    width: 80,
                    borderRadius: 25,
                    surfaceColor: Colors.black,
                    parentColor: isRecording ? Colors.blue : Colors.grey,
                    depth: 30,
                    spread: 2,
                    curveType: CurveType.concave,
                    child: Icon(
                      isRecording ? Icons.stop : Icons.mic,
                      color: isRecording ? Colors.white : Colors.grey.shade800,
                      size: 28,
                    ),
                  ),
                ),
                body: Container(
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: state.chatList?.length,
                              itemBuilder: (context, index) {
                                print(
                                    'Sesin pathi : ${state.chatList?[index].audioFilePath}');
                                return isRecording
                                    ? Lottie.asset('assets/lottie/loading.json',
                                        height: 70, width: 70)
                                    : ListTile(
                                        title: WaveBubble(
                                          appDirectory: Directory(
                                            state.chatList?[index]
                                                    .audioFilePath ??
                                                '',
                                          ),
                                          index: index,
                                        ),
                                        subtitle: TypeWriter.text(
                                          state.chatList?[index]
                                                  .transcribedText ??
                                              '',
                                          maxLines: 100,
                                          maintainSize: true,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          duration:
                                              const Duration(milliseconds: 30),
                                        ),
                                      );
                              }),
                        ),
                      ),
                      SafeArea(
                        child: Row(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: isRecording
                                  ? AudioWaveforms(
                                      enableGesture: true,
                                      size: Size(
                                          MediaQuery.of(context).size.width / 2,
                                          50),
                                      recorderController: recorderController,
                                      waveStyle: const WaveStyle(
                                          waveColor: Colors.white70,
                                          extendWaveform: true,
                                          showMiddleLine: false,
                                          middleLineColor: Colors.red,
                                          durationLinesColor: Colors.yellow),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.transparent,
                                      ),
                                      padding: const EdgeInsets.only(left: 18),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      padding: const EdgeInsets.only(left: 18),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: const TextField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                color: Colors.red,
              );
      },
    );
  }

  void _startOrStopRecording() async {
    try {
      if (isRecording) {
        recorderController.reset();

        setState(() {
          isLoading = true;
        });
        print('OnStartPresed : $isLoading');
        path = await recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          print('Sesin kaydedildiği yer : $path');
          setState(() {
            isLoading = false;
          });
          print('OnStopPresed : $isLoading');

          final result =
              await _speechToTextService.getTextOfEnglishSpeech(path ?? '');
          context.read<HiveCubit>().addChatToLocal(
              audioFilePath: path!,
              transcribedText: result.text!,
              time: DateTime.now().toString());
          setState(() {
            responseModel = result;
          });
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path!).lengthSync()}");
        }
      } else {
        await recorderController.record(path: path);
        // Path is optional
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void _refreshWave() {
    if (isRecording) recorderController.refresh();
  }
}
