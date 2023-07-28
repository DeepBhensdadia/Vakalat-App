// To parse this JSON data, do
//
//     final getalllanguage = getalllanguageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getalllanguage getalllanguageFromJson(String str) => Getalllanguage.fromJson(json.decode(str));

String getalllanguageToJson(Getalllanguage data) => json.encode(data.toJson());

class Getalllanguage {
  final int status;
  final String message;
  final List<Language> languages;

  Getalllanguage({
    required this.status,
    required this.message,
    required this.languages,
  });

  factory Getalllanguage.fromJson(Map<String, dynamic> json) => Getalllanguage(
    status: json["status"],
    message: json["message"],
    languages: List<Language>.from(json["languages"].map((x) => Language.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
  };
}

class Language {
  final String id;
  final String title;
  final dynamic description;
  final dynamic slug;
  final String code;
  final String isDelete;
  final String isActive;
  final String createdBy;
  final dynamic createdDatetime;
  final String updatedBy;
  final dynamic updatedDatetime;

  Language({
    required this.id,
    required this.title,
    required this.description,
    required this.slug,
    required this.code,
    required this.isDelete,
    required this.isActive,
    required this.createdBy,
    required this.createdDatetime,
    required this.updatedBy,
    required this.updatedDatetime,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    slug: json["slug"],
    code: json["code"],
    isDelete: json["is_delete"],
    isActive: json["is_active"],
    createdBy: json["created_by"],
    createdDatetime: json["created_datetime"],
    updatedBy: json["updated_by"],
    updatedDatetime: json["updated_datetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "slug": slug,
    "code": code,
    "is_delete": isDelete,
    "is_active": isActive,
    "created_by": createdBy,
    "created_datetime": createdDatetime,
    "updated_by": updatedBy,
    "updated_datetime": updatedDatetime,
  };
}
