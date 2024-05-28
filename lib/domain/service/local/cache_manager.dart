import 'package:whistler/features/model/chat_model.dart';

abstract class CacheManager {
  Future<void> saveLocale(
      String audioFilePath, String transcribedText, String time);
  Future<void> initLocalService();
  Future<List<ChatModel>> fetchItems();
  Future<void> deleteItem();
}
