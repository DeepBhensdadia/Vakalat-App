// To parse this JSON data, do
//
//     final viewcartmodel = viewcartmodelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Viewcartmodel viewcartmodelFromJson(String str) =>
    Viewcartmodel.fromJson(json.decode(str));

String viewcartmodelToJson(Viewcartmodel data) => json.encode(data.toJson());

class Viewcartmodel {
  final int status;
  final String message;
  final String paymenturl;
  final List<Total> total;
  final List<Appcart> appcart;

  Viewcartmodel({
    required this.status,
    required this.message,
    required this.paymenturl,
    required this.total,
    required this.appcart,
  });

  factory Viewcartmodel.fromJson(Map<String, dynamic> json) => Viewcartmodel(
        status: json["status"] ?? 0,
        message: json["message"] ?? "",
        paymenturl: json["paymenturl"],
        total: List<Total>.from(json["total"].map((x) => Total.fromJson(x))),
        appcart:
            List<Appcart>.from(json["appcart"].map((x) => Appcart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "paymenturl": paymenturl,
        "total": List<dynamic>.from(total.map((x) => x.toJson())),
        "appcart": List<dynamic>.from(appcart.map((x) => x.toJson())),
      };
}

class Appcart {
  final String appcartid;
  final String userId;
  final String handlerName;
  final String packageId;
  final String appcartAddedDatetime;
  final String appcartUpdatedDatetime;
  final String packageCountryId;
  final String packageUsertypeId;
  final String packageName;
  final String packageDescription;
  final String packagePrice;
  final String packageDiscountPercentage;
  final String packageDiscountAmount;
  final String packageStartDate;
  final String packageEndDate;
  final String packageFreeNotices;
  final String packageFreeBkUser;
  final String level;
  final String isDisplayInPublic;
  final String isRatingOn;
  final String packageIsactive;
  final String packageCreatedBy;
  final String packageCreatedDatetime;
  final String packageUpdatedBy;
  final String packageUpdatedDatetime;
  final String packageIsdeleted;

  Appcart({
    required this.appcartid,
    required this.userId,
    required this.handlerName,
    required this.packageId,
    required this.appcartAddedDatetime,
    required this.appcartUpdatedDatetime,
    required this.packageCountryId,
    required this.packageUsertypeId,
    required this.packageName,
    required this.packageDescription,
    required this.packagePrice,
    required this.packageDiscountPercentage,
    required this.packageDiscountAmount,
    required this.packageStartDate,
    required this.packageEndDate,
    required this.packageFreeNotices,
    required this.packageFreeBkUser,
    required this.level,
    required this.isDisplayInPublic,
    required this.isRatingOn,
    required this.packageIsactive,
    required this.packageCreatedBy,
    required this.packageCreatedDatetime,
    required this.packageUpdatedBy,
    required this.packageUpdatedDatetime,
    required this.packageIsdeleted,
  });

  factory Appcart.fromJson(Map<String, dynamic> json) => Appcart(
        appcartid: json["appcartid"] ?? "",
        userId: json["user_id"] ?? "",
        handlerName: json["handler_name"] ?? "",
        packageId: json["package_id"] ?? "",
        appcartAddedDatetime: json["appcart_added_datetime"] ?? "",
        appcartUpdatedDatetime: json["appcart_updated_datetime"] ?? "",
        packageCountryId: json["package_country_id"] ?? "",
        packageUsertypeId: json["package_usertype_id"] ?? "",
        packageName: json["package_name"] ?? "",
        packageDescription: json["package_description"] ?? "",
        packagePrice: json["package_price"] ?? "",
        packageDiscountPercentage: json["package_discount_percentage"] ?? "",
        packageDiscountAmount: json["package_discount_amount"] ?? "",
        packageStartDate: json["package_start_date"] ?? "",
        packageEndDate: json["package_end_date"] ?? "",
        packageFreeNotices: json["package_free_notices"] ?? "",
        packageFreeBkUser: json["package_free_bk_user"] ?? "",
        level: json["level"] ?? "",
        isDisplayInPublic: json["is_display_in_public"] ?? "",
        isRatingOn: json["is_rating_on"] ?? "",
        packageIsactive: json["package_isactive"] ?? "",
        packageCreatedBy: json["package_created_by"] ?? "",
        packageCreatedDatetime: json["package_created_datetime"] ?? "",
        packageUpdatedBy: json["package_updated_by"] ?? "",
        packageUpdatedDatetime: json["package_updated_datetime"] ?? "",
        packageIsdeleted: json["package_isdeleted"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "appcartid": appcartid,
        "user_id": userId,
        "handler_name": handlerName,
        "package_id": packageId,
        "appcart_added_datetime": appcartAddedDatetime,
        "appcart_updated_datetime": appcartUpdatedDatetime,
        "package_country_id": packageCountryId,
        "package_usertype_id": packageUsertypeId,
        "package_name": packageName,
        "package_description": packageDescription,
        "package_price": packagePrice,
        "package_discount_percentage": packageDiscountPercentage,
        "package_discount_amount": packageDiscountAmount,
        "package_start_date": packageStartDate,
        "package_end_date": packageEndDate,
        "package_free_notices": packageFreeNotices,
        "package_free_bk_user": packageFreeBkUser,
        "level": level,
        "is_display_in_public": isDisplayInPublic,
        "is_rating_on": isRatingOn,
        "package_isactive": packageIsactive,
        "package_created_by": packageCreatedBy,
        "package_created_datetime": packageCreatedDatetime,
        "package_updated_by": packageUpdatedBy,
        "package_updated_datetime": packageUpdatedDatetime,
        "package_isdeleted": packageIsdeleted,
      };
}

class Total {
  final int discountStatus;
  final String discountMessage;
  final String subttotal;
  final String discount;
  final String dcodeid;
  final String dcode;
  final int dapplied;
  final String gst;
  final int gstapplied;
  final int cashcodestatus;
  final String cashcode;
  final String cashcodemessage;
  final String cashcodeamt;
  final String total;

  Total({
    required this.discountStatus,
    required this.discountMessage,
    required this.subttotal,
    required this.discount,
    required this.dcodeid,
    required this.dcode,
    required this.dapplied,
    required this.gst,
    required this.gstapplied,
    required this.cashcodestatus,
    required this.cashcode,
    required this.cashcodemessage,
    required this.cashcodeamt,
    required this.total,
  });

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        discountStatus: json["discount_status"] ?? 0,
        discountMessage: json["discount_message"] ?? "",
        subttotal: json["subttotal"] ?? "",
        discount: json["discount"] ?? "",
        dcodeid: json["dcodeid"] ?? "",
        dcode: json["dcode"] ?? "",
        dapplied: json["dapplied"] ?? 0,
        gst: json["gst"] ?? "",
        gstapplied: json["gstapplied"] ?? 0,
        cashcodestatus: json["cashcodestatus"] ?? 0,
        cashcode: json["cashcode"] ?? "",
        cashcodemessage: json["cashcodemessage"] ?? "",
        cashcodeamt: json["cashcodeamt"] ?? "",
        total: json["total"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "discount_status": discountStatus,
        "discount_message": discountMessage,
        "subttotal": subttotal,
        "discount": discount,
        "dcodeid": dcodeid,
        "dcode": dcode,
        "dapplied": dapplied,
        "gst": gst,
        "gstapplied": gstapplied,
        "cashcodestatus": cashcodestatus,
        "cashcode": cashcode,
        "cashcodemessage": cashcodemessage,
        "cashcodeamt": cashcodeamt,
        "total": total,
      };
}
