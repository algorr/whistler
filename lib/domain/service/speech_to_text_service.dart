import 'package:whistler/core/constants/app_consts.dart';
import 'package:whistler/domain/service/service_manager.dart';
import 'package:http/http.dart' as http;
import 'package:whistler/products/config/env/app_environment.dart';

final class SpeechToTextService extends ServiceManager {
  @override
  Future<String> getTextOfSpeech(String filePath) async {
    final url = Uri.https(AppEnvironment.baseUrl, AppEnvironment.url);
    var request = http.MultipartRequest(AppConsts.post, url);
    request.headers.addAll(AppConsts.header);
    request.fields['model'] = AppConsts.apiModel;
    request.fields['language'] = AppConsts.languageEnglish;
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    print(responseString);
    return responseString;
  }
}
