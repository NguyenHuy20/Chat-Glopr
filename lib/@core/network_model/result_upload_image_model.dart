import 'base_model.dart';

class ResultUploadImageModel extends BaseModel {
  ResultUploadImageModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  UploadImageData? data;

  factory ResultUploadImageModel.fromJson(Map<String, dynamic> json) =>
      ResultUploadImageModel(
        success: json["success"],
        data: json["data"] != null
            ? UploadImageData.fromJson(json["data"])
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

class UploadImageData {
  String? secureUrl;
  String? createdAt;

  UploadImageData({this.secureUrl, this.createdAt});

  UploadImageData.fromJson(Map<String, dynamic> json) {
    secureUrl = json['secure_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secure_url'] = secureUrl;
    data['created_at'] = createdAt;
    return data;
  }
}
