/// ResponseModel class
class ResponseModel {
  ResponseModel({this.text});

  /// text property
  String? text;

  /// fromJson method
  ResponseModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  /// toJson method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}
