
import 'dart:convert';

ClsLoginResponseModel clsLoginResponseModelFromJson(String str) => ClsLoginResponseModel.fromJson(json.decode(str));

String clsLoginResponseModelToJson(ClsLoginResponseModel data) => json.encode(data.toJson());

class ClsLoginResponseModel {
  ClsLoginResponseModel({
    required this.status,
    required this.message,
    required this.accessToken,
    required this.userData,
  });

  final int status;
  final String message;
  final String accessToken;
  final UserData userData;

  factory ClsLoginResponseModel.fromJson(Map<String, dynamic> json) => ClsLoginResponseModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"] ?? "",
    userData: UserData.fromJson(json["user_data"]) ,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "user_data": userData.toJson(),
  };
}

class UserData {
  UserData({
    required this.userId,
    required this.organizationName,
    required this.userFname,
    required this.userLname,
    required this.userEmail,
    required this.userMobile,
    required this.userType,
    required this.parentUserType,
    required this.userCity,
    required this.userParentId,
    required this.isFeesPaid,
    required this.currentPkgId,
    required this.lastFeesDate,
    required this.profilePic,
    required this.dob,
    required this.accessToken,
    required this.userLoggedIn,
    required this.profileSelected,
    required this.parentId,
    required this.conId,
    required this.userCountryId,
  });

  final String userId;
  final String organizationName;
  final String userFname;
  final String userLname;
  final String userEmail;
  final String userMobile;
  final String userType;
  final int parentUserType;
  final String userCity;
  final String userParentId;
  final String isFeesPaid;
  final String currentPkgId;
  final DateTime lastFeesDate;
  final String profilePic;
  final String dob;
  final String accessToken;
  final bool userLoggedIn;
  final int profileSelected;
  final String parentId;
  final String conId;
  final String userCountryId;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    userId: json["user_id"],
    organizationName: json["organization_name"]==null?"":json["organization_name"].toString(),
    userFname: json["user_fname"],
    userLname: json["user_lname"],
    userEmail: json["user_email"],
    userMobile: json["user_mobile"],
    userType: json["user_type"],
    parentUserType: json["parent_user_type"],
    userCity: json["user_city"],
    userParentId: json["user_parent_id"],
    isFeesPaid: json["is_fees_paid"],
    currentPkgId: json["current_pkg_id"],
    lastFeesDate: DateTime.parse(json["last_fees_date"] ?? DateTime.now().toString()),
    profilePic: json["profile_pic"].toString(),
    dob: json["dob"].toString(),
    accessToken: json["access_token"],
    userLoggedIn: json["user_logged_in"],
    profileSelected: json["profile_selected"],
    parentId: json["parent_id"],
    conId: json["con_id"].toString(),
    userCountryId: json["user_country_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "organization_name": organizationName,
    "user_fname": userFname,
    "user_lname": userLname,
    "user_email": userEmail,
    "user_mobile": userMobile,
    "user_type": userType,
    "parent_user_type": parentUserType,
    "user_city": userCity,
    "user_parent_id": userParentId,
    "is_fees_paid": isFeesPaid,
    "current_pkg_id": currentPkgId,
    "last_fees_date": "${lastFeesDate.year.toString().padLeft(4, '0')}-${lastFeesDate.month.toString().padLeft(2, '0')}-${lastFeesDate.day.toString().padLeft(2, '0')}",
    "profile_pic": profilePic,
    "dob": dob,
    "access_token": accessToken,
    "user_logged_in": userLoggedIn,
    "profile_selected": profileSelected,
    "parent_id": parentId,
    "con_id": conId,
    "user_country_id": userCountryId,
  };
}
