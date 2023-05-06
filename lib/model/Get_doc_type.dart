// To parse this JSON data, do
//
//     final docTypeGet = docTypeGetFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DocTypeGet docTypeGetFromJson(String str) => DocTypeGet.fromJson(json.decode(str));

String docTypeGetToJson(DocTypeGet data) => json.encode(data.toJson());

class DocTypeGet {
  final int status;
  final String message;
  final dynamic csrfToken;
  final List<DocType> docType;
  final int total;

  DocTypeGet({
    required this.status,
    required this.message,
    required this.csrfToken,
    required this.docType,
    required this.total,
  });

  factory DocTypeGet.fromJson(Map<String, dynamic> json) => DocTypeGet(
    status: json["status"],
    message: json["message"],
    csrfToken: json["csrf_token"],
    docType: List<DocType>.from(json["doc_type"].map((x) => DocType.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "csrf_token": csrfToken,
    "doc_type": List<dynamic>.from(docType.map((x) => x.toJson())),
    "total": total,
  };
}

class DocType {
  final String id;
  final String name;
  final String createdBy;
  final String behalfOfId;
  final String userMasterId;
  final String createdDatetime;
  final String updatedBy;
  final String updatedDatetime;
  final String isDelete;

  DocType({
    required this.id,
    required this.name,
    required this.createdBy,
    required this.behalfOfId,
    required this.userMasterId,
    required this.createdDatetime,
    required this.updatedBy,
    required this.updatedDatetime,
    required this.isDelete,
  });

  factory DocType.fromJson(Map<String, dynamic> json) => DocType(
    id: json["id"],
    name: json["name"],
    createdBy: json["created_by"],
    behalfOfId: json["behalf_of_id"],
    userMasterId: json["user_master_id"],
    createdDatetime: json["created_datetime"],
    updatedBy: json["updated_by"],
    updatedDatetime: json["updated_datetime"],
    isDelete: json["is_delete"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_by": createdBy,
    "behalf_of_id": behalfOfId,
    "user_master_id": userMasterId,
    "created_datetime": createdDatetime,
    "updated_by": updatedBy,
    "updated_datetime": updatedDatetime,
    "is_delete": isDelete,
  };
}
