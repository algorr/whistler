import 'package:whistler/features/model/chat_model.dart';

/// Local Storage Manager
/// The `CacheManager` class defines methods for saving, initializing, fetching, and deleting items from
/// local storage in Dart.
abstract class CacheManager {
  /// Save a new item to the local storage.
  Future<void> saveLocale(
      {required String? audioFilePath,
      required String transcribedText,
      required String time});

  /// Initialization of the local storage.
  Future<void> initLocalService();

  /// Fetch all items from the local storage.
  Future<List<ChatModel>> fetchItems();

  /// Delete all items from the local storage.
  Future<void> deleteAll();

  /// Delete specific item from the local storage.
  Future<void> deleteItem(int index);
}
