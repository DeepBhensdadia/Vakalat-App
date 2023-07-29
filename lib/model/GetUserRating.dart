// To parse this JSON data, do
//
//     final getUserRating = getUserRatingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetUserRating getUserRatingFromJson(String str) => GetUserRating.fromJson(json.decode(str));

String getUserRatingToJson(GetUserRating data) => json.encode(data.toJson());

class GetUserRating {
  final int status;
  final String message;
  final List<Rating> ratings;
  final int total;

  GetUserRating({
    required this.status,
    required this.message,
    required this.ratings,
    required this.total,
  });

  factory GetUserRating.fromJson(Map<String, dynamic> json) => GetUserRating(
    status: json["status"],
    message: json["message"],
    ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
    "total": total,
  };
}

class Rating {
  final String id;
  final String clientId;
  final String lawyerId;
  final String rating;
  final String review;
  final String status;
  final String createdAt;
  final dynamic updatedAt;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;

  Rating({
    required this.id,
    required this.clientId,
    required this.lawyerId,
    required this.rating,
    required this.review,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    clientId: json["client_id"],
    lawyerId: json["lawyer_id"],
    rating: json["rating"],
    review: json["review"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "lawyer_id": lawyerId,
    "rating": rating,
    "review": review,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "email": email,
  };
}
