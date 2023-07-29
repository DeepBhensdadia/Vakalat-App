// To parse this JSON data, do
//
//     final getProfileModel = getProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetProfileModel getProfileModelFromJson(String str) =>
    GetProfileModel.fromJson(json.decode(str));

String getProfileModelToJson(GetProfileModel data) =>
    json.encode(data.toJson());

class GetProfileModel {
  GetProfileModel({
    required this.status,
    required this.message,
    required this.profile,
  });

  final int status;
  final String message;
  final Profile profile;

  factory GetProfileModel.fromJson(Map<String, dynamic> json) =>
      GetProfileModel(
        status: json["status"],
        message: json["message"],
        profile: Profile.fromJson(json["profile"] ?? {}),
      );

  MapEntry<String, dynamic> getLanDetailsFromLanguage(Language lan) {
    return profile.lanDetail.entries
        .firstWhere((element) => element.key == lan.langId);
  }

  List<KnownLan> getKnownLanguage() {
    List<KnownLan> data = <KnownLan>[];

    for (Language element in profile.languages) {
      MapEntry<String, dynamic> someData = getLanDetailsFromLanguage(element);

      data.add(
        KnownLan.fromMap(
          language: element.langId,
          id: element.id,
          data: someData.value,
        ),
      );
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    required this.userId,
    required this.userTypeId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.shortName,
    required this.email,
    required this.currentPkgId,
    required this.mobile,
    required this.isDisplayWeb,
    required this.profilePic,
    required this.profilePicName,
    required this.dateOfBirth,
    required this.gender,
    required this.username,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.pincode,
    required this.sanadRegNo,
    required this.sanadRegYear,
    required this.sanadRegDate,
    required this.welfareNo,
    required this.welfareDate,
    required this.isPhysicalChal,
    required this.physicalDetail,
    required this.biodata,
    required this.biodataName,
    required this.address,
    required this.officeAddress,
    required this.companyMobile,
    required this.aboutUser,
    required this.websiteUrl,
    required this.bloodGroup,
    required this.bloodGroupId,
    required this.distCourtRegiNo,
    required this.distCourtRegiDate,
    required this.qualification,
    required this.assoMemberNo,
    required this.assoMemberType,
    required this.assoMemberDate,
    required this.experience,
    required this.notaryNo,
    required this.deathDate,
    required this.isAdvisory,
    required this.categoryId,
    required this.categoriesTxt,
    required this.lawFirmCollege,
    required this.councilId,
    required this.associationId,
    required this.fbUrl,
    required this.instaUrl,
    required this.twitterUrl,
    required this.linkedinUrl,
    required this.slug,
    required this.videoProfile,
    required this.lawFirmName,
    required this.officeCountryId,
    required this.officeStateId,
    required this.officeCityId,
    required this.officePincode,
    required this.logo,
    required this.since,
    required this.handlerEditable,
    required this.doc,
    required this.docType,
    required this.userVerificationDocId,
    required this.isVerified,
    required this.percentage,
    required this.languages,
    required this.lanDetail,
    required this.domain,
  });

  final String userId;
  final String userTypeId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String shortName;
  final String email;
  final String currentPkgId;
  final String mobile;
  final String isDisplayWeb;
  final String profilePic;
  final String profilePicName;
  final String dateOfBirth;
  final String gender;
  final String username;
  final String countryId;
  final String stateId;
  final String cityId;
  final String pincode;
  final String sanadRegNo;
  final String sanadRegYear;
  final String sanadRegDate;
  final String welfareNo;
  final String welfareDate;
  final String isPhysicalChal;
  final String physicalDetail;
  final String biodata;
  final String biodataName;
  final String address;
  final String officeAddress;
  final String companyMobile;
  final String aboutUser;
  final String websiteUrl;
  final String bloodGroup;
  final String bloodGroupId;
  final String distCourtRegiNo;
  final String distCourtRegiDate;
  final String qualification;
  final String assoMemberNo;
  final String assoMemberType;
  final String assoMemberDate;
  final String experience;
  final String notaryNo;
  final String deathDate;
  final String isAdvisory;
  final List<String> categoryId;
  final String categoriesTxt;
  final String lawFirmCollege;
  final String councilId;
  final String associationId;
  final String fbUrl;
  final String instaUrl;
  final String twitterUrl;
  final String linkedinUrl;
  final String slug;
  final String videoProfile;
  final String lawFirmName;
  final String officeCountryId;
  final String officeStateId;
  final String officeCityId;
  final String officePincode;
  final String logo;
  final String since;
  final int handlerEditable;
  final List<String> doc;
  final List<String> docType;
  final List<String> userVerificationDocId;
  final String isVerified;
  final int percentage;
  final List<Language> languages;
  final Map<String, dynamic> lanDetail;
  final String domain;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        userId: json["user_id"]??"",
        userTypeId: json["user_type_id"]??"",
        firstName: json["first_name"]??"",
        middleName: json["middle_name"]??"",
        lastName: json["last_name"]??"",
        fullName: json["full_name"]??"",
        shortName: json["short_name"]??"",
        email: json["email"]??"",
        currentPkgId: json["current_pkg_id"]??"",
        mobile: json["mobile"]??"",
        isDisplayWeb: json["is_display_web"]??"",
        profilePic: json["profile_pic"]??"",
        profilePicName: json["profile_pic_name"]??"",
        dateOfBirth: json["date_of_birth"]??"",
        gender: json["gender"]??"",
        username: json["username"]??"",
        countryId: json["country_id"]??"101",
        stateId: json["state_id"]??"",
        cityId: json["city_id"]??"",
        pincode: json["pincode"]??"",
        sanadRegNo: json["sanad_reg_no"]??"",
        sanadRegYear: json["sanad_reg_year"]??"",
        sanadRegDate: json["sanad_reg_date"]??"",
        welfareNo: json["welfare_no"]??"",
        welfareDate: json["welfare_date"]??"",
        isPhysicalChal: json["is_physical_chal"]??"",
        physicalDetail: json["physical_detail"]??"",
        biodata: json["biodata"]??"",
        biodataName: json["biodata_name"]??"",
        address: json["address"]??"",
        officeAddress: json["office_address"]??"",
        companyMobile: json["company_mobile"]??"",
        aboutUser: json["about_user"]??"",
        websiteUrl: json["website_url"]??"",
        bloodGroup: json["blood_group"] ?? ""??"",
        bloodGroupId: json["blood_group_id"]??"",
        distCourtRegiNo: json["dist_court_regi_no"]??"",
        distCourtRegiDate: json["dist_court_regi_date"]??"",
        qualification: json["qualification"]??"",
        assoMemberNo: json["asso_member_no"]??"",
        assoMemberType: json["asso_member_type"]??"",
        assoMemberDate: json["asso_member_date"]??"",
        experience: json["experience"]??"",
        notaryNo: json["notary_no"]??"",
        deathDate: json["death_date"]??"",
        isAdvisory: json["is_advisory"]??"",
        categoryId: List<String>.from(json["category_id"].map((x) => x)),
        categoriesTxt: json["categories_txt"] ?? "",
        lawFirmCollege: json["law_firm_college"],
        councilId: json["council_id"] ?? "",
        associationId: json["association_id"] ?? "",
        fbUrl: json["fb_url"]??"",
        instaUrl: json["insta_url"]??"",
        twitterUrl: json["twitter_url"]??"",
        linkedinUrl: json["linkedin_url"]??"",
        slug: json["slug"]??"",
        videoProfile: json["video_profile"]??"",
        lawFirmName: json["law_firm_name"]??"",
        officeCountryId: json["office_country_id"]??"101",
        officeStateId: json["office_state_id"]??"",
        officeCityId: json["office_city_id"]??"",
        officePincode: json["office_pincode"]??"",
        logo: json["logo"]??"",
        since: json["since"]??"",
        handlerEditable: json["handler_editable"],
        doc: List<String>.from(json["doc"].map((x) => x)),
        docType: List<String>.from(json["doc_type"].map((x) => x)),
        userVerificationDocId:
            List<String>.from(json["user_verification_doc_id"].map((x) => x)),
        isVerified: json["is_verified"]??"",
        percentage: json["percentage"],
        languages: List<Language>.from(
            json["languages"].map((x) => Language.fromJson(x))),
        lanDetail: json["lan_detail"] ?? {},
    domain: json["domain"]??"",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_type_id": userTypeId,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "full_name": fullName,
        "short_name": shortName,
        "email": email,
        "current_pkg_id": currentPkgId,
        "mobile": mobile,
        "is_display_web": isDisplayWeb,
        "profile_pic": profilePic,
        "profile_pic_name": profilePicName,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "username": username,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "pincode": pincode,
        "sanad_reg_no": sanadRegNo,
        "sanad_reg_year": sanadRegYear,
        "sanad_reg_date": sanadRegDate,
        "welfare_no": welfareNo,
        "welfare_date": welfareDate,
        "is_physical_chal": isPhysicalChal,
        "physical_detail": physicalDetail,
        "biodata": biodata,
        "biodata_name": biodataName,
        "address": address,
        "office_address": officeAddress,
        "company_mobile": companyMobile,
        "about_user": aboutUser,
        "website_url": websiteUrl,
        "blood_group": bloodGroup,
        "blood_group_id": bloodGroupId,
        "dist_court_regi_no": distCourtRegiNo,
        "dist_court_regi_date": distCourtRegiDate,
        "qualification": qualification,
        "asso_member_no": assoMemberNo,
        "asso_member_type": assoMemberType,
        "asso_member_date": assoMemberDate,
        "experience": experience,
        "notary_no": notaryNo,
        "death_date": deathDate,
        "is_advisory": isAdvisory,
        "category_id": List<dynamic>.from(categoryId.map((x) => x)),
        "categories_txt": categoriesTxt,
        "law_firm_college": lawFirmCollege,
        "council_id": councilId,
        "association_id": associationId,
        "fb_url": fbUrl,
        "insta_url": instaUrl,
        "twitter_url": twitterUrl,
        "linkedin_url": linkedinUrl,
        "slug": slug,
        "video_profile": videoProfile,
        "law_firm_name": lawFirmName,
        "office_country_id": officeCountryId,
        "office_state_id": officeStateId,
        "office_city_id": officeCityId,
        "office_pincode": officePincode,
        "logo": logo,
        "since": since,
        "handler_editable": handlerEditable,
        "doc": List<dynamic>.from(doc.map((x) => x)),
        "doc_type": List<dynamic>.from(docType.map((x) => x)),
        "user_verification_doc_id":
            List<dynamic>.from(userVerificationDocId.map((x) => x)),
        "is_verified": isVerified,
        "percentage": percentage,
        "languages": List<dynamic>.from(languages.map((x) => x.toJson())),
    "domain": domain,
      };
}

class LanDetail {
  LanDetail({
    required this.the19,
    required this.the81,
    required this.the187,
    required this.the202,
  });

  final The187 the19;
  final The187 the81;
  final The187 the187;
  final The187 the202;

  factory LanDetail.fromJson(Map<String, dynamic> json) => LanDetail(
        the19: The187.fromJson(json["19"]),
        the81: The187.fromJson(json["81"]),
        the187: The187.fromJson(json["187"]),
        the202: The187.fromJson(json["202"]),
      );

  Map<String, dynamic> toJson() => {
        "19": the19.toJson(),
        "81": the81.toJson(),
        "187": the187.toJson(),
        "202": the202.toJson(),
      };
}

class The187 {
  The187({
    required this.id,
    required this.isRead,
    required this.isWrite,
    required this.isSpeak,
    required this.isDeal,
  });

  final String id;
  final String isRead;
  final String isWrite;
  final String isSpeak;
  final String isDeal;

  factory The187.fromJson(Map<String, dynamic> json) => The187(
        id: json["id"],
        isRead: json["is_read"],
        isWrite: json["is_write"],
        isSpeak: json["is_speak"],
        isDeal: json["is_deal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_read": isRead,
        "is_write": isWrite,
        "is_speak": isSpeak,
        "is_deal": isDeal,
      };
}

class Language {
  Language({
    required this.id,
    required this.langId,
    required this.title,
  });

  final String id;
  final String langId;
  final String title;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        langId: json["lang_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lang_id": langId,
        "title": title,
      };
}

class KnownLan {
  KnownLan({
    this.language = "12",
    this.canDeal = false,
    this.read = false,
    this.speak = false,
    this.write = false,
    this.id,
  });

  String language;
  bool read;
  bool write;
  bool speak;
  bool canDeal;
  String? id;

  factory KnownLan.fromMap(
      {required Map<String, dynamic> data,
      required String language,
      required String id}) {
    return KnownLan(
      language: language,
      write: data["is_write"].toString() == "1" ? true : false,
      speak: data["is_speak"].toString() == "1" ? true : false,
      read: data["is_read"].toString() == "1" ? true : false,
      canDeal: data["is_deal"].toString() == "1" ? true : false,
      id: id,
    );
  }

  KnownLan copyWith({
    String? language,
    bool? read,
    bool? write,
    bool? speak,
    bool? canDeal,
  }) {
    return KnownLan(
      canDeal: canDeal ?? this.canDeal,
      language: language ?? this.language,
      read: read ?? this.read,
      speak: speak ?? this.speak,
      write: write ?? this.write,
    );
  }

  Map<String, dynamic> toJson() => {
        "language": language,
        "read": read,
        "write": write,
        "speak": speak,
        "canDeal": canDeal,
        "id": id,
      };
}
