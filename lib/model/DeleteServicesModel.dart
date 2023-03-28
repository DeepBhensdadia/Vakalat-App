// To parse this JSON data, do
//
//     final deleteServicesModel = deleteServicesModelFromJson(jsonString);

import 'dart:convert';

DeleteServicesModel deleteServicesModelFromJson(String str) => DeleteServicesModel.fromJson(json.decode(str));

String deleteServicesModelToJson(DeleteServicesModel data) => json.encode(data.toJson());

class DeleteServicesModel {
  DeleteServicesModel({
    required this.status,
    required this.message,
  });

  final int status;
  final String message;

  factory DeleteServicesModel.fromJson(Map<String, dynamic> json) => DeleteServicesModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
