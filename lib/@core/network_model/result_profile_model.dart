import 'base_model.dart';

class ResultProfileModel extends BaseModel {
  ResultProfileModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  ProfileData? data;

  factory ResultProfileModel.fromJson(Map<String, dynamic> json) =>
      ResultProfileModel(
        success: json["success"],
        data: json["data"] != null ? ProfileData.fromJson(json["data"]) : null,
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

class ProfileData {
  String? id;
  String? email;
  String? phoneNumber;
  String? fullName;
  String? userName;
  String? dob;
  String? avatar;
  String? gender;
  bool? isActived;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  ProfileData(
      {this.id,
      this.email,
      this.phoneNumber,
      this.fullName,
      this.userName,
      this.dob,
      this.avatar,
      this.gender,
      this.isActived,
      this.isDeleted,
      this.createdAt,
      this.updatedAt});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    userName = json['userName'];
    dob = json['dob'];
    avatar = json['avatar'];
    gender = json['gender'];
    isActived = json['isActived'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['dob'] = dob;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['isActived'] = isActived;
    data['isDeleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
