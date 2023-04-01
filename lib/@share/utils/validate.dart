String? validateMobile(String? value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  // String patttern = r'(^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$)';
  RegExp regExp = new RegExp(patttern);
  if (value == null || value.isEmpty) {
    return 'Vui lòng nhập số điện thoại';
  } else if (!regExp.hasMatch(value)) {
    return 'Số điện thoại không hợp lệ';
  }
  return null;
}

String? validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Email không hợp lệ';
  } else {
    return null;
  }
}

String? isValidPassword(String? password) {
  RegExp regex = RegExp(r'^.{6,20}$');
  if (regex.hasMatch(password ?? '')) {
    return null;
  }
  return 'Mật khẩu phải có ít nhất 6 kí tự';
}
