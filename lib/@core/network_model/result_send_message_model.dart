import 'base_model.dart';

class ResultSendMessageModel extends BaseModel {
  ResultSendMessageModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  SendMessageData? data;

  factory ResultSendMessageModel.fromJson(Map<String, dynamic> json) =>
      ResultSendMessageModel(
        success: json["success"],
        data: json["data"] != null
            ? SendMessageData.fromJson(json["data"])
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

class SendMessageData {
  String? id;
  String? content;
  String? type;
  String? conversationId;
  String? createdAt;
  User? user;

  dynamic replyMessage;

  SendMessageData({
    this.id,
    this.content,
    this.type,
    this.conversationId,
    this.createdAt,
    this.user,
    this.replyMessage,
  });

  SendMessageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    type = json['type'];
    conversationId = json['conversationId'];

    createdAt = json['createdAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;

    replyMessage = json['replyMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['type'] = type;
    data['conversationId'] = conversationId;

    data['createdAt'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }

    data['replyMessage'] = replyMessage;

    return data;
  }
}

class User {
  String? id;
  String? fullName;
  String? avatar;

  User({this.id, this.fullName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['avatar'] = avatar;
    return data;
  }
}
