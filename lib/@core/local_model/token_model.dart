class TokenModel {
  String? accessToken, refreshToken;

  TokenModel({
    this.accessToken,
    this.refreshToken,
  });

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() =>
      {'accessToken': accessToken, 'refreshToken': refreshToken};
}
