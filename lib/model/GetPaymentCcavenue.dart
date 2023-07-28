// To parse this JSON data, do
//
//     final getpaymentonline = getpaymentonlineFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getpaymentonline getpaymentonlineFromJson(String str) => Getpaymentonline.fromJson(json.decode(str));

String getpaymentonlineToJson(Getpaymentonline data) => json.encode(data.toJson());

class Getpaymentonline {
  final int status;
  final String pay;
  final String paymentUrl;
  final String message;

  Getpaymentonline({
    required this.status,
    required this.pay,
    required this.paymentUrl,
    required this.message,
  });

  factory Getpaymentonline.fromJson(Map<String, dynamic> json) => Getpaymentonline(
    status: json["status"],
    pay: json["pay"],
    paymentUrl: json["payment_url"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "pay": pay,
    "payment_url": paymentUrl,
    "message": message,
  };
}
