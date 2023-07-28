// To parse this JSON data, do
//
//     final getAchivements = getAchivementsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAchivements getAchivementsFromJson(String str) => GetAchivements.fromJson(json.decode(str));

String getAchivementsToJson(GetAchivements data) => json.encode(data.toJson());

class GetAchivements {
  final int status;
  final String message;
  final List<Achievement> achievements;
  final int total;

  GetAchivements({
    required this.status,
    required this.message,
    required this.achievements,
    required this.total,
  });

  factory GetAchivements.fromJson(Map<String, dynamic> json) => GetAchivements(
    status: json["status"],
    message: json["message"],
    achievements: List<Achievement>.from(json["achievements"].map((x) => Achievement.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "achievements": List<dynamic>.from(achievements.map((x) => x.toJson())),
    "total": total,
  };
}

class Achievement {
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
  final List<Otherimage> otherimages;

  Achievement({
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
    required this.otherimages,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
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
    otherimages: List<Otherimage>.from(json["otherimages"].map((x) => Otherimage.fromJson(x))),
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
    "otherimages": List<dynamic>.from(otherimages.map((x) => x.toJson())),
  };
}

class Otherimage {
  final String aiId;
  final String aiAchievementId;
  final String aiImages;
  final String aiIsdelete;
  final String aiCreatedBy;
  final String userMasterId;
  final String aiCreatedDatetime;
  final String aiUpdatedBy;
  final String aiUpdatedDatetime;

  Otherimage({
    required this.aiId,
    required this.aiAchievementId,
    required this.aiImages,
    required this.aiIsdelete,
    required this.aiCreatedBy,
    required this.userMasterId,
    required this.aiCreatedDatetime,
    required this.aiUpdatedBy,
    required this.aiUpdatedDatetime,
  });

  factory Otherimage.fromJson(Map<String, dynamic> json) => Otherimage(
    aiId: json["ai_id"],
    aiAchievementId: json["ai_achievement_id"],
    aiImages: json["ai_images"],
    aiIsdelete: json["ai_isdelete"],
    aiCreatedBy: json["ai_created_by"],
    userMasterId: json["user_master_id"],
    aiCreatedDatetime: json["ai_created_datetime"],
    aiUpdatedBy: json["ai_updated_by"],
    aiUpdatedDatetime: json["ai_updated_datetime"],
  );

  Map<String, dynamic> toJson() => {
    "ai_id": aiId,
    "ai_achievement_id": aiAchievementId,
    "ai_images": aiImages,
    "ai_isdelete": aiIsdelete,
    "ai_created_by": aiCreatedBy,
    "user_master_id": userMasterId,
    "ai_created_datetime": aiCreatedDatetime,
    "ai_updated_by": aiUpdatedBy,
    "ai_updated_datetime": aiUpdatedDatetime,
  };
}
