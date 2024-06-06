import 'package:whistler/features/model/chat_model.dart';

abstract class CacheManager {
  Future<void> saveLocale(
      {required String? audioFilePath,
      required String transcribedText,
      required String time});
  Future<void> initLocalService();
  Future<List<ChatModel>> fetchItems();
  Future<void> deleteItem();
}
