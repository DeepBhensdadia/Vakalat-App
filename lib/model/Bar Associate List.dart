// To parse this JSON data, do
//
//     final getbarAssociatList = getbarAssociatListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetbarAssociatList getbarAssociatListFromJson(String str) => GetbarAssociatList.fromJson(json.decode(str));

String getbarAssociatListToJson(GetbarAssociatList data) => json.encode(data.toJson());

class GetbarAssociatList {
  final int status;
  final String message;
  final List<BarAssoc> barAssoc;

  GetbarAssociatList({
    required this.status,
    required this.message,
    required this.barAssoc,
  });

  factory GetbarAssociatList.fromJson(Map<String, dynamic> json) => GetbarAssociatList(
    status: json["status"],
    message: json["message"],
    barAssoc: List<BarAssoc>.from(json["bar_assoc"].map((x) => BarAssoc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "bar_assoc": List<dynamic>.from(barAssoc.map((x) => x.toJson())),
  };
}

class BarAssoc {
  final String userId;
  final String lawFirmCollege;

  BarAssoc({
    required this.userId,
    required this.lawFirmCollege,
  });

  factory BarAssoc.fromJson(Map<String, dynamic> json) => BarAssoc(
    userId: json["user_id"],
    lawFirmCollege: json["law_firm_college"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "law_firm_college": lawFirmCollege,
  };
}
