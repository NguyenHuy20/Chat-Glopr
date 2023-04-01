class LoginModel {
  String identity;
  String password;

  LoginModel({required this.identity, required this.password});

  Map<String, dynamic> toJson() => {'identity': identity, 'password': password};
}
