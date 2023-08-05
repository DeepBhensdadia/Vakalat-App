// To parse this JSON data, do
//
//     final clsRegisterResponseModel = clsRegisterResponseModelFromJson(jsonString);

import 'dart:convert';

ClsRegisterResponseModel clsRegisterResponseModelFromJson(String str) => ClsRegisterResponseModel.fromJson(json.decode(str));

String clsRegisterResponseModelToJson(ClsRegisterResponseModel data) => json.encode(data.toJson());

class ClsRegisterResponseModel {
  int? status;
  String? message;
  String? accessToken;
  Userdata? userdata;

  ClsRegisterResponseModel({
     this.status,
     this.message,
     this.accessToken,
     this.userdata,
  });

  factory ClsRegisterResponseModel.fromJson(Map<String, dynamic> json) => ClsRegisterResponseModel(
    status: json["status"],
    message: json["message"],
    accessToken: json["access_token"] ?? "",
    userdata:json["user_data"] != null ?  Userdata.fromJson(json["user_data"]) : Userdata(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "access_token": accessToken,
    "userdata": userdata?.toJson(),
  };
}

class Userdata {
  String? userId;
  dynamic organizationName;
  String? userFname;
  String? userLname;
  String? userEmail;
  String? userMobile;
  String? userType;
  int? parentUserType;
  String? userCity;
  String? userParentId;
  String? isFeesPaid;
  String? currentPkgId;
  dynamic lastFeesDate;
  String? profilePic;
  String? dob;
  String? accessToken;
  bool? userLoggedIn;
  int? profileSelected;
  String? parentId;
  int? conId;
  String? userCountryId;

  Userdata({
     this.userId,
    this.organizationName,
    this.userFname,
    this.userLname,
    this.userEmail,
    this.userMobile,
    this.userType,
    this.parentUserType,
    this.userCity,
    this.userParentId,
    this.isFeesPaid,
    this.currentPkgId,
    this.lastFeesDate,
    this.profilePic,
    this.dob,
    this.accessToken,
    this.userLoggedIn,
    this.profileSelected,
    this.parentId,
    this.conId,
    this.userCountryId,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
    userId: json["user_id"],
    organizationName: json["organization_name"],
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
    lastFeesDate: json["last_fees_date"],
    profilePic: json["profile_pic"],
    dob: json["dob"],
    accessToken: json["access_token"],
    userLoggedIn: json["user_logged_in"],
    profileSelected: json["profile_selected"],
    parentId: json["parent_id"],
    conId: json["con_id"],
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
    "last_fees_date": lastFeesDate,
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
