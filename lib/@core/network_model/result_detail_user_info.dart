import 'base_model.dart';

class ResultDetailUserInfoModel extends BaseModel {
  ResultDetailUserInfoModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  DetailUserInfoData? data;

  factory ResultDetailUserInfoModel.fromJson(Map<String, dynamic> json) =>
      ResultDetailUserInfoModel(
        success: json["success"],
        data: json["data"] != null
            ? DetailUserInfoData.fromJson(json["data"])
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

class DetailUserInfoData {
  String? id;
  String? fullName;
  String? userName;
  String? phoneNumber;
  String? email;
  String? dob;
  String? avatar;
  String? gender;
  bool? isActived;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  String? lastLogin;

  DetailUserInfoData(
      {this.id,
      this.fullName,
      this.userName,
      this.phoneNumber,
      this.email,
      this.dob,
      this.avatar,
      this.gender,
      this.isActived,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.lastLogin});

  DetailUserInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    dob = json['dob'];
    avatar = json['avatar'];
    gender = json['gender'];
    isActived = json['isActived'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['dob'] = dob;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['isActived'] = isActived;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['lastLogin'] = lastLogin;
    return data;
  }
}
