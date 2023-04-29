class UpdateUserInfoModel {
  String email;
  String fullName;
  String phoneNumber;
  String gender;
  String dob;
  String avatar;

  UpdateUserInfoModel(
      {required this.email,
      required this.fullName,
      required this.phoneNumber,
      required this.gender,
      required this.dob,
      required this.avatar});

  Map<String, dynamic> toJson() => {
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'dob': dob,
        'avatar': avatar,
      };
}
