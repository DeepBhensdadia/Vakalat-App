

import 'dart:convert';

import 'package:dio/dio.dart';

EditParticipationModel EditParticipationModelFromJson(String str) => EditParticipationModel.fromJson(json.decode(str));

String EditParticipationModelToJson(EditParticipationModel data) => json.encode(data.toJson());

class EditParticipationModel {
  String? apiKey;
  String? detail;
  String? accessToken;
  String? userId;
  String? title;
  String? month;
  String? year;
  String? device;
  String? csrfToken;
  String? participationId;
  dynamic coverPic;
  dynamic otherImages;

  EditParticipationModel({
    this.apiKey,
    this.detail,
    this.accessToken,
    this.userId,
    this.title,
    this.month,
    this.year,
    this.device,
    this.csrfToken,
    this.participationId,
    this.coverPic,
    this.otherImages,
  });

  EditParticipationModel copyWith({
    String? apiKey,
    String? detail,
    String? accessToken,
    String? userId,
    String? title,
    String? month,
    String? year,
    String? device,
    String? csrfToken,
    String? participationId,
    dynamic coverPic,
    dynamic otherImages,
  }) =>
      EditParticipationModel(
        apiKey: apiKey ?? this.apiKey,
        detail: detail ?? this.detail,
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        month: month ?? this.month,
        year: year ?? this.year,
        device: device ?? this.device,
        csrfToken: csrfToken ?? this.csrfToken,
        participationId: participationId ?? this.participationId,
        coverPic: coverPic ?? this.coverPic,
        otherImages: otherImages ?? this.otherImages,
      );

  factory EditParticipationModel.fromJson(Map<String, dynamic> json) => EditParticipationModel(
    apiKey: json["apiKey"],
    detail: json["detail"],
    accessToken: json["accessToken"],
    userId: json["user_id"],
    title: json["title"],
    month: json["month"],
    year: json["year"],
    device: json["device"],
    csrfToken: json["csrf_token"],
    participationId: json["participation_id"],
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
    "participation_id": participationId,
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
