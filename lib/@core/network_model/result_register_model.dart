import 'base_model.dart';

class ResultRegisterModel extends BaseModel {
  ResultRegisterModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  RegisterData? data;

  factory ResultRegisterModel.fromJson(Map<String, dynamic> json) =>
      ResultRegisterModel(
        success: json["success"],
        data: json["data"] != null ? RegisterData.fromJson(json["data"]) : null,
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

class RegisterData {
  String? sId;
  String? email;
  String? phoneNumber;
  String? fullName;
  String? userName;
  String? gender;
  String? avatar;
  bool? isDelete;

  RegisterData(
      {this.sId,
      this.email,
      this.phoneNumber,
      this.fullName,
      this.userName,
      this.gender,
      this.avatar,
      this.isDelete});

  RegisterData.fromJson(Map<String, dynamic> json) {
    sId = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    userName = json['userName'];
    gender = json['gender'];
    avatar = json['avatar'];
    isDelete = json['isDelete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = sId;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['gender'] = gender;
    data['avatar'] = avatar;
    data['isDelete'] = isDelete;
    return data;
  }
}
