import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 0)
final class ChatModel {
  ChatModel({
    required this.audioFilePath,
    required this.transcribedText,
    required this.time,
  });

  @HiveField(0)
  final String? audioFilePath;
  @HiveField(1)
  final String transcribedText;
  @HiveField(2)
  final String? time;

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      audioFilePath: json['audioFilePath'],
      transcribedText: json['transcribedText'],
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'audioFilePath': audioFilePath,
      'transcribedText': transcribedText,
      'time': time,
    };
  }
}
