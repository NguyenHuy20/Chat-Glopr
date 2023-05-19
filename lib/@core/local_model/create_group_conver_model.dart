class CreateGroupConverModel {
  String? name;
  List<String>? userIds;

  CreateGroupConverModel({required this.name, required this.userIds});

  Map<String, dynamic> toJson() => {'name': name, 'userIds': userIds};
}
