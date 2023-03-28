// To parse this JSON data, do
//
//     final clsUpdateSocialResponseModel = clsUpdateSocialResponseModelFromJson(jsonString);

import 'dart:convert';

ClsUpdateSocialResponseModel clsUpdateSocialResponseModelFromJson(String str) => ClsUpdateSocialResponseModel.fromJson(json.decode(str));

String clsUpdateSocialResponseModelToJson(ClsUpdateSocialResponseModel data) => json.encode(data.toJson());

class ClsUpdateSocialResponseModel {
  ClsUpdateSocialResponseModel({
    required this.status,
    required this.message,
  });

  final int status;
  final String message;

  factory ClsUpdateSocialResponseModel.fromJson(Map<String, dynamic> json) => ClsUpdateSocialResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
