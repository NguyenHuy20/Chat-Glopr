import 'base_model.dart';

class ResultSendOTPModel extends BaseModel {
  ResultSendOTPModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  SendOTPData? data;

  factory ResultSendOTPModel.fromJson(Map<String, dynamic> json) =>
      ResultSendOTPModel(
        success: json["success"],
        data: json["data"] != null ? SendOTPData.fromJson(json["data"]) : null,
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

class SendOTPData {
  String? otpCode;

  SendOTPData({
    this.otpCode,
  });

  SendOTPData.fromJson(Map<String, dynamic> json) {
    otpCode = json['otpCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otpCode'] = otpCode;
    return data;
  }
}
