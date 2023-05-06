// To parse this JSON data, do
//
//     final getdiscountmodel = getdiscountmodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getdiscountmodel getdiscountmodelFromJson(String str) => Getdiscountmodel.fromJson(json.decode(str));

String getdiscountmodelToJson(Getdiscountmodel data) => json.encode(data.toJson());

class Getdiscountmodel {
  final int status;
  final String message;
  final String type;
  final String amount;

  Getdiscountmodel({
    required this.status,
    required this.message,
    required this.type,
    required this.amount,
  });

  factory Getdiscountmodel.fromJson(Map<String, dynamic> json) => Getdiscountmodel(
    status: json["status"],
    message: json["message"],
    type: json["type"] ?? "",
    amount: json["amount"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "type": type,
    "amount": amount,
  };
}
