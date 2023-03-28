// To parse this JSON data, do
//
//     final clsForgotPasswordResponseModel = clsForgotPasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ClsForgotPasswordResponseModel clsForgotPasswordResponseModelFromJson(String str) => ClsForgotPasswordResponseModel.fromJson(json.decode(str));

String clsForgotPasswordResponseModelToJson(ClsForgotPasswordResponseModel data) => json.encode(data.toJson());

class ClsForgotPasswordResponseModel {
  ClsForgotPasswordResponseModel({
    required this.status,
    required this.message,
  });

  final int status;
  final String message;

  factory ClsForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) => ClsForgotPasswordResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
