class ChangePasswordModel {
  String? currentPassword;
  String? newPassword;

  ChangePasswordModel(
      {required this.currentPassword, required this.newPassword});

  Map<String, dynamic> toJson() =>
      {'currentPassword': currentPassword, 'newPassword': newPassword};
}
