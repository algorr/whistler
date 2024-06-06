import 'dart:async';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whistler/domain/service/cache/hive_cache_service.dart';
import 'package:whistler/domain/service/record/record_service.dart';
import 'package:whistler/domain/service/whistler/speech_to_text_service.dart';
import 'package:whistler/features/model/chat_model.dart';
import 'package:whistler/features/model/response_model.dart';

part 'whistler_state.dart';

class WhistlerCubit extends Cubit<WhistlerState> {
  WhistlerCubit()
      : super(WhistlerInitial(
          isRecording: false,
        ));

  final SpeechToTextService _speechToTextService = SpeechToTextService();
  final HiveCacheService _hiveCacheService = HiveCacheService();
  final RecordService _recordService = RecordService();

  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = false;
  final RecorderController recorderController = RecorderController();
  String path = '';
  final Directory appDirectory = Directory.current;

  final ScrollController scrollController = ScrollController();

  ResponseModel? responseModel;
  String? recognizedText = '';

  int index = 0;

  PlayerController playerController = PlayerController();
  late StreamSubscription<PlayerState> playerStateSubscription;

  List<ChatModel>? storagedFiles = [];

  Future<ResponseModel?> getResponseOfEnglishSpeech() async {
    emit(WhistlerLoadingState());
    final filePath = await startStopRecord();
    if (filePath != null) {
      final response =
          await _speechToTextService.getTextOfEnglishSpeech(filePath);

      return response;
    }
    return null;
  }

  Future<ResponseModel> getResponseOfTurkishSpeech(String filePath) async {
    emit(WhistlerLoadingState());
    final response =
        await _speechToTextService.getTextOfTurkishSpeech(filePath);
    await _hiveCacheService.saveLocale(
      audioFilePath: '',
      transcribedText: response.text ?? '',
      time: DateTime.now().toString(),
    );
    await getAllList();
    emit(
        WhistlerLoadedState(chatList: storagedFiles, isRecording: isRecording));
    return response;
  }

  Future<void> init() async {
    await initCacheService();
    await getDirectory();
    await initControllers();
    await getAllList();
  }

  Future<List<ChatModel>?> getAllList() async {
    storagedFiles = await _hiveCacheService.fetchItems();
    emit(
        WhistlerLoadedState(chatList: storagedFiles, isRecording: isRecording));
    return storagedFiles;
  }

  Future<void> initCacheService() async {
    await _hiveCacheService.initLocalService();
  }

  Future<void> addChatToLocal(
      {required String audioFilePath,
      required String transcribedText,
      required String time}) async {}

  Future<void> initControllers() async {
    try {
      _recordService.initializeControllers(recorderController);
    } catch (e) {
      print('Controllerlar başlatılamadı : $e');
    }
  }

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  void scrollToEnd() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<String?> startStopRecord() async {
    if (await Permission.microphone.request().isGranted) {
      isRecording = !isRecording;
      print('isRecording : $isRecording');
      if (isRecording) {
        print('isRecordingCompleted : $isRecordingCompleted');
        emit(WhistlerStartedRecordState(isRecording));
        await _recordService.startRecord(recorderController, path, isRecording);
      } else {
        isRecordingCompleted = !isRecordingCompleted;
        print(' hooopp   isRecordingCompleted : $isRecordingCompleted');

        if (isRecordingCompleted) {
          print(' Kayıt tamamlandı : $isRecording');
          path = await _recordService.stopRecord(
            recorderController,
            path,
            isRecording,
          );
          print('Kayıt sonrası path : $path');
          isRecording = !isRecording;
          emit(WhistlerWaitingForDataComesState());
          print('Whistler path : $path');
          final responseModel =
              await _speechToTextService.getTextOfEnglishSpeech(path);

          isLoading = !isLoading;
          print('Gelen veri : ${responseModel.text}');
          await _hiveCacheService.saveLocale(
              audioFilePath: path,
              transcribedText: responseModel.text ?? '',
              time: DateTime.now().toString());
          storagedFiles = await getAllList();

          emit(
            WhistlerLoadedState(
                chatList: storagedFiles, isRecording: isRecording),
          );
        }
      }
    }
    return null;
  }

  Future<String> getDirectory() async {
    try {
      path = await _recordService.getDirectory(appDirectory);
      return path;
    } catch (e) {
      print('Path alınamadı : $e');
    }
    return '';
  }
}
