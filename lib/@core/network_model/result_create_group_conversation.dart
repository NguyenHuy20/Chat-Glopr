import 'base_model.dart';

class ResultCreateGroupConverModel extends BaseModel {
  ResultCreateGroupConverModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  CreateGroupConverData? data;

  factory ResultCreateGroupConverModel.fromJson(Map<String, dynamic> json) =>
      ResultCreateGroupConverModel(
        success: json["success"],
        data: json["data"] != null
            ? CreateGroupConverData.fromJson(json["data"])
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

class CreateGroupConverData {
  String? conversationId;

  CreateGroupConverData({this.conversationId});

  CreateGroupConverData.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['conversationId'] = conversationId;
    return data;
  }
}
