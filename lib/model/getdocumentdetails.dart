// To parse this JSON data, do
//
//     final getdocumentdetails = getdocumentdetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getdocumentdetails getdocumentdetailsFromJson(String str) => Getdocumentdetails.fromJson(json.decode(str));

String getdocumentdetailsToJson(Getdocumentdetails data) => json.encode(data.toJson());

class Getdocumentdetails {
  final int status;
  final String message;
  final List<DocType> docTypes;

  Getdocumentdetails({
    required this.status,
    required this.message,
    required this.docTypes,
  });

  factory Getdocumentdetails.fromJson(Map<String, dynamic> json) => Getdocumentdetails(
    status: json["status"],
    message: json["message"],
    docTypes: List<DocType>.from(json["doc_types"].map((x) => DocType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "doc_types": List<dynamic>.from(docTypes.map((x) => x.toJson())),
  };
}

class DocType {
  final String id;
  final String name;

  DocType({
    required this.id,
    required this.name,
  });

  factory DocType.fromJson(Map<String, dynamic> json) => DocType(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
