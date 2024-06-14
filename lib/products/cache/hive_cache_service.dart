import 'package:hive/hive.dart';
import 'package:whistler/core/errors/cache_failure.dart';
import 'package:whistler/products/cache/cache_manager.dart';
import 'package:whistler/features/model/chat_model.dart';

/// The `HiveCacheService` class is a cache manager that utilizes Hive for local storage of `ChatModel`
/// objects.
final class HiveCacheService extends CacheManager {
  /// The `late final Box<ChatModel> _box;` line in the Dart code snippet is declaring a late-initialized
  /// final variable `_box` of type `Box<ChatModel>`.
  late final Box<ChatModel> _box;

  /// The function initializes a local service by registering a Hive adapter, opening a box for
  /// ChatModel objects, and printing the status of the box.
  @override
  Future<void> initLocalService() async {
    Hive.registerAdapter(ChatModelAdapter());
    _box = await Hive.openBox<ChatModel>('chatBox');
    //deleteItem();
    print('Box : ${_box.isOpen}');
  }

  /// The `saveLocale` function saves chat data to a local storage in Dart.
  ///
  /// Args:
  ///   audioFilePath (String): The `audioFilePath` parameter in the `saveLocale` method is a required
  /// String that represents the file path of an audio file. It is used to store the path of the audio
  /// file in the local storage along with other information like the transcribed text and the time when
  /// the transcription was made.
  ///   transcribedText (String): The `saveLocale` method you provided is used to save chat data to a
  /// local storage. The `transcribedText` parameter in this method represents the text that was
  /// transcribed from an audio file. When calling this method, you need to provide the transcribed text
  /// that you want to save locally
  ///   time (String): The `time` parameter in the `saveLocale` method represents the timestamp or time
  /// associated with the chat message being saved. It is a required parameter that should be provided
  /// when calling the `saveLocale` method.
  @override
  Future<void> saveLocale(
      {required String? audioFilePath,
      required String transcribedText,
      required String time}) async {
    try {
      _box.add(ChatModel(
          audioFilePath: audioFilePath,
          transcribedText: transcribedText,
          time: time));
    } on CacheFailure catch (e) {
      throw e.message;
    }
  }

  /// The fetchItems function retrieves a list of ChatModel items from a local storage box in Dart.
  ///
  /// Returns:
  ///   A list of ChatModel objects is being returned.
  @override
  Future<List<ChatModel>> fetchItems() async {
    try {
      final chatList = _box.values.toList();
      return chatList;
    } on CacheFailure catch (e) {
      throw e.message;
    }
  }

  /// The `deleteItem` function deletes an item from disk and prints a success message.
  @override
  Future<void> deleteAll() async {
    try {
      await _box.deleteFromDisk();
    } on CacheFailure catch (e) {
      throw e.message;
    }
  }

  @override
  Future<void> deleteItem(int index) async {
    try {
      await _box.deleteAt(index);
    } on CacheFailure catch (e) {
      throw e.message;
    }
  }
}
