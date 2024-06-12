/// ResponseModel class
class ResponseModel {
  ResponseModel({this.text});

  /// Transcribed Text from API
  String? text;

  /// From Json method for Response Model
  ResponseModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  /// toJson method for Response Model
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}
