// To parse this JSON data, do
//
//     final clsRegisterResponseModel = clsRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

ClsRegisterResponseModel clsRegisterResponseModelFromJson(String str) => ClsRegisterResponseModel.fromJson(json.decode(str));

String clsRegisterResponseModelToJson(ClsRegisterResponseModel data) => json.encode(data.toJson());

class ClsRegisterResponseModel {
  ClsRegisterResponseModel({
    required this.status,
    required this.message,
  });

  final int status;
  final String message;

  factory ClsRegisterResponseModel.fromJson(Map<String, dynamic> json) => ClsRegisterResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
