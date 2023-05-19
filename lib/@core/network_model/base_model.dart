class BaseModel {
  BaseModel({
    this.success,
    this.statusCode,
    this.message,
    this.dynamicData,
  });

  bool? success;
  dynamic statusCode;
  String? message;
  dynamic dynamicData;

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        dynamicData: json["data"],
      );
}
