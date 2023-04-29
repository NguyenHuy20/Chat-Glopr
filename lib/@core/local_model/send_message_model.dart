class SendMessageModel {
  String content;
  String desId;

  SendMessageModel({
    required this.content,
    required this.desId,
  });

  Map<String, dynamic> toJson() => {
        'content': content,
        'desId': desId,
      };
}
