import 'package:hive/hive.dart';

part 'chat_model.g.dart';

/// Main Model of the App
@HiveType(typeId: 0)
final class ChatModel {
  ChatModel({
    required this.audioFilePath,
    required this.transcribedText,
    required this.time,
  });

  /// Recorded Audio File Path
  @HiveField(0)
  final String? audioFilePath;

  /// Transcribed Text of the Audio File from Api
  @HiveField(1)
  final String transcribedText;

  /// Time of the Recorded Audio File
  @HiveField(2)
  final String? time;

  /// Factory Constructor for ChatModel Class
  /// Convert ChatModel from Json
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      audioFilePath: json['audioFilePath'],
      transcribedText: json['transcribedText'],
      time: json['time'] ?? '',
    );
  }

  /// Convert ChatModel to Json
  Map<String, dynamic> toJson() {
    return {
      'audioFilePath': audioFilePath,
      'transcribedText': transcribedText,
      'time': time,
    };
  }
}
