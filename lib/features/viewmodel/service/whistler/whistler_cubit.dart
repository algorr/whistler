import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whistler/products/cache/hive_cache_service.dart';
import 'package:whistler/domain/service/whistler/speech_to_text_service.dart';
import 'package:whistler/features/model/chat_model.dart';
import 'package:whistler/features/model/response_model.dart';

part 'whistler_state.dart';

/// The `WhistlerCubit` class in Dart is responsible for handling speech recognition, language
/// selection, caching chat data, and managing state changes in a Flutter application.
class WhistlerCubit extends Cubit<WhistlerState> {
  WhistlerCubit()
      : super(WhistlerInitial(
          isRecording: false,
        ));

  /// The line `final SpeechToTextService _speechToTextService = SpeechToTextService();` is creating an
  /// instance of the `SpeechToTextService` class and assigning it to the private variable
  /// `_speechToTextService`. This instance will be used to interact with the speech-to-text service for
  /// handling speech recognition functionalities in the `WhistlerCubit` class.
  final SpeechToTextService _speechToTextService = SpeechToTextService();

  /// The line `final HiveCacheService _hiveCacheService = HiveCacheService();` is creating an instance of
  /// the `HiveCacheService` class and assigning it to the private variable `_hiveCacheService`. This
  /// instance will be used to interact with the cache service for storing and retrieving chat data in the
  /// `WhistlerCubit` class. The `HiveCacheService` likely provides functionality related to caching data
  /// locally using Hive, a lightweight and fast key-value database.
  final HiveCacheService _hiveCacheService = HiveCacheService();

  ResponseModel? responseModel;
  List<ChatModel>? storagedFiles = [];
  String filePath = '';
  bool isLanguageTurkish = false;

  /// The `init` function in Dart initializes the cache service and retrieves all lists asynchronously.
  Future<void> init() async {
    await initCacheService();
    await getAllList();
  }

  /// The function `decideLanguage` determines whether to use Turkish or English language and calls the
  /// corresponding speech response function.
  Future<void> decideLanguage() async {
    if (isLanguageTurkish) {
      getResponseOfTurkishSpeech();
    } else {
      getResponseOfEnglishSpeech();
    }
  }

  /// The function `getResponseOfEnglishSpeech` processes English speech input, saves the transcribed
  /// text and response to a local cache, retrieves all stored data, and emits a loaded state with the
  /// chat list.
  ///
  /// Returns:
  ///   The function `getResponseOfEnglishSpeech()` is returning a `Future` that resolves to a
  /// `ResponseModel` object or `null`.
  Future<ResponseModel?> getResponseOfEnglishSpeech() async {
    emit(WhistlerLoadingState());
    final response =
        await _speechToTextService.getTextOfEnglishSpeech(filePath);
    /* await _hiveCacheService.saveLocale(
      audioFilePath: filePath,
      transcribedText: response.text ?? '',
      time: DateTime.now().toString(),
    ); */
    await saveChatLocal(
        audioFilePath: filePath,
        transcribedText: response.text ?? '',
        time: DateTime.now().toString(),
        response: response);

    await getAllList();
    emit(WhistlerLoadedState(chatList: storagedFiles));
    filePath = '';
    return response;
  }

  /// This Dart function retrieves the response of a Turkish speech, saves the transcribed text and
  /// audio file path to local storage, and then emits a loaded state with the chat list.
  ///
  /// Returns:
  ///   The function `getResponseOfTurkishSpeech()` is returning a `Future<ResponseModel>`.
  Future<ResponseModel> getResponseOfTurkishSpeech() async {
    emit(WhistlerLoadingState());
    final response =
        await _speechToTextService.getTextOfTurkishSpeech(filePath);
    /*  await _hiveCacheService.saveLocale(
      audioFilePath: '',
      transcribedText: response.text ?? '',
      time: DateTime.now().toString(),
    ); */
    await saveChatLocal(
        audioFilePath: filePath,
        transcribedText: response.text ?? '',
        time: DateTime.now().toString(),
        response: response);

    await getAllList();
    emit(WhistlerLoadedState(chatList: storagedFiles));
    filePath = '';
    return response;
  }

  /// The function `getAllList` fetches a list of `ChatModel` objects from a cache service and emits a
  /// state with the fetched data.
  ///
  /// Returns:
  ///   The `getAllList` function is returning a `Future` that resolves to a `List` of `ChatModel`
  /// objects or `null`.
  Future<List<ChatModel>?> getAllList() async {
    storagedFiles = await _hiveCacheService.fetchItems();
    emit(WhistlerLoadedState(chatList: storagedFiles));
    return storagedFiles;
  }

  /// The `initCacheService` function initializes the cache service by calling the `initLocalService`
  /// method.
  Future<void> initCacheService() async {
    await _hiveCacheService.initLocalService();
  }

  /// Allows save items to local storage as ChatModel objects.
  Future<void> saveChatLocal(
      {required String audioFilePath,
      required String transcribedText,
      required String time,
      required ResponseModel response}) async {
    await _hiveCacheService.saveLocale(
      audioFilePath: filePath,
      transcribedText: response.text ?? '',
      time: time,
    );
  }
}
