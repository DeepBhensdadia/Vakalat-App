// To parse this JSON data, do
//
//     final getdrawermenu = getdrawermenuFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getdrawermenu getdrawermenuFromJson(String str) =>
    Getdrawermenu.fromJson(json.decode(str));

String getdrawermenuToJson(Getdrawermenu data) => json.encode(data.toJson());

class Getdrawermenu {
  final int status;
  final String message;
  final dynamic csrfToken;
  final Menu? menu;

  Getdrawermenu({
    required this.status,
    required this.message,
    required this.csrfToken,
    this.menu,
  });

  factory Getdrawermenu.fromJson(Map<String, dynamic> json) => Getdrawermenu(
        status: json["status"],
        message: json["message"],
        csrfToken: json["csrf_token"],
        menu:
        json["menu"] != null ? Menu.fromJson(json["menu"]) : null,
    // json["menu"] is List<dynamic> ? null : Menu.fromJson(json["menu"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "csrf_token": csrfToken,
        "menu": menu != null ? menu!.toJson() : {},
      };
}

class Menu {
  final bool digitalProfile;
  final bool profile;
  final bool subscription;
  final bool achievement;
  final bool participation;
  final bool jobsApplyPost;
  final bool dms;
  final bool documentType;
  final bool uploadDoc;
  final bool clientManagement;
  final bool caseManagement;
  final bool services;
  final bool clientLedger;
  final bool userInquiry;
  final bool eventsParticipation;
  final bool lawAwarenessVideos;
  final bool clientInvoices;
  final bool invoice;
  final bool receipt;
  final bool report;
  final bool ratingReview;
  final bool lawStudents;
  final bool publicLegalNotices;

  Menu({
    required this.digitalProfile,
    required this.profile,
    required this.subscription,
    required this.achievement,
    required this.participation,
    required this.jobsApplyPost,
    required this.dms,
    required this.documentType,
    required this.uploadDoc,
    required this.clientManagement,
    required this.caseManagement,
    required this.services,
    required this.clientLedger,
    required this.userInquiry,
    required this.eventsParticipation,
    required this.lawAwarenessVideos,
    required this.clientInvoices,
    required this.invoice,
    required this.receipt,
    required this.report,
    required this.ratingReview,
    required this.lawStudents,
    required this.publicLegalNotices,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      digitalProfile: json["Digital Profile"] ?? false,
      profile: json["Profile"] ?? false,
      subscription: json["Subscription"] ?? false,
      achievement: json["Achievement"] ?? false,
      participation: json["Participation"] ?? false,
      jobsApplyPost: json["Jobs (Apply / Post)"] ?? false,
      dms: json["DMS"] ?? false,
      documentType: json["Document Type"] ?? false,
      uploadDoc: json["Upload Doc"] ?? false,
      clientManagement: json["Client Management"] ?? false,
      caseManagement: json["Case Management"] ?? false,
      services: json["Services"] ?? false,
      clientLedger: json["Client Ledger"] ?? false,
      userInquiry: json["User Inquiry"] ?? false,
      eventsParticipation: json["Events Participation"] ?? false,
      lawAwarenessVideos: json["Law Awareness Videos"] ?? false,
      clientInvoices: json["Client Invoices"] ?? false,
      invoice: json["Invoice"] ?? false,
      receipt: json["Receipt"] ?? false,
      report: json["Report"] ?? false,
      ratingReview: json["Rating/Review"] ?? false,
      lawStudents: json["Law Students"] ?? false,
      publicLegalNotices: json["Public Legal Notices"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "Digital Profile": digitalProfile,
        "Profile": profile,
        "Subscription": subscription,
        "Achievement": achievement,
        "Participation": participation,
        "Jobs (Apply / Post)": jobsApplyPost,
        "DMS": dms,
        "Document Type": documentType,
        "Upload Doc": uploadDoc,
        "Client Management": clientManagement,
        "Case Management": caseManagement,
        "Services": services,
        "Client Ledger": clientLedger,
        "User Inquiry": userInquiry,
        "Events Participation": eventsParticipation,
        "Law Awareness Videos": lawAwarenessVideos,
        "Client Invoices": clientInvoices,
        "Invoice": invoice,
        "Receipt": receipt,
        "Report": report,
        "Rating/Review": ratingReview,
        "Law Students": lawStudents,
        "Public Legal Notices": publicLegalNotices,
      };
}
