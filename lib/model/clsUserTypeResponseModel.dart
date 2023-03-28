
import 'dart:convert';

ClsUserTypeResponseModel clsUserTypeResponseModelFromJson(String str) => ClsUserTypeResponseModel.fromJson(json.decode(str));

String clsUserTypeResponseModelToJson(ClsUserTypeResponseModel data) => json.encode(data.toJson());

class ClsUserTypeResponseModel {
  ClsUserTypeResponseModel({
    required this.status,
    required this.message,
    required this.userType,
  });

  final int status;
  final String message;
  final List<UserType> userType;

  factory ClsUserTypeResponseModel.fromJson(Map<String, dynamic> json) => ClsUserTypeResponseModel(
    status: json["status"],
    message: json["message"],
    userType: List<UserType>.from(json["user_type"].map((x) => UserType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user_type": List<dynamic>.from(userType.map((x) => x.toJson())),
  };
}

class UserType {
  UserType({
    required this.utId,
    required this.utName,
  });

  final String utId;
  final String utName;

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
    utId: json["ut_id"],
    utName: json["ut_name"],
  );

  Map<String, dynamic> toJson() => {
    "ut_id": utId,
    "ut_name": utName,
  };
}
