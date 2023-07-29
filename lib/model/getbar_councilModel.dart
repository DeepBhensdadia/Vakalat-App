// To parse this JSON data, do
//
//     final getbarCouncillist = getbarCouncillistFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetbarCouncillist getbarCouncillistFromJson(String str) => GetbarCouncillist.fromJson(json.decode(str));

String getbarCouncillistToJson(GetbarCouncillist data) => json.encode(data.toJson());

class GetbarCouncillist {
  final int status;
  final String message;
  final List<BarCouncil> barCouncils;

  GetbarCouncillist({
    required this.status,
    required this.message,
    required this.barCouncils,
  });

  factory GetbarCouncillist.fromJson(Map<String, dynamic> json) => GetbarCouncillist(
    status: json["status"],
    message: json["message"],
    barCouncils: List<BarCouncil>.from(json["bar_councils"].map((x) => BarCouncil.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "bar_councils": List<dynamic>.from(barCouncils.map((x) => x.toJson())),
  };
}

class BarCouncil {
  final String userId;
  final String lawFirmCollege;

  BarCouncil({
    required this.userId,
    required this.lawFirmCollege,
  });

  factory BarCouncil.fromJson(Map<String, dynamic> json) => BarCouncil(
    userId: json["user_id"],
    lawFirmCollege: json["law_firm_college"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "law_firm_college": lawFirmCollege,
  };
}
