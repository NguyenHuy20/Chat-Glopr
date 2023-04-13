class RequestOTPModel {
  String context;
  String identity;
  String method;
  String format;
  RequestOTPModel(
      {required this.context,
      required this.identity,
      required this.method,
      required this.format});

  Map<String, dynamic> toJson() => {
        'context': context,
        'identity': identity,
        'method': method,
        'format': format
      };
}
