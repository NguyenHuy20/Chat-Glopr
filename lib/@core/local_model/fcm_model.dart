class FCMModel {
  String fcmToken;
  String deviceUuid;

  FCMModel({required this.fcmToken, required this.deviceUuid});

  Map<String, dynamic> toJson() =>
      {'fcmToken': fcmToken, 'deviceUuid': deviceUuid};
}
