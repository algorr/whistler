import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whistler/domain/service/local/hive_local_service.dart';
import 'package:whistler/features/model/chat_model.dart';

part 'hive_state.dart';

class HiveCubit extends Cubit<HiveState> {
  HiveCubit() : super(const HiveInitial(chatList: []));

  final HiveLocalService _hiveLocalService = HiveLocalService();
  List<ChatModel> storagedFiles = [];
  bool isLoading = false;
  bool isRecording = false;

  Future<void> initializeHive() async {
    try {
      await Hive.initFlutter();
      await _hiveLocalService.initLocalService();
      // await _hiveLocalService.deleteItem();
      storagedFiles = await getAllList();
      print('InitialCubit te : ${storagedFiles.length}');
      emit(HiveInitial(chatList: storagedFiles));
    } catch (e) {
      print('hata : ${e.toString()}');
    }
  }

  Future<List<ChatModel>> getAllList() async {
    final allList = await _hiveLocalService.fetchItems();
    return allList;
  }

  Future<void> addChatToLocal(
      {required String audioFilePath,
      required String transcribedText,
      required String time}) async {
    await _hiveLocalService.saveLocale(audioFilePath, transcribedText, time);
    storagedFiles = await getAllList();
    emit(HiveInitial(chatList: storagedFiles));
  }
}
