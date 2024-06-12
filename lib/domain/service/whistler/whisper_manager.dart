import 'package:whistler/features/model/response_model.dart';

/// Whisper AI Manager
abstract class WhisperManager {
  /// Get text of English speech from API
  Future<ResponseModel> getTextOfEnglishSpeech(String filePath);

  /// Get text of Turkish speech from API
  Future<ResponseModel> getTextOfTurkishSpeech(String filePath);
}
