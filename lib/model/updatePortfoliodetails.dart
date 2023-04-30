// To parse this JSON data, do
//
//     final updateportfoliodetails = updateportfoliodetailsFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

Updateportfoliodetails updateportfoliodetailsFromJson(String str) => Updateportfoliodetails.fromJson(json.decode(str));

String updateportfoliodetailsToJson(Updateportfoliodetails data) => json.encode(data.toJson());

class Updateportfoliodetails {
  String? apiKey;
  String? device;
  String? accessToken;
  String? userId;
  String? category;
  String? aboutUser;
  dynamic biodata;

  Updateportfoliodetails({
    this.apiKey,
    this.device,
    this.accessToken,
    this.userId,
    this.category,
    this.aboutUser,
    this.biodata,
  });

  Updateportfoliodetails copyWith({
    String? apiKey,
    String? device,
    String? accessToken,
    String? userId,
    String? category,
    String? aboutUser,
    dynamic biodata,
  }) =>
      Updateportfoliodetails(
        apiKey: apiKey ?? this.apiKey,
        device: device ?? this.device,
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
        category: category ?? this.category,
        aboutUser: aboutUser ?? this.aboutUser,
        biodata: biodata ?? this.biodata,
      );

  factory Updateportfoliodetails.fromJson(Map<String, dynamic> json) => Updateportfoliodetails(
    apiKey: json["apiKey"],
    device: json["device"],
    accessToken: json["accessToken"],
    userId: json["user_id"],
    category: json["category"],
    aboutUser: json["about_user"],
    biodata: json["biodata"],
  );

  Map<String, dynamic> toJson() => {
    "apiKey": apiKey,
    "device": device,
    "accessToken": accessToken,
    "user_id": userId,
    "category": category,
    "about_user": aboutUser,
    "biodata": biodata,
  };
  Future<FormData> toFormData() async {
    MultipartFile bio_data = await MultipartFile.fromFile(biodata.toString());

    return FormData.fromMap(copyWith(biodata: bio_data).toJson());
  }
}
