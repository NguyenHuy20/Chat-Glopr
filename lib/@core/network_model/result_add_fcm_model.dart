import 'base_model.dart';

class ResultFcmModel extends BaseModel {
  ResultFcmModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  FCMData? data;

  factory ResultFcmModel.fromJson(Map<String, dynamic> json) => ResultFcmModel(
        success: json["success"],
        data: json["data"] != null ? FCMData.fromJson(json["data"]) : null,
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

class FCMData {
  String? fcmToken;
  String? deviceUuid;
  String? status;
  bool? isDeleted;
  String? userId;
  String? createdAt;
  String? updatedAt;
  String? id;

  FCMData(
      {this.fcmToken,
      this.deviceUuid,
      this.status,
      this.isDeleted,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.id});

  FCMData.fromJson(Map<String, dynamic> json) {
    fcmToken = json['fcm_token'];
    deviceUuid = json['device_uuid'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fcm_token'] = this.fcmToken;
    data['device_uuid'] = this.deviceUuid;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
