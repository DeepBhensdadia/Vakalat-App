// To parse this JSON data, do
//
//     final changepassword = changepasswordFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Changepassword changepasswordFromJson(String str) => Changepassword.fromJson(json.decode(str));

String changepasswordToJson(Changepassword data) => json.encode(data.toJson());

class Changepassword {
  final int status;
  final String message;
  final Profile profile;

  Changepassword({
    required this.status,
    required this.message,
    required this.profile,
  });

  factory Changepassword.fromJson(Map<String, dynamic> json) => Changepassword(
    status: json["status"],
    message: json["message"],
    profile: Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "profile": profile.toJson(),
  };
}

class Profile {
  final int percentage;

  Profile({
    required this.percentage,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "percentage": percentage,
  };
}
