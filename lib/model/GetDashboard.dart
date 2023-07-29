// To parse this JSON data, do
//
//     final getdashboard = getdashboardFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getdashboard getdashboardFromJson(String str) => Getdashboard.fromJson(json.decode(str));

String getdashboardToJson(Getdashboard data) => json.encode(data.toJson());

class Getdashboard {
  final int status;
  final String message;
  final dynamic csrfToken;
  final Data data;

  Getdashboard({
    required this.status,
    required this.message,
    required this.csrfToken,
    required this.data,
  });

  factory Getdashboard.fromJson(Map<String, dynamic> json) => Getdashboard(
    status: json["status"],
    message: json["message"] ?? "",
    csrfToken: json["csrf_token"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "csrf_token": csrfToken,
    "data": data.toJson(),
  };
}

class Data {
  final List<Case> cases;
  final List<Inquiry> inquiries;
  final Videos videos;
  final List<Job> jobs;
  final List<Appliedjob> appliedjobs;
  final Events events;

  Data({
    required this.cases,
    required this.inquiries,
    required this.videos,
    required this.jobs,
    required this.appliedjobs,
    required this.events,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cases: List<Case>.from(json["cases"].map((x) => Case.fromJson(x))),
    inquiries: List<Inquiry>.from(json["inquiries"].map((x) => Inquiry.fromJson(x))),
    videos: Videos.fromJson(json["videos"]),
    jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
    appliedjobs: List<Appliedjob>.from(json["appliedjobs"].map((x) => Appliedjob.fromJson(x))),
    events: Events.fromJson(json["events"]),
  );

  Map<String, dynamic> toJson() => {
    "cases": List<dynamic>.from(cases.map((x) => x.toJson())),
    "inquiries": List<dynamic>.from(inquiries.map((x) => x.toJson())),
    "videos": videos.toJson(),
    "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
    "appliedjobs": List<dynamic>.from(appliedjobs.map((x) => x.toJson())),
    "events": events.toJson(),
  };
}

class Appliedjob {
  final String applyJobId;
  final String applyId;
  final String applyJobFname;
  final String applyJobLname;
  final String applyJobEmail;
  final String applyJobMobile;
  final String applyJobResume;
  final String applyJobMessage;
  final String status;
  final String applyJobUserId;
  final String applyJobCreatedDatetime;
  final String applyJobHire;
  final String jpJobTitle;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String address;
  final String lawFirmCollege;

  Appliedjob({
    required this.applyJobId,
    required this.applyId,
    required this.applyJobFname,
    required this.applyJobLname,
    required this.applyJobEmail,
    required this.applyJobMobile,
    required this.applyJobResume,
    required this.applyJobMessage,
    required this.status,
    required this.applyJobUserId,
    required this.applyJobCreatedDatetime,
    required this.applyJobHire,
    required this.jpJobTitle,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.address,
    required this.lawFirmCollege,
  });

  factory Appliedjob.fromJson(Map<String, dynamic> json) => Appliedjob(
    applyJobId: json["apply_job_id"]??"",
    applyId: json["apply_id"]??"",
    applyJobFname: json["apply_job_fname"]??"",
    applyJobLname: json["apply_job_lname"]??"",
    applyJobEmail: json["apply_job_email"]??"",
    applyJobMobile: json["apply_job_mobile"]??"",
    applyJobResume: json["apply_job_resume"]??"",
    applyJobMessage: json["apply_job_message"]??"",
    status: json["status"]??"",
    applyJobUserId: json["apply_job_user_id"]??"",
    applyJobCreatedDatetime: json["apply_job_created_datetime"]??"",
    applyJobHire: json["apply_job_hire"]??"",
    jpJobTitle: json["jp_job_title"]??"",
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    mobile: json["mobile"]??"",
    email: json["email"]??"",
    address: json["address"]??"",
    lawFirmCollege: json["law_firm_college"]??"",
  );

  Map<String, dynamic> toJson() => {
    "apply_job_id": applyJobId,
    "apply_id": applyId,
    "apply_job_fname": applyJobFname,
    "apply_job_lname": applyJobLname,
    "apply_job_email": applyJobEmail,
    "apply_job_mobile": applyJobMobile,
    "apply_job_resume": applyJobResume,
    "apply_job_message": applyJobMessage,
    "status": status,
    "apply_job_user_id": applyJobUserId,
    "apply_job_created_datetime": applyJobCreatedDatetime,
    "apply_job_hire": applyJobHire,
    "jp_job_title": jpJobTitle,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "email": email,
    "address": address,
    "law_firm_college": lawFirmCollege,
  };
}

class Case {
  final String caseDetailsId;
  final String caseNo;
  final String caseTitle;
  final String firstName;
  final String lastName;
  final String mobile;
  final DateTime caseHearingDate;
  final String caseStatusId;

  Case({
    required this.caseDetailsId,
    required this.caseNo,
    required this.caseTitle,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.caseHearingDate,
    required this.caseStatusId,
  });

  factory Case.fromJson(Map<String, dynamic> json) => Case(
    caseDetailsId: json["case_details_id"]??"",
    caseNo: json["case_no"]??"",
    caseTitle: json["case_title"]??"",
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    mobile: json["mobile"]??"",
    caseHearingDate: DateTime.parse(json["case_hearing_date"]),
    caseStatusId: json["case_status_id"]??"",
  );

  Map<String, dynamic> toJson() => {
    "case_details_id": caseDetailsId,
    "case_no": caseNo,
    "case_title": caseTitle,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "case_hearing_date": "${caseHearingDate.year.toString().padLeft(4, '0')}-${caseHearingDate.month.toString().padLeft(2, '0')}-${caseHearingDate.day.toString().padLeft(2, '0')}",
    "case_status_id": caseStatusId,
  };
}

class Events {
  final List<EventsDatum> data;
  final int totalCount;

  Events({
    required this.data,
    required this.totalCount,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
    data: List<EventsDatum>.from(json["data"].map((x) => EventsDatum.fromJson(x))),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total_count": totalCount,
  };
}

class EventsDatum {
  final String eventId;
  final String eventTypeId;
  final String photo;
  final String eventTitle;
  final String slug;
  final String description;
  final String location;
  final DateTime fromDate;
  final DateTime toDate;
  final String fromTime;
  final String toTime;
  final String contactNumber;
  final String registrationRequired;
  final String registrationFees;
  final String type;
  final String onlineFees;
  final dynamic liveUrl;
  final String isHeightlight;
  final String createdBy;
  final String behalfOfId;
  final String userMasterId;
  final String createdDatetime;
  final String updatedBy;
  final String updatedDatetime;
  final String isDelete;
  final String firstName;
  final String lastName;
  final String lawFirmCollege;

  EventsDatum({
    required this.eventId,
    required this.eventTypeId,
    required this.photo,
    required this.eventTitle,
    required this.slug,
    required this.description,
    required this.location,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.contactNumber,
    required this.registrationRequired,
    required this.registrationFees,
    required this.type,
    required this.onlineFees,
    required this.liveUrl,
    required this.isHeightlight,
    required this.createdBy,
    required this.behalfOfId,
    required this.userMasterId,
    required this.createdDatetime,
    required this.updatedBy,
    required this.updatedDatetime,
    required this.isDelete,
    required this.firstName,
    required this.lastName,
    required this.lawFirmCollege,
  });

  factory EventsDatum.fromJson(Map<String, dynamic> json) => EventsDatum(
    eventId: json["event_id"]??"",
    eventTypeId: json["event_type_id"]??"",
    photo: json["photo"]??"",
    eventTitle: json["event_title"]??"",
    slug: json["slug"]??"",
    description: json["description"]??"",
    location: json["location"]??"",
    fromDate: DateTime.parse(json["from_date"]),
    toDate: DateTime.parse(json["to_date"]),
    fromTime: json["from_time"]??"",
    toTime: json["to_time"]??"",
    contactNumber: json["contact_number"]??"",
    registrationRequired: json["registration_required"]??"",
    registrationFees: json["registration_fees"]??"",
    type: json["type"]??"",
    onlineFees: json["online_fees"]??"",
    liveUrl: json["live_url"],
    isHeightlight: json["is_heightlight"]??"",
    createdBy: json["created_by"]??"",
    behalfOfId: json["behalf_of_id"]??"",
    userMasterId: json["user_master_id"]??"",
    createdDatetime: json["created_datetime"]??"",
    updatedBy: json["updated_by"]??"",
    updatedDatetime: json["updated_datetime"]??"",
    isDelete: json["is_delete"]??"",
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    lawFirmCollege: json["law_firm_college"]??"",
  );

  Map<String, dynamic> toJson() => {
    "event_id": eventId,
    "event_type_id": eventTypeId,
    "photo": photo,
    "event_title": eventTitle,
    "slug": slug,
    "description": description,
    "location": location,
    "from_date": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
    "from_time": fromTime,
    "to_time": toTime,
    "contact_number": contactNumber,
    "registration_required": registrationRequired,
    "registration_fees": registrationFees,
    "type": type,
    "online_fees": onlineFees,
    "live_url": liveUrl,
    "is_heightlight": isHeightlight,
    "created_by": createdBy,
    "behalf_of_id": behalfOfId,
    "user_master_id": userMasterId,
    "created_datetime": createdDatetime,
    "updated_by": updatedBy,
    "updated_datetime": updatedDatetime,
    "is_delete": isDelete,
    "first_name": firstName,
    "last_name": lastName,
    "law_firm_college": lawFirmCollege,
  };
}

class Inquiry {
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
  final String uFirstName;
  final String uLastName;
  final String uMobile;
  final String uEmail;

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

  factory Inquiry.fromJson(Map<String, dynamic> json) => Inquiry(
    id: json["id"]??"",
    queryId: json["query_id"]??"",
    clientId: json["client_id"]??"",
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    contactNo: json["contact_no"]??"",
    email: json["email"]??"",
    subject: json["subject"]??"",
    message: json["message"]??"",
    lawyerId: json["lawyer_id"]??"",
    isRead: json["is_read"]??"",
    isDelete: json["is_delete"]??"",
    createdBy: json["created_by"]??"",
    createdDatetime: json["created_datetime"]??"",
    updatedBy: json["updated_by"]??"",
    updatedDatetime: json["updated_datetime"]??"",
    uFirstName: json["u_first_name"]??"",
    uLastName: json["u_last_name"]??"",
    uMobile: json["u_mobile"]??"",
    uEmail: json["u_email"]??"",
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

class Job {
  final String jpId;
  final String jpSlug;
  final String jpJobTitle;
  final String jpDescription;
  final String jpGender;
  final String jpFresherApply;
  final String jpExperience;
  final String jpFromSalary;
  final String jpToSalary;
  final String jpWorkTime;
  final String jpCountryId;
  final String jpStateId;
  final String jpCityId;
  final String jpFacilites;
  final DateTime jpStartDate;
  final DateTime jpEndDate;
  final String jpNoOfVacancy;
  final dynamic jpEmploymentType;
  final String jpIsLpo;
  final String jpIsPw;
  final String jpIsdelete;
  final String jpCreatedBy;
  final String behalfOfId;
  final String userMasterId;
  final String jpCreatedDatetime;
  final dynamic jpUpdatedBy;
  final String jpUpdatedDatetime;
  final String cityName;
  final String stateName;
  final String countryName;
  final String lawFirmCollege;
  final String totalApplied;
  final String mobile;

  Job({
    required this.jpId,
    required this.jpSlug,
    required this.jpJobTitle,
    required this.jpDescription,
    required this.jpGender,
    required this.jpFresherApply,
    required this.jpExperience,
    required this.jpFromSalary,
    required this.jpToSalary,
    required this.jpWorkTime,
    required this.jpCountryId,
    required this.jpStateId,
    required this.jpCityId,
    required this.jpFacilites,
    required this.jpStartDate,
    required this.jpEndDate,
    required this.jpNoOfVacancy,
    required this.jpEmploymentType,
    required this.jpIsLpo,
    required this.jpIsPw,
    required this.jpIsdelete,
    required this.jpCreatedBy,
    required this.behalfOfId,
    required this.userMasterId,
    required this.jpCreatedDatetime,
    required this.jpUpdatedBy,
    required this.jpUpdatedDatetime,
    required this.cityName,
    required this.stateName,
    required this.countryName,
    required this.lawFirmCollege,
    required this.totalApplied,
    required this.mobile,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    jpId: json["jp_id"]??"",
    jpSlug: json["jp_slug"]??"",
    jpJobTitle: json["jp_job_title"]??"",
    jpDescription: json["jp_description"]??"",
    jpGender: json["jp_gender"]??"",
    jpFresherApply: json["jp_fresher_apply"]??"",
    jpExperience: json["jp_experience"]??"",
    jpFromSalary: json["jp_from_salary"]??"",
    jpToSalary: json["jp_to_salary"]??"",
    jpWorkTime: json["jp_work_time"]??"",
    jpCountryId: json["jp_country_id"]??"",
    jpStateId: json["jp_state_id"]??"",
    jpCityId: json["jp_city_id"]??"",
    jpFacilites: json["jp_facilites"]??"",
    jpStartDate: DateTime.parse(json["jp_start_date"]),
    jpEndDate: DateTime.parse(json["jp_end_date"]),
    jpNoOfVacancy: json["jp_no_of_vacancy"]??"",
    jpEmploymentType: json["jp_employment_type"],
    jpIsLpo: json["jp_is_lpo"]??"",
    jpIsPw: json["jp_is_pw"]??"",
    jpIsdelete: json["jp_isdelete"]??"",
    jpCreatedBy: json["jp_created_by"]??"",
    behalfOfId: json["behalf_of_id"]??"",
    userMasterId: json["user_master_id"]??"",
    jpCreatedDatetime: json["jp_created_datetime"]??"",
    jpUpdatedBy: json["jp_updated_by"],
    jpUpdatedDatetime: json["jp_updated_datetime"]??"",
    cityName: json["city_name"]??"",
    stateName: json["state_name"]??"",
    countryName: json["country_name"]??"",
    lawFirmCollege: json["law_firm_college"]??"",
    totalApplied: json["total_applied"]??"",
    mobile: json["mobile"]??"",
  );

  Map<String, dynamic> toJson() => {
    "jp_id": jpId,
    "jp_slug": jpSlug,
    "jp_job_title": jpJobTitle,
    "jp_description": jpDescription,
    "jp_gender": jpGender,
    "jp_fresher_apply": jpFresherApply,
    "jp_experience": jpExperience,
    "jp_from_salary": jpFromSalary,
    "jp_to_salary": jpToSalary,
    "jp_work_time": jpWorkTime,
    "jp_country_id": jpCountryId,
    "jp_state_id": jpStateId,
    "jp_city_id": jpCityId,
    "jp_facilites": jpFacilites,
    "jp_start_date": "${jpStartDate.year.toString().padLeft(4, '0')}-${jpStartDate.month.toString().padLeft(2, '0')}-${jpStartDate.day.toString().padLeft(2, '0')}",
    "jp_end_date": "${jpEndDate.year.toString().padLeft(4, '0')}-${jpEndDate.month.toString().padLeft(2, '0')}-${jpEndDate.day.toString().padLeft(2, '0')}",
    "jp_no_of_vacancy": jpNoOfVacancy,
    "jp_employment_type": jpEmploymentType,
    "jp_is_lpo": jpIsLpo,
    "jp_is_pw": jpIsPw,
    "jp_isdelete": jpIsdelete,
    "jp_created_by": jpCreatedBy,
    "behalf_of_id": behalfOfId,
    "user_master_id": userMasterId,
    "jp_created_datetime": jpCreatedDatetime,
    "jp_updated_by": jpUpdatedBy,
    "jp_updated_datetime": jpUpdatedDatetime,
    "city_name": cityName,
    "state_name": stateName,
    "country_name": countryName,
    "law_firm_college": lawFirmCollege,
    "total_applied": totalApplied,
    "mobile": mobile,
  };
}

class Videos {
  final List<VideosDatum> data;
  final int totalCount;

  Videos({
    required this.data,
    required this.totalCount,
  });

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
    data: List<VideosDatum>.from(json["data"].map((x) => VideosDatum.fromJson(x))),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total_count": totalCount,
  };
}

class VideosDatum {
  final String id;
  final String topicId;
  final String userId;
  final String plainUrl;
  final String url;
  final String title;
  final String desc;
  final String status;
  final dynamic reason;
  final String isDelete;
  final String isActive;
  final String createdBy;
  final String behalfOfId;
  final DateTime createdAt;
  final String updatedBy;
  final String updatedAt;
  final String firstName;
  final String lastName;
  final String topic;
  final String topicDesc;
  final String language;
  final String category;
  final String subCategory;
  final String slug;

  VideosDatum({
    required this.id,
    required this.topicId,
    required this.userId,
    required this.plainUrl,
    required this.url,
    required this.title,
    required this.desc,
    required this.status,
    required this.reason,
    required this.isDelete,
    required this.isActive,
    required this.createdBy,
    required this.behalfOfId,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.topic,
    required this.topicDesc,
    required this.language,
    required this.category,
    required this.subCategory,
    required this.slug,
  });

  factory VideosDatum.fromJson(Map<String, dynamic> json) => VideosDatum(
    id: json["id"]??"",
    topicId: json["topic_id"]??"",
    userId: json["user_id"]??"",
    plainUrl: json["plain_url"]??"",
    url: json["url"]??"",
    title: json["title"]??"",
    desc: json["desc"]??"",
    status: json["status"]??"",
    reason: json["reason"],
    isDelete: json["is_delete"]??"",
    isActive: json["is_active"]??"",
    createdBy: json["created_by"]??"",
    behalfOfId: json["behalf_of_id"]??"",
    createdAt: DateTime.parse(json["created_at"]),
    updatedBy: json["updated_by"]??"",
    updatedAt: json["updated_at"]??"",
    firstName: json["first_name"]??"",
    lastName: json["last_name"]??"",
    topic: json["topic"]??"",
    topicDesc: json["topic_desc"]??"",
    language: json["language"]??"",
    category: json["category"]??"",
    subCategory: json["sub_category"]??"",
    slug: json["slug"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "topic_id": topicId,
    "user_id": userId,
    "plain_url": plainUrl,
    "url": url,
    "title": title,
    "desc": desc,
    "status": status,
    "reason": reason,
    "is_delete": isDelete,
    "is_active": isActive,
    "created_by": createdBy,
    "behalf_of_id": behalfOfId,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_by": updatedBy,
    "updated_at": updatedAt,
    "first_name": firstName,
    "last_name": lastName,
    "topic": topic,
    "topic_desc": topicDesc,
    "language": language,
    "category": category,
    "sub_category": subCategory,
    "slug": slug,
  };
}
