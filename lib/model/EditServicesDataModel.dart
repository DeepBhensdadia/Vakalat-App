import 'dart:convert';
import 'package:dio/dio.dart';

EditServicesDataModel EditServicesDataModelFromJson(String str) =>
    EditServicesDataModel.fromJson(json.decode(str));

String EditServicesDataModelToJson(EditServicesDataModel data) =>
    json.encode(data.toJson());

class EditServicesDataModel {
  EditServicesDataModel({
    this.apiKey,
    this.detail,
    this.accessToken,
    this.userId,
    this.title,
    this.amount,
    this.smImage,
    this.device,
    this.service_id,
  });

  String? apiKey;
  String? detail;
  String? accessToken;
  String? userId;
  String? service_id;
  String? title;
  String? amount;
  dynamic smImage;
  String? device;

  EditServicesDataModel copyWith({
    String? apiKey,
    String? detail,
    String? accessToken,
    String? userId,
    String? service_id,
    String? title,
    String? amount,
    dynamic smImage,
    String? device,
  }) =>
      EditServicesDataModel(
        apiKey: apiKey ?? this.apiKey,
        detail: detail ?? this.detail,
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
        service_id: service_id ?? this.service_id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        smImage: smImage ?? this.smImage,
        device: device ?? this.device,
      );

  factory EditServicesDataModel.fromJson(Map<String, dynamic> json) =>
      EditServicesDataModel(
        apiKey: json["apiKey"],
        detail: json["detail"],
        accessToken: json["accessToken"],
        userId: json["user_id"],
        service_id: json["service_id"],
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
    "service_id": service_id,
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
