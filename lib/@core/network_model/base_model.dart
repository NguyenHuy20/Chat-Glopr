class BaseModel {
  BaseModel({
    this.success,
    required this.statusCode,
    required this.message,
    this.dynamicData,
  });

  bool? success;
  int statusCode;
  String message;
  dynamic dynamicData;

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        dynamicData: json["data"],
      );
}
