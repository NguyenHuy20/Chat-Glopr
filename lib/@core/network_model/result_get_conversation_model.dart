import 'base_model.dart';

class ResultGetConversationModel extends BaseModel {
  ResultGetConversationModel({this.data, success, statusCode, message})
      : super(success: success, message: message, statusCode: statusCode);
  List<ConversationData>? data;

  factory ResultGetConversationModel.fromJson(Map<String, dynamic> json) =>
      ResultGetConversationModel(
        success: json["success"],
        data: json["data"] != null
            ? List<ConversationData>.from(
                json["data"].map((x) => ConversationData.fromJson(x)))
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

class ConversationData {
  String? id;
  String? name;
  List<ImageAvatar>? image;
  bool? type;
  int? totalMembers;
  int? numberUnread;
  LastMessage? lastMessage;
  bool? isNotify;
  bool? isJoinFromLink;

  ConversationData(
      {this.id,
      this.name,
      this.image,
      this.type,
      this.totalMembers,
      this.numberUnread,
      this.lastMessage,
      this.isNotify,
      this.isJoinFromLink});

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    if (json['image'] != null) {
      image = <ImageAvatar>[];
      json['image'].forEach((v) {
        image!.add(ImageAvatar.fromJson(v));
      });
    }
    type = json['type'];
    totalMembers = json['totalMembers'];
    numberUnread = json['numberUnread'];
    lastMessage = json['lastMessage'] != null
        ? LastMessage.fromJson(json['lastMessage'])
        : null;
    isNotify = json['isNotify'];
    isJoinFromLink = json['isJoinFromLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['totalMembers'] = totalMembers;
    data['numberUnread'] = numberUnread;
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    data['isNotify'] = isNotify;
    data['isJoinFromLink'] = isJoinFromLink;
    return data;
  }
}

class ImageAvatar {
  String? avatar;

  ImageAvatar({this.avatar});

  ImageAvatar.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    return data;
  }
}

class LastMessage {
  String? id;
  String? content;
  String? type;
  String? conversationId;

  String? createdAt;
  User? user;
  List<ManipulatedUsers>? manipulatedUsers;
  dynamic replyMessage;

  LastMessage({
    this.id,
    this.content,
    this.type,
    this.conversationId,
    this.createdAt,
    this.user,
    this.manipulatedUsers,
    this.replyMessage,
  });

  LastMessage.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    type = json['type'];
    conversationId = json['conversationId'];
    createdAt = json['createdAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['manipulatedUsers'] != null) {
      manipulatedUsers = <ManipulatedUsers>[];
      json['manipulatedUsers'].forEach((v) {
        manipulatedUsers!.add(ManipulatedUsers.fromJson(v));
      });
    }

    replyMessage = json['replyMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['content'] = content;
    data['type'] = type;
    data['conversationId'] = conversationId;

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

class User {
  String? id;
  String? fullName;
  String? avatar;

  User({this.id, this.fullName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
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

class ManipulatedUsers {
  String? id;
  String? fullName;
  String? avatar;

  ManipulatedUsers({this.id, this.fullName, this.avatar});

  ManipulatedUsers.fromJson(Map<String, dynamic> json) {
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
