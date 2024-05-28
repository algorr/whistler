import 'package:whistler/features/model/chat_model.dart';
import 'package:whistler/features/model/response_model.dart';

abstract class ServiceManager {
  Future<ResponseModel> getTextOfEnglishSpeech(String filePath);
  Future<ResponseModel> getTextOfTurkishSpeech(String filePath);
  Future<ChatModel> saveLocal();
}
