// To parse this JSON data, do
//
//     final updateproffetional = updateproffetionalFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';

Updateproffetional updateproffetionalFromJson(String str) => Updateproffetional.fromJson(json.decode(str));

String updateproffetionalToJson(Updateproffetional data) => json.encode(data.toJson());

class Updateproffetional {
  String? apiKey;
  String? device;
  String? accessToken;
  String? userId;
  String? sanadRegNo;
  String? sanadRegYear;
  String? sanadRegDate;
  String? welfareNo;
  String? welfareDate;
  String? distCourtRegiNo;
  String? distCourtRegiDate;
  String? councilId;
  String? associationId;
  String? lawFirmName;
  String? assoMemberNo;
  String? qualification;
  String? experience;
  String? notaryNo;

  String? docTypeId;
  dynamic document1;

  dynamic document2;

  Updateproffetional({
    this.apiKey,
    this.device,
    this.accessToken,
    this.userId,
    this.sanadRegNo,
    this.sanadRegYear,
    this.sanadRegDate,
    this.welfareNo,
    this.welfareDate,
    this.distCourtRegiNo,
    this.distCourtRegiDate,
    this.councilId,
    this.associationId,
    this.lawFirmName,
    this.assoMemberNo,
    this.qualification,
    this.experience,
    this.notaryNo,
    this.docTypeId,
    this.document1,
    this.document2,
  });

  Updateproffetional copyWith({
    String? apiKey,
    String? device,
    String? accessToken,
    String? userId,
    String? sanadRegNo,
    String? sanadRegYear,
    String? sanadRegDate,
    String? welfareNo,
    String? welfareDate,
    String? distCourtRegiNo,
    String? distCourtRegiDate,
    String? councilId,
    String? associationId,
    String? lawFirmName,
    String? assoMemberNo,
    String? qualification,
    String? experience,
    String? notaryNo,

    String? docTypeId,
    dynamic document1,

    dynamic document2,
  }) =>
      Updateproffetional(
        apiKey: apiKey ?? this.apiKey,
        device: device ?? this.device,
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
        sanadRegNo: sanadRegNo ?? this.sanadRegNo,
        sanadRegYear: sanadRegYear ?? this.sanadRegYear,
        sanadRegDate: sanadRegDate ?? this.sanadRegDate,
        welfareNo: welfareNo ?? this.welfareNo,
        welfareDate: welfareDate ?? this.welfareDate,
        distCourtRegiNo: distCourtRegiNo ?? this.distCourtRegiNo,
        distCourtRegiDate: distCourtRegiDate ?? this.distCourtRegiDate,
        councilId: councilId ?? this.councilId,
        associationId: associationId ?? this.associationId,
        lawFirmName: lawFirmName ?? this.lawFirmName,
        assoMemberNo: assoMemberNo ?? this.assoMemberNo,
        qualification: qualification ?? this.qualification,
        experience: experience ?? this.experience,
        notaryNo: notaryNo ?? this.notaryNo,
        docTypeId: docTypeId ?? this.docTypeId,
        document1: document1 ?? this.document1,
        document2: document2 ?? this.document2,
      );

  factory Updateproffetional.fromJson(Map<String, dynamic> json) => Updateproffetional(
    apiKey: json["apiKey"],
    device: json["device"],
    accessToken: json["accessToken"],
    userId: json["user_id"],
    sanadRegNo: json["sanad_reg_no"],
    sanadRegYear: json["sanad_reg_year"],
    sanadRegDate: json["sanad_reg_date"],
    welfareNo: json["welfare_no"],
    welfareDate: json["welfare_date"],
    distCourtRegiNo: json["dist_court_regi_no"],
    distCourtRegiDate: json["dist_court_regi_date"],
    councilId: json["council_id"],
    associationId: json["association_id"],
    lawFirmName: json["law_firm_name"],
    assoMemberNo: json["asso_member_no"],
    qualification: json["qualification"],
    experience: json["experience"],
    notaryNo: json["notary_no"],

    docTypeId: json["doc_type_id"],
    document1: json["document1"],

    document2: json["document2"],
  );

  Map<String, dynamic> toJson() => {
    "apiKey": apiKey,
    "device": device,
    "accessToken": accessToken,
    "user_id": userId,
    "sanad_reg_no": sanadRegNo,
    "sanad_reg_year": sanadRegYear,
    "sanad_reg_date": sanadRegDate,
    "welfare_no": welfareNo,
    "welfare_date": welfareDate,
    "dist_court_regi_no": distCourtRegiNo,
    "dist_court_regi_date": distCourtRegiDate,
    "council_id": councilId,
    "association_id": associationId,
    "law_firm_name": lawFirmName,
    "asso_member_no": assoMemberNo,
    "qualification": qualification,
    "experience": experience,
    "notary_no": notaryNo,
    "doc_type_id": docTypeId,
    "document1": document1,

    "document2": document2,
  };
  Future<FormData> toFormData() async {
    MultipartFile? sanadcer;
    MultipartFile? othercer;
    if (document1 != null) {
      sanadcer = await MultipartFile.fromFile(document1.toString());
    } if (document2 != null) {
      othercer = await MultipartFile.fromFile(document2.toString());
    }
    return FormData.fromMap(copyWith(document1: sanadcer,document2: othercer).toJson());
  }
}
