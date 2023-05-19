class AddMemberModel {
  String? converId;
  List<String>? userIds;

  AddMemberModel({required this.converId, required this.userIds});

  Map<String, dynamic> toJson() => {'converId': converId, 'userIds': userIds};
}
