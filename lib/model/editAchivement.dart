// To parse this JSON data, do
//
//     final EditAchivementModel = EditAchivementModelFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

EditAchivementModel EditAchivementModelFromJson(String str) => EditAchivementModel.fromJson(json.decode(str));

String EditAchivementModelToJson(EditAchivementModel data) => json.encode(data.toJson());

class EditAchivementModel {
  String? apiKey;
  String? detail;
  String? accessToken;
  String? userId;
  String? title;
  String? month;
  String? year;
  String? device;
  String? csrfToken;
  String? achievementId;
  dynamic coverPic;
  dynamic otherImages;

  EditAchivementModel({
    this.apiKey,
    this.detail,
    this.accessToken,
    this.userId,
    this.title,
    this.month,
    this.year,
    this.device,
    this.csrfToken,
    this.achievementId,
    this.coverPic,
    this.otherImages,
  });

  EditAchivementModel copyWith({
    String? apiKey,
    String? detail,
    String? accessToken,
    String? userId,
    String? title,
    String? month,
    String? year,
    String? device,
    String? csrfToken,
    String? achievementId,
    dynamic coverPic,
    dynamic otherImages,
  }) =>
      EditAchivementModel(
        apiKey: apiKey ?? this.apiKey,
        detail: detail ?? this.detail,
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        month: month ?? this.month,
        year: year ?? this.year,
        device: device ?? this.device,
        csrfToken: csrfToken ?? this.csrfToken,
        achievementId: achievementId ?? this.achievementId,
        coverPic: coverPic ?? this.coverPic,
        otherImages: otherImages ?? this.otherImages,
      );

  factory EditAchivementModel.fromJson(Map<String, dynamic> json) => EditAchivementModel(
    apiKey: json["apiKey"],
    detail: json["detail"],
    accessToken: json["accessToken"],
    userId: json["user_id"],
    title: json["title"],
    month: json["month"],
    year: json["year"],
    device: json["device"],
    csrfToken: json["csrf_token"],
    achievementId: json["achievement_id"],
    coverPic: json["cover_pic"],
    otherImages: json["other_images"],
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
    "achievement_id": achievementId,
    "cover_pic": coverPic,
    "other_images": otherImages,
  };
  Future<FormData> toFormData() async {
    MultipartFile coverimage = await MultipartFile.fromFile(coverPic.toString());
    MultipartFile otherimage = await MultipartFile.fromFile(otherImages.toString());
    return FormData.fromMap(copyWith(coverPic: coverimage,otherImages: otherimage).toJson());
  }
}
