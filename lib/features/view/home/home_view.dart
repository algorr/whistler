import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:whistler/domain/service/speech_to_text_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //SpeechToTextService().getTextOfSpeech(filePath);
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.audio,
            );
            if (result != null) {
              await SpeechToTextService()
                  .getTextOfSpeech(result.files.single.path!);
            }
          },
          child: const Text('Try'),
        ),
      ),
    );
  }
}
