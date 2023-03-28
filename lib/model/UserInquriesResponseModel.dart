import 'dart:convert';

UserInquriesDetailsResponceModel userInquriesDetailsResponceModelFromJson(String str) => UserInquriesDetailsResponceModel.fromJson(json.decode(str));

String userInquriesDetailsResponceModelToJson(UserInquriesDetailsResponceModel data) => json.encode(data.toJson());

class UserInquriesDetailsResponceModel {
  UserInquriesDetailsResponceModel({
    required this.status,
    required this.message,
    required this.userInquiry,
  });

  final int status;
  final String message;
  final UserInquiry userInquiry;

  factory UserInquriesDetailsResponceModel.fromJson(Map<String, dynamic> json) => UserInquriesDetailsResponceModel(
    status: json["status"],
    message: json["message"],
    userInquiry: UserInquiry.fromJson(json["user_inquiry"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user_inquiry": userInquiry.toJson(),
  };
}

class UserInquiry {
  UserInquiry({
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

  factory UserInquiry.fromJson(Map<String, dynamic> json) => UserInquiry(
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
  };
}
