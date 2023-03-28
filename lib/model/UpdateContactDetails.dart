// To parse this JSON data, do
//
//     final clsUpdateContactResponseModel = clsUpdateContactResponseModelFromJson(jsonString);

import 'dart:convert';

ClsUpdateContactResponseModel clsUpdateContactResponseModelFromJson(String str) => ClsUpdateContactResponseModel.fromJson(json.decode(str));

String clsUpdateContactResponseModelToJson(ClsUpdateContactResponseModel data) => json.encode(data.toJson());

class ClsUpdateContactResponseModel {
  ClsUpdateContactResponseModel({
    required this.status,
    required this.message,
  });

  final int status;
  final String message;

  factory ClsUpdateContactResponseModel.fromJson(Map<String, dynamic> json) => ClsUpdateContactResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
