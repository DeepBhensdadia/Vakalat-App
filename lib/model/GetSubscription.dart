// To parse this JSON data, do
//
//     final getSubscripation = getSubscripationFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetSubscripation getSubscripationFromJson(String str) => GetSubscripation.fromJson(json.decode(str));

String getSubscripationToJson(GetSubscripation data) => json.encode(data.toJson());

class GetSubscripation {
  final int status;
  final String message;
  final dynamic csrfToken;
  final List<Subscription> subscriptions;
  final int total;

  GetSubscripation({
    required this.status,
    required this.message,
    required this.csrfToken,
    required this.subscriptions,
    required this.total,
  });

  factory GetSubscripation.fromJson(Map<String, dynamic> json) => GetSubscripation(
    status: json["status"],
    message: json["message"],
    csrfToken: json["csrf_token"] ?? '',
    subscriptions: List<Subscription>.from(json["subscriptions"].map((x) => Subscription.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "csrf_token": csrfToken,
    "subscriptions": List<dynamic>.from(subscriptions.map((x) => x.toJson())),
    "total": total,
  };
}

class Subscription {
  final String rpId;
  final String rpReceiptNo;
  final String rpPaymentId;
  final String rpUserId;
  final String rpUserType;
  final String rpPackageId;
  final String rpAmount;
  final String rpDiscountAmount;
  final String rpTotalAmount;
  final String rpPaymentType;
  final String rpPaidStatus;
  final String rpGstNo;
  final String type;
  final DateTime expireDate;
  final String isUpgrade;
  final String status;
  final String eliteChequeNo;
  final String eliteTransNo;
  final DateTime rpCreatedDatetime;
  final String packageName;
  final String packagePrice;

  Subscription({
    required this.rpId,
    required this.rpReceiptNo,
    required this.rpPaymentId,
    required this.rpUserId,
    required this.rpUserType,
    required this.rpPackageId,
    required this.rpAmount,
    required this.rpDiscountAmount,
    required this.rpTotalAmount,
    required this.rpPaymentType,
    required this.rpPaidStatus,
    required this.rpGstNo,
    required this.type,
    required this.expireDate,
    required this.isUpgrade,
    required this.status,
    required this.eliteChequeNo,
    required this.eliteTransNo,
    required this.rpCreatedDatetime,
    required this.packageName,
    required this.packagePrice,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    rpId: json["rp_id"].toString(),
    rpReceiptNo: json["rp_receipt_no"].toString(),
    rpPaymentId: json["rp_payment_id"].toString(),
    rpUserId: json["rp_user_id"].toString(),
    rpUserType: json["rp_user_type"].toString(),
    rpPackageId: json["rp_package_id"].toString(),
    rpAmount: json["rp_amount"].toString(),
    rpDiscountAmount: json["rp_discount_amount"].toString(),
    rpTotalAmount: json["rp_total_amount"].toString(),
    rpPaymentType: json["rp_payment_type"].toString(),
    rpPaidStatus: json["rp_paid_status"].toString(),
    rpGstNo: json["rp_gst_no"].toString(),
    type: json["type"].toString(),
    expireDate: DateTime.parse(json["expire_date"]),
    isUpgrade: json["is_upgrade"].toString(),
    status: json["status"].toString(),
    eliteChequeNo: json["elite_cheque_no"].toString() ,
    eliteTransNo: json["elite_trans_no"].toString() ,
    rpCreatedDatetime: DateTime.parse(json["rp_created_datetime"]),
    packageName: json["package_name"].toString(),
    packagePrice: json["package_price"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "rp_id": rpId,
    "rp_receipt_no": rpReceiptNo,
    "rp_payment_id": rpPaymentId,
    "rp_user_id": rpUserId,
    "rp_user_type": rpUserType,
    "rp_package_id": rpPackageId,
    "rp_amount": rpAmount,
    "rp_discount_amount": rpDiscountAmount,
    "rp_total_amount": rpTotalAmount,
    "rp_payment_type": rpPaymentType,
    "rp_paid_status": rpPaidStatus,
    "rp_gst_no": rpGstNo,
    "type": type,
    "expire_date": "${expireDate.year.toString().padLeft(4, '0')}-${expireDate.month.toString().padLeft(2, '0')}-${expireDate.day.toString().padLeft(2, '0')}",
    "is_upgrade": isUpgrade,
    "status": status,
    "elite_cheque_no": eliteChequeNo,
    "elite_trans_no": eliteTransNo,
    "rp_created_datetime": "${rpCreatedDatetime.year.toString().padLeft(4, '0')}-${rpCreatedDatetime.month.toString().padLeft(2, '0')}-${rpCreatedDatetime.day.toString().padLeft(2, '0')}",
    "package_name": packageName,
    "package_price": packagePrice,
  };
}
