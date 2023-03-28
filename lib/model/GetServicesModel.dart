// To parse this JSON data, do
//
//     final clsGetServicesResponseModel = clsGetServicesResponseModelFromJson(jsonString);

import 'dart:convert';

ClsGetServicesResponseModel clsGetServicesResponseModelFromJson(String str) => ClsGetServicesResponseModel.fromJson(json.decode(str));

String clsGetServicesResponseModelToJson(ClsGetServicesResponseModel data) => json.encode(data.toJson());

class ClsGetServicesResponseModel {
  ClsGetServicesResponseModel({
    required this.status,
    required this.message,
    required this.services,
    required this.total,
  });

  final int status;
  final String message;
  final List<Service> services;
  final int total;

  factory ClsGetServicesResponseModel.fromJson(Map<String, dynamic> json) => ClsGetServicesResponseModel(
    status: json["status"],
    message: json["message"],
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "services": List<dynamic>.from(services.map((x) => x.toJson())),
    "total": total,
  };
}

class Service {
  Service({
    required this.smId,
    required this.smUsertypeId,
    required this.smTitle,
    required this.smDetails,
    required this.smImage,
    required this.smAmount,
    required this.createdBy,
    required this.behalfOfId,
    required this.createdDatetime,
    required this.updatedBy,
    required this.updatedDatetime,
    required this.isDelete,
  });

  final String smId;
  final String smUsertypeId;
  final String smTitle;
  final String smDetails;
  final String smImage;
  final String smAmount;
  final String createdBy;
  final String behalfOfId;
  final String createdDatetime;
  final String updatedBy;
  final String updatedDatetime;
  final String isDelete;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    smId: json["sm_id"],
    smUsertypeId: json["sm_usertype_id"],
    smTitle: json["sm_title"],
    smDetails: json["sm_details"],
    smImage: json["sm_image"],
    smAmount: json["sm_amount"],
    createdBy: json["created_by"],
    behalfOfId: json["behalf_of_id"],
    createdDatetime: json["created_datetime"],
    updatedBy: json["updated_by"],
    updatedDatetime: json["updated_datetime"],
    isDelete: json["is_delete"],
  );

  Map<String, dynamic> toJson() => {
    "sm_id": smId,
    "sm_usertype_id": smUsertypeId,
    "sm_title": smTitle,
    "sm_details": smDetails,
    "sm_image": smImage,
    "sm_amount": smAmount,
    "created_by": createdBy,
    "behalf_of_id": behalfOfId,
    "created_datetime": createdDatetime,
    "updated_by": updatedBy,
    "updated_datetime": updatedDatetime,
    "is_delete": isDelete,
  };
}
