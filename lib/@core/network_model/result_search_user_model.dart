import 'base_model.dart';

class ResultSearchUserpModel extends BaseModel {
  ResultSearchUserpModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  List<SearchUserData>? data;

  factory ResultSearchUserpModel.fromJson(Map<String, dynamic> json) =>
      ResultSearchUserpModel(
        success: json["success"],
        data: json["data"] != null
            ? List<SearchUserData>.from(
                json["data"].map((x) => SearchUserData.fromJson(x)))
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

class SearchUserData {
  String? fullName;
  String? userName;
  String? email;
  dynamic dob;
  String? avatar;
  String? gender;
  bool? isActived;
  String? id;

  SearchUserData(
      {this.fullName,
      this.userName,
      this.email,
      this.dob,
      this.avatar,
      this.gender,
      this.isActived,
      this.id});

  SearchUserData.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    userName = json['userName'];
    email = json['email'];
    dob = json['dob'];
    avatar = json['avatar'];
    gender = json['gender'];
    isActived = json['isActived'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['email'] = email;
    data['dob'] = dob;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['isActived'] = isActived;
    data['id'] = id;
    return data;
  }
}
