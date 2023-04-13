import 'base_model.dart';

class ResultCreateConversationModel extends BaseModel {
  ResultCreateConversationModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  CreateConversationData? data;

  factory ResultCreateConversationModel.fromJson(Map<String, dynamic> json) =>
      ResultCreateConversationModel(
        success: json["success"],
        data: json["data"] != null
            ? CreateConversationData.fromJson(json["data"])
            : null,
        message: json["message"] ?? '',
        statusCode: json["statusCode"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
        "statusCode": statusCode,
      };
}

class CreateConversationData {
  String? sId;
  bool? isExists;

  CreateConversationData({this.sId, this.isExists});

  CreateConversationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isExists = json['isExists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['isExists'] = isExists;
    return data;
  }
}
