// To parse this JSON data, do
//
//     final getParticipation = getParticipationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetParticipation getParticipationFromJson(String str) => GetParticipation.fromJson(json.decode(str));

String getParticipationToJson(GetParticipation data) => json.encode(data.toJson());

class GetParticipation {
  GetParticipation({
    required this.status,
    required this.message,
    required this.participations,
    required this.total,
  });

  final int status;
  final String message;
  final List<Participation> participations;
  final int total;

  factory GetParticipation.fromJson(Map<String, dynamic> json) => GetParticipation(
    status: json["status"],
    message: json["message"],
    participations: List<Participation>.from(json["participations"].map((x) => Participation.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "participations": List<dynamic>.from(participations.map((x) => x.toJson())),
    "total": total,
  };
}

class Participation {
  Participation({
    required this.achievementId,
    required this.achievementMonth,
    required this.achievementYear,
    required this.achievementDetail,
    required this.achievementBody,
    required this.slug,
    required this.achievementCoverImage,
    required this.achievementIsdelete,
    required this.achievementCreatedBy,
    required this.userMasterId,
    required this.achievementCreatedDatetime,
    required this.achievementUpdatedBy,
    required this.achievementUpdatedDatetime,
    required this.type,
  });

  final String achievementId;
  final String achievementMonth;
  final String achievementYear;
  final String achievementDetail;
  final String achievementBody;
  final String slug;
  final String achievementCoverImage;
  final String achievementIsdelete;
  final String achievementCreatedBy;
  final String userMasterId;
  final String achievementCreatedDatetime;
  final String achievementUpdatedBy;
  final String achievementUpdatedDatetime;
  final String type;

  factory Participation.fromJson(Map<String, dynamic> json) => Participation(
    achievementId: json["achievement_id"],
    achievementMonth: json["achievement_month"],
    achievementYear: json["achievement_year"],
    achievementDetail: json["achievement_detail"],
    achievementBody: json["achievement_body"],
    slug: json["slug"],
    achievementCoverImage: json["achievement_cover_image"],
    achievementIsdelete: json["achievement_isdelete"],
    achievementCreatedBy: json["achievement_created_by"],
    userMasterId: json["user_master_id"],
    achievementCreatedDatetime: json["achievement_created_datetime"],
    achievementUpdatedBy: json["achievement_updated_by"],
    achievementUpdatedDatetime: json["achievement_updated_datetime"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "achievement_id": achievementId,
    "achievement_month": achievementMonth,
    "achievement_year": achievementYear,
    "achievement_detail": achievementDetail,
    "achievement_body": achievementBody,
    "slug": slug,
    "achievement_cover_image": achievementCoverImage,
    "achievement_isdelete": achievementIsdelete,
    "achievement_created_by": achievementCreatedBy,
    "user_master_id": userMasterId,
    "achievement_created_datetime": achievementCreatedDatetime,
    "achievement_updated_by": achievementUpdatedBy,
    "achievement_updated_datetime": achievementUpdatedDatetime,
    "type": type,
  };
}
