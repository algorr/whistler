/// Request Model of the API
final class RequestModel {
  RequestModel({required this.filePath});

  /// File Path of Audio File
  final String? filePath;

  /// Factory Constructor for Request Model
  /// From Json for Request Model
  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(filePath: json['filePath']);
  }

  /// To Json for Request Model
  Map<String, dynamic> toJson() {
    return {'filePath': filePath};
  }
}
