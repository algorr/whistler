import 'dart:convert';

import 'package:whistler/core/constants/app_consts.dart';
import 'package:whistler/domain/service/service_manager.dart';
import 'package:http/http.dart' as http;
import 'package:whistler/features/model/chat_model.dart';
import 'package:whistler/features/model/response_model.dart';
import 'package:whistler/products/config/env/app_environment.dart';

final class SpeechToTextService extends ServiceManager {
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
      print(responseString);

      final Map<String, dynamic> jsonResponse = jsonDecode(responseString);
      final responseModel = ResponseModel.fromJson(jsonResponse);

      return responseModel;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

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
      print(responseString);
      return responseModel;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<ChatModel> saveLocal() {
    // TODO: implement saveLocal
    throw UnimplementedError();
  }
}
