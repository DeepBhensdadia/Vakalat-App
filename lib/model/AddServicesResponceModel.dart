// To parse this JSON data, do
//
//     final addServicesResponceModel = addServicesResponceModelFromJson(jsonString);

import 'dart:convert';

AddServicesResponceModel addServicesResponceModelFromJson(String str) => AddServicesResponceModel.fromJson(json.decode(str));

String addServicesResponceModelToJson(AddServicesResponceModel data) => json.encode(data.toJson());

class AddServicesResponceModel {
  AddServicesResponceModel({
    required this.status,
    required this.message,
  });

  final int status;
  final String message;

  factory AddServicesResponceModel.fromJson(Map<String, dynamic> json) => AddServicesResponceModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
