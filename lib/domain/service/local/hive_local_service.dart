import 'package:hive/hive.dart';
import 'package:whistler/domain/service/local/cache_manager.dart';
import 'package:whistler/features/model/chat_model.dart';

class HiveLocalService extends CacheManager {
  late final Box<ChatModel> _box;
  @override
  Future<void> initLocalService() async {
    Hive.registerAdapter(ChatModelAdapter());
    _box = await Hive.openBox<ChatModel>('chatBox');
    print('Box : ${_box.isOpen}');
  }

  @override
  Future<void> saveLocale(
      String audioFilePath, String transcribedText, String time) async {
    try {
      _box.add(ChatModel(
          audioFilePath: audioFilePath, transcribedText: transcribedText));
      print('added to local successfully $audioFilePath');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<ChatModel>> fetchItems() async {
    try {
      final chatList = _box.values.toList();
      return chatList;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteItem() async {
    await _box.deleteFromDisk();
    print('deleted successfully');
  }
}
