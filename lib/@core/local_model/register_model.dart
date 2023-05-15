class RegisterModel {
  String fullName;
  String userName;
  String identity;
  String password;
  String otpCode;
  String gender;
  RegisterModel({
    required this.fullName,
    required this.userName,
    required this.identity,
    required this.password,
    required this.otpCode,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'userName': userName,
        'identity': identity,
        'password': password,
        'otpCode': otpCode,
        'gender': gender,
      };
}
