import 'dart:convert';
import 'package:dio/dio.dart';

AddServicesDataModel addServicesDataModelFromJson(String str) =>
    AddServicesDataModel.fromJson(json.decode(str));

String addServicesDataModelToJson(AddServicesDataModel data) =>
    json.encode(data.toJson());

class AddServicesDataModel {
  AddServicesDataModel({
    this.apiKey,
    this.detail,
    this.accessToken,
    this.userId,
    this.title,
    this.amount,
    this.smImage,
    this.device,
  });

  String? apiKey;
  String? detail;
  String? accessToken;
  String? userId;
  String? title;
  String? amount;
  dynamic smImage;
  String? device;

  AddServicesDataModel copyWith({
    String? apiKey,
    String? detail,
    String? accessToken,
    String? userId,
    String? title,
    String? amount,
    dynamic smImage,
    String? device,
  }) =>
      AddServicesDataModel(
        apiKey: apiKey ?? this.apiKey,
        detail: detail ?? this.detail,
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        smImage: smImage ?? this.smImage,
        device: device ?? this.device,
      );

  factory AddServicesDataModel.fromJson(Map<String, dynamic> json) =>
      AddServicesDataModel(
        apiKey: json["apiKey"],
        detail: json["detail"],
        accessToken: json["accessToken"],
        userId: json["user_id"],
        title: json["title"],
        amount: json["amount"],
        smImage: json["sm_image"],
        device: json["device"],
      );

  Map<String, dynamic> toJson() => {
        "apiKey": apiKey,
        "detail": detail,
        "accessToken": accessToken,
        "user_id": userId,
        "title": title,
        "amount": amount,
        "sm_image": smImage,
        "device": device,
      };

  Future<FormData> toFormData() async {

    MultipartFile? image;
    if(smImage != null){
      image = await MultipartFile.fromFile(smImage.toString());

    }
    return FormData.fromMap(copyWith(smImage: image).toJson());
  }
}
