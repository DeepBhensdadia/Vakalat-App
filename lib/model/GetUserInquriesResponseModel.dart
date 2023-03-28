// To parse this JSON data, do
//
//     final getUserInquriesResponceModel = getUserInquriesResponceModelFromJson(jsonString);

import 'dart:convert';

GetUserInquriesResponceModel getUserInquriesResponceModelFromJson(String str) => GetUserInquriesResponceModel.fromJson(json.decode(str));

String getUserInquriesResponceModelToJson(GetUserInquriesResponceModel data) => json.encode(data.toJson());

class GetUserInquriesResponceModel {
  GetUserInquriesResponceModel({
    required this.status,
    required this.message,
    required this.inquiries,
    required this.total,
  });

  final int status;
  final String message;
  final List<Inquiry> inquiries;
  final int total;

  factory GetUserInquriesResponceModel.fromJson(Map<String, dynamic> json) => GetUserInquriesResponceModel(
    status: json["status"],
    message: json["message"],
    inquiries: List<Inquiry>.from(json["inquiries"].map((x) => Inquiry.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "inquiries": List<dynamic>.from(inquiries.map((x) => x.toJson())),
    "total": total,
  };
}

class Inquiry {
  Inquiry({
    required this.id,
    required this.queryId,
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.contactNo,
    required this.email,
    required this.subject,
    required this.message,
    required this.lawyerId,
    required this.isRead,
    required this.isDelete,
    required this.createdBy,
    required this.createdDatetime,
    required this.updatedBy,
    required this.updatedDatetime,
    required this.uFirstName,
    required this.uLastName,
    required this.uMobile,
    required this.uEmail,
  });

  final String id;
  final String queryId;
  final String clientId;
  final String firstName;
  final String lastName;
  final String contactNo;
  final String email;
  final String subject;
  final String message;
  final String lawyerId;
  final String isRead;
  final String isDelete;
  final String createdBy;
  final String createdDatetime;
  final String updatedBy;
  final String updatedDatetime;
  final String? uFirstName;
  final String? uLastName;
  final String? uMobile;
  final String? uEmail;

  factory Inquiry.fromJson(Map<String, dynamic> json) => Inquiry(
    id: json["id"],
    queryId: json["query_id"],
    clientId: json["client_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    contactNo: json["contact_no"],
    email: json["email"],
    subject: json["subject"],
    message: json["message"],
    lawyerId: json["lawyer_id"],
    isRead: json["is_read"],
    isDelete: json["is_delete"],
    createdBy: json["created_by"],
    createdDatetime: json["created_datetime"],
    updatedBy: json["updated_by"],
    updatedDatetime: json["updated_datetime"],
    uFirstName: json["u_first_name"],
    uLastName: json["u_last_name"],
    uMobile: json["u_mobile"],
    uEmail: json["u_email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "query_id": queryId,
    "client_id": clientId,
    "first_name": firstName,
    "last_name": lastName,
    "contact_no": contactNo,
    "email": email,
    "subject": subject,
    "message": message,
    "lawyer_id": lawyerId,
    "is_read": isRead,
    "is_delete": isDelete,
    "created_by": createdBy,
    "created_datetime": createdDatetime,
    "updated_by": updatedBy,
    "updated_datetime": updatedDatetime,
    "u_first_name": uFirstName,
    "u_last_name": uLastName,
    "u_mobile": uMobile,
    "u_email": uEmail,
  };
}
