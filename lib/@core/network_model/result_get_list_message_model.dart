import 'base_model.dart';

class ResultListMessageModel extends BaseModel {
  ResultListMessageModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  List<MessageData>? data;

  factory ResultListMessageModel.fromJson(Map<String, dynamic> json) =>
      ResultListMessageModel(
        success: json["success"],
        data: json["data"] != null
            ? List<MessageData>.from(
                json["data"].map((x) => MessageData.fromJson(x)))
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

class MessageData {
  String? id;
  String? content;
  String? type;
  String? createdAt;
  UserMessing? user;
  List<ManipulatedUsersMessing>? manipulatedUsers;
  dynamic replyMessage;

  MessageData({
    this.id,
    this.content,
    this.type,
    this.createdAt,
    this.user,
    this.manipulatedUsers,
    this.replyMessage,
  });

  MessageData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    type = json['type'];

    createdAt = json['createdAt'];
    user = json['user'] != null ? UserMessing.fromJson(json['user']) : null;
    if (json['manipulatedUsers'] != null) {
      manipulatedUsers = <ManipulatedUsersMessing>[];
      json['manipulatedUsers'].forEach((v) {
        manipulatedUsers!.add(ManipulatedUsersMessing.fromJson(v));
      });
    }

    replyMessage = json['replyMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['content'] = content;
    data['type'] = type;

    data['createdAt'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (manipulatedUsers != null) {
      data['manipulatedUsers'] =
          manipulatedUsers!.map((v) => v.toJson()).toList();
    }

    data['replyMessage'] = replyMessage;

    return data;
  }
}

class UserMessing {
  String? id;
  String? fullName;
  String? avatar;

  UserMessing({this.id, this.fullName, this.avatar});

  UserMessing.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullName = json['fullName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fullName'] = fullName;
    data['avatar'] = avatar;
    return data;
  }
}

class ManipulatedUsersMessing {
  String? id;
  String? fullName;
  String? avatar;

  ManipulatedUsersMessing({this.id, this.fullName, this.avatar});

  ManipulatedUsersMessing.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullName = json['fullName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['fullName'] = fullName;
    data['avatar'] = avatar;
    return data;
  }
}
