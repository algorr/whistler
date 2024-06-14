import 'dart:convert';
import 'package:whistler/core/constants/app_consts.dart';
import 'package:whistler/core/errors/whisper_api_failure.dart';
import 'package:whistler/domain/service/whistler/whisper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:whistler/features/model/response_model.dart';
import 'package:whistler/products/config/env/app_environment.dart';

final class SpeechToTextService extends WhisperManager {
  /// Get Response of English Speech from Whisper API
  @override
  Future<ResponseModel> getTextOfEnglishSpeech(String filePath) async {
    try {
      final url = Uri.https(AppEnvironment.baseUrl, AppEnvironment.url);
      var request = http.MultipartRequest(AppConsts.post, url);
      request.headers.addAll(AppConsts.header);
      request.fields['model'] = AppConsts.apiModel;
      request.fields['language'] = AppConsts.languageEnglish;
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = jsonDecode(responseString);
      final responseModel = ResponseModel.fromJson(jsonResponse);

      return responseModel;
    } on WhisperApiFailure catch (e) {
      throw e.message;
    }
  }

  /// Get Response of Turkish Speech from Whisper API
  @override
  Future<ResponseModel> getTextOfTurkishSpeech(String filePath) async {
    try {
      final url = Uri.https(AppEnvironment.baseUrl, AppEnvironment.url);
      var request = http.MultipartRequest(AppConsts.post, url);
      request.headers.addAll(AppConsts.header);
      request.fields['model'] = AppConsts.apiModel;
      request.fields['language'] = AppConsts.languageTurkish;
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      final Map<String, dynamic> jsonResponse = jsonDecode(responseString);
      final responseModel = ResponseModel.fromJson(jsonResponse);
      return responseModel;
    } on WhisperApiFailure catch (e) {
      throw e.message;
    }
  }
}
