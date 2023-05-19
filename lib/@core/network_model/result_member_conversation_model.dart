import 'base_model.dart';

class ResultMemberConversationModel extends BaseModel {
  ResultMemberConversationModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  List<MemberConversationData>? data;

  factory ResultMemberConversationModel.fromJson(Map<String, dynamic> json) =>
      ResultMemberConversationModel(
        success: json["success"],
        data: json["data"] != null
            ? List<MemberConversationData>.from(
                json["data"].map((x) => MemberConversationData.fromJson(x)))
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

class MemberConversationData {
  String? id;
  String? nickName;
  String? fullName;
  String? userName;
  String? avatar;

  MemberConversationData(
      {this.id, this.nickName, this.fullName, this.userName, this.avatar});

  MemberConversationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickName = json['nickName'];
    fullName = json['fullName'];
    userName = json['userName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nickName'] = nickName;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['avatar'] = avatar;
    return data;
  }
}
