// To parse this JSON data, do
//
//     final getupdatelanguage = getupdatelanguageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getupdatelanguage getupdatelanguageFromJson(String str) => Getupdatelanguage.fromJson(json.decode(str));

String getupdatelanguageToJson(Getupdatelanguage data) => json.encode(data.toJson());

class Getupdatelanguage {
  final int status;
  final String message;
  final dynamic csrfToken;

  Getupdatelanguage({
    required this.status,
    required this.message,
    required this.csrfToken,
  });

  factory Getupdatelanguage.fromJson(Map<String, dynamic> json) => Getupdatelanguage(
    status: json["status"],
    message: json["message"],
    csrfToken: json["csrf_token"]??"",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "csrf_token": csrfToken,
  };
}
