import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whistler/products/record/record_service.dart';

part 'record_state.dart';

/// The `RecordCubit` class manages recording functionality, including initializing controllers, getting
/// directories, and starting/stopping recording.
final class RecordCubit extends Cubit<RecordState> {
  RecordCubit() : super(RecordInitial(isRecording: false));

  /// Record Service Instance
  final RecordService _recordService = RecordService();

  /// Recorder Controller Instance
  final RecorderController recorderController = RecorderController();

  /// Controls the recording state
  bool isRecording = false;

  /// Storaged Files List
  List<String> storagedFiles = [];

  /// Record Directory Path
  String path = '';

  /// Initialize App Directory for Record Service
  final Directory appDirectory = Directory.current;

  /// Initialize Controllers and Directory
  Future<void> init() async {
    await initControllers();
    await getDirectory();
  }

  /// Initialize Controllers
  Future<void> initControllers() async {
    try {
      _recordService.initializeControllers(recorderController);
    } catch (e) {
      print('Controller baslatilamadi : $e');
    }
  }

  /// Get Directory for Record Service
  Future<String> getDirectory() async {
    try {
      path = await _recordService.getDirectory(appDirectory);
      return path;
    } catch (e) {
      print('Path alınamadı : $e');
    }
    return '';
  }

//b0f6f1e9b012.m4a
  /// Start/Stop Recording Function includes permission check and recording state change
  Future<String?> startStopRecord() async {
    if (await Permission.microphone.request().isGranted) {
      toggleIsRecording();
      emit(StartedRecordState(isRecording: isRecording));
      if (isRecording) {
        await _recordService.startRecord(
            recorderController, isRecording, appDirectory);
      } else {
        if (!isRecording) {
          emit(RecordInitial(isRecording: isRecording));

          path = await _recordService.stopRecord(
            recorderController,
            path,
            isRecording,
          );
          return path;
        }
      }
    }
    return null;
  }

  /// Toggle isRecording State
  void toggleIsRecording() {
    isRecording = !isRecording;
  }
}
