import 'base_model.dart';

class ResultListFriendModel extends BaseModel {
  ResultListFriendModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  List<FriendData>? data;

  factory ResultListFriendModel.fromJson(Map<String, dynamic> json) =>
      ResultListFriendModel(
        success: json["success"],
        data: json["data"] != null
            ? List<FriendData>.from(
                json["data"].map((x) => FriendData.fromJson(x)))
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

class FriendData {
  String? id;
  String? userName;
  String? avatar;

  FriendData({this.id, this.userName, this.avatar});

  FriendData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['avatar'] = avatar;
    return data;
  }
}
