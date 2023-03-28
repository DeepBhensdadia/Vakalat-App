// To parse this JSON data, do
//
//     final clsUpdatePersonalResponseModel = clsUpdatePersonalResponseModelFromJson(jsonString);

import 'dart:convert';

ClsUpdatePersonalResponseModel clsUpdatePersonalResponseModelFromJson(String str) => ClsUpdatePersonalResponseModel.fromJson(json.decode(str));

String clsUpdatePersonalResponseModelToJson(ClsUpdatePersonalResponseModel data) => json.encode(data.toJson());

class ClsUpdatePersonalResponseModel {
  ClsUpdatePersonalResponseModel({
    required this.status,
    required this.message,
  });

  final int status;
  final String message;

  factory ClsUpdatePersonalResponseModel.fromJson(Map<String, dynamic> json) => ClsUpdatePersonalResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
