import 'base_model.dart';

class ResultLoginModel extends BaseModel {
  ResultLoginModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  LoginData? data;

  factory ResultLoginModel.fromJson(Map<String, dynamic> json) =>
      ResultLoginModel(
        success: json["success"],
        data: json["data"] != null ? LoginData.fromJson(json["data"]) : null,
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

class LoginData {
  String? accessToken;
  String? refreshToken;
  InfoUser? info;

  LoginData({this.accessToken, this.refreshToken, this.info});

  LoginData.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refreshToken'];
    info = json['info'] != null ? InfoUser.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refreshToken'] = refreshToken;
    if (info != null) {
      data['info'] = info!.toJson();
    }
    return data;
  }
}

class InfoUser {
  String? id;
  String? email;
  String? fullName;
  String? userName;
  String? phoneNumber;

  InfoUser(
      {this.id, this.email, this.fullName, this.userName, this.phoneNumber});

  InfoUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['fullName'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
