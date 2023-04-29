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
  String? avatar;
  String? userId;
  String? friendStatus;
  bool? isOnline;
  String? lastLogin;
  bool? type;
  int? totalMembers;
  int? numberUnread;
  LastMessage? lastMessage;
  bool? isNotify;
  bool? isJoinFromLink;

  ConversationData(
      {this.id,
      this.name,
      this.avatar,
      this.userId,
      this.friendStatus,
      this.isOnline,
      this.lastLogin,
      this.type,
      this.totalMembers,
      this.numberUnread,
      this.lastMessage,
      this.isNotify,
      this.isJoinFromLink});

  ConversationData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    avatar = json['avatar'];
    userId = json['userId'];
    friendStatus = json['friendStatus'];
    isOnline = json['isOnline'];
    lastLogin = json['lastLogin'];
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
    data['avatar'] = avatar;
    data['userId'] = userId;
    data['friendStatus'] = friendStatus;
    data['isOnline'] = isOnline;
    data['lastLogin'] = lastLogin;
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

class LastMessage {
  String? sId;
  String? content;
  String? type;
  String? conversationId;
  String? createdAt;
  dynamic replyMessage;
  List<Participants>? participants;
  User? user;

  LastMessage({
    this.sId,
    this.content,
    this.type,
    this.conversationId,
    this.createdAt,
    this.replyMessage,
    this.participants,
    this.user,
  });

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    type = json['type'];
    conversationId = json['conversationId'];
    createdAt = json['createdAt'];
    replyMessage = json['replyMessage'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    data['type'] = type;
    data['conversationId'] = conversationId;
    data['createdAt'] = createdAt;
    data['replyMessage'] = replyMessage;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}

class Participants {
  String? userId;

  Participants({this.userId});

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }
}

class User {
  String? id;
  String? avatar;

  User({this.id, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['avatar'] = avatar;
    return data;
  }
}
