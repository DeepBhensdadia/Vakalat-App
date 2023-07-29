// To parse this JSON data, do
//
//     final addAchivementModel = addAchivementModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

AddAchivementModel addAchivementModelFromJson(String str) =>
    AddAchivementModel.fromJson(json.decode(str));

String addAchivementModelToJson(AddAchivementModel data) =>
    json.encode(data.toJson());

class AddAchivementModel {
  String? apiKey;
  String? detail;
  String? accessToken;
  String? userId;
  String? title;
  String? month;
  String? year;
  String? device;
  String? csrfToken;
  dynamic coverPic;
  dynamic otherImages;

  AddAchivementModel({
    this.apiKey,
    this.detail,
    this.accessToken,
    this.userId,
    this.title,
    this.month,
    this.year,
    this.device,
    this.csrfToken,
    this.coverPic,
    this.otherImages,
  });

  AddAchivementModel copyWith({
    String? apiKey,
    String? detail,
    String? accessToken,
    String? userId,
    String? title,
    String? month,
    String? year,
    String? device,
    String? csrfToken,
    dynamic coverPic,
    dynamic otherImages,
  }) =>
      AddAchivementModel(
        apiKey: apiKey ?? this.apiKey,
        detail: detail ?? this.detail,
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        month: month ?? this.month,
        year: year ?? this.year,
        device: device ?? this.device,
        csrfToken: csrfToken ?? this.csrfToken,
        coverPic: coverPic ?? this.coverPic,
        otherImages: otherImages ?? this.otherImages,
      );

  factory AddAchivementModel.fromJson(Map<String, dynamic> json) =>
      AddAchivementModel(
        apiKey: json["apiKey"],
        detail: json["detail"],
        accessToken: json["accessToken"],
        userId: json["user_id"],
        title: json["title"],
        month: json["month"],
        year: json["year"],
        device: json["device"],
        csrfToken: json["csrf_token"],
        coverPic: json["cover_pic"],
        otherImages: json["other_images[]"],
      );

  Map<String, dynamic> toJson() => {
        "apiKey": apiKey,
        "detail": detail,
        "accessToken": accessToken,
        "user_id": userId,
        "title": title,
        "month": month,
        "year": year,
        "device": device,
        "csrf_token": csrfToken,
        "cover_pic": coverPic,
        "other_images[]": otherImages,
      };
  Future<FormData> toFormData() async {
    MultipartFile? coverimage;
    List<MultipartFile>? otherimage;
    if (coverPic != null) {
      coverimage = await MultipartFile.fromFile(coverPic.toString());
    }
    if (otherImages != null) {
      List<MultipartFile> data = <MultipartFile>[];

      for (String sin in otherImages) {
        data.add(await MultipartFile.fromFile(sin.toString()));
      }

      otherimage = data;
    }
    return FormData.fromMap(
        copyWith(coverPic: coverimage, otherImages: otherimage).toJson());
  }
}
