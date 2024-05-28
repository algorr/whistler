final class RequestModel {
  RequestModel({required this.filePath});
  final String? filePath;

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(filePath: json['filePath']);
  }

  Map<String, dynamic> toJson() {
    return {'filePath': filePath};
  }
}
