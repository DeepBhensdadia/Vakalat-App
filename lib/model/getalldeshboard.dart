// To parse this JSON data, do
//
//     final getAllDeshboard = getAllDeshboardFromJson(jsonString);

import 'dart:convert';

GetAllDeshboard getAllDeshboardFromJson(String str) => GetAllDeshboard.fromJson(json.decode(str));

String getAllDeshboardToJson(GetAllDeshboard data) => json.encode(data.toJson());

class GetAllDeshboard {
  int status;
  String message;
  Data data;

  GetAllDeshboard({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetAllDeshboard.fromJson(Map<String, dynamic> json) => GetAllDeshboard(
    status: json["status"],
    message: json["message"].toString(),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Getprofile getprofile;
  GetAppMenu getAppMenu;
  Handlers handlers;
  GetUserWisePkg getUserWisePkg;

  Data({
    required this.getprofile,
    required this.getAppMenu,
    required this.handlers,
    required this.getUserWisePkg,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    getprofile: Getprofile.fromJson(json["getprofile"]),
    getAppMenu: GetAppMenu.fromJson(json["get_app_menu"]),
    handlers: Handlers.fromJson(json["handlers"]),
    getUserWisePkg: GetUserWisePkg.fromJson(json["get_user_wise_pkg"]),
  );

  Map<String, dynamic> toJson() => {
    "getprofile": getprofile.toJson(),
    "get_app_menu": getAppMenu.toJson(),
    "handlers": handlers.toJson(),
    "get_user_wise_pkg": getUserWisePkg.toJson(),
  };
}


class GetAppMenu {
  final int status;
  final String message;
  final dynamic csrfToken;
  final Menu? menu;

  GetAppMenu({
    required this.status,
    required this.message,
    required this.csrfToken,
    this.menu,
  });

  factory GetAppMenu.fromJson(Map<String, dynamic> json) => GetAppMenu(
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
class GetUserWisePkg {
  int status;
  String message;
  List<Package> packages;
  String userCountry;

  GetUserWisePkg({
    required this.status,
    required this.message,
    required this.packages,
    required this.userCountry,
  });

  factory GetUserWisePkg.fromJson(Map<String, dynamic> json) => GetUserWisePkg(
    status: json["status"],
    message: json["message"].toString(),
    packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
    userCountry: json["user_country"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    "user_country": userCountry,
  };
}

class Package {
  String packageId;
  String packageCountryId;
  String packageUsertypeId;
  String packageName;
  String packageDescription;
  String packagePrice;
  String packageDiscountPercentage;
  String packageDiscountAmount;
  String packageStartDate;
  String packageEndDate;
  String packageFreeNotices;
  String packageFreeBkUser;
  String level;
  String isDisplayInPublic;
  String isRatingOn;
  String packageIsactive;
  String packageCreatedBy;
  String packageCreatedDatetime;
  String packageUpdatedBy;
  String packageUpdatedDatetime;
  String packageIsdeleted;
  List<Menu> menus;

  Package({
    required this.packageId,
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
    required this.menus,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    packageId: json["package_id"].toString(),
    packageCountryId: json["package_country_id"].toString(),
    packageUsertypeId: json["package_usertype_id"].toString(),
    packageName: json["package_name"].toString(),
    packageDescription: json["package_description"].toString(),
    packagePrice: json["package_price"].toString(),
    packageDiscountPercentage: json["package_discount_percentage"].toString(),
    packageDiscountAmount: json["package_discount_amount"].toString(),
    packageStartDate: json["package_start_date"].toString(),
    packageEndDate: json["package_end_date"].toString(),
    packageFreeNotices: json["package_free_notices"].toString(),
    packageFreeBkUser: json["package_free_bk_user"].toString(),
    level: json["level"].toString(),
    isDisplayInPublic: json["is_display_in_public"].toString(),
    isRatingOn: json["is_rating_on"].toString(),
    packageIsactive: json["package_isactive"].toString(),
    packageCreatedBy: json["package_created_by"].toString(),
    packageCreatedDatetime: json["package_created_datetime"].toString(),
    packageUpdatedBy: json["package_updated_by"].toString(),
    packageUpdatedDatetime: json["package_updated_datetime"].toString(),
    packageIsdeleted: json["package_isdeleted"].toString(),
    menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "package_id": packageId,
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
    "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
  };
}

class Menu {
  String menuTitle;

  Menu({
    required this.menuTitle,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    menuTitle: json["menu_title"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "menu_title": menuTitle,
  };
}

class Getprofile {
  int status;
  String message;
  String csrfToken;
  Profile profile;

  Getprofile({
    required this.status,
    required this.message,
    required this.csrfToken,
    required this.profile,
  });

  factory Getprofile.fromJson(Map<String, dynamic> json) => Getprofile(
    status: json["status"],
    message: json["message"].toString(),
    csrfToken: json["csrf_token"].toString(),
    profile: Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "csrf_token": csrfToken,
    "profile": profile.toJson(),
  };
}

class Profile {
  String userId;
  String userTypeId;
  String firstName;
  String domain;
  String middleName;
  String lastName;
  String fullName;
  String shortName;
  String email;
  String currentPkgId;
  String mobile;
  String isDisplayWeb;
  String profilePic;
  String profilePicName;
  String dateOfBirth;
  String gender;
  String username;
  String countryId;
  String stateId;
  String cityId;
  String pincode;
  String sanadRegNo;
  String sanadRegYear;
  String sanadRegDate;
  String welfareNo;
  String welfareDate;
  String isPhysicalChal;
  String physicalDetail;
  String biodata;
  String biodataName;
  String address;
  String officeAddress;
  String companyMobile;
  String aboutUser;
  String websiteUrl;
  String bloodGroup;
  String bloodGroupId;
  String distCourtRegiNo;
  String distCourtRegiDate;
  String qualification;
  String assoMemberNo;
  String assoMemberType;
  String assoMemberDate;
  String experience;
  String notaryNo;
  String deathDate;
  String isAdvisory;
  List<String> categoryId;
  String categoriesTxt;
  String lawFirmCollege;
  String councilId;
  String associationId;
  String fbUrl;
  String instaUrl;
  String twitterUrl;
  String linkedinUrl;
  String slug;
  String videoProfile;
  String lawFirmName;
  String officeCountryId;
  String officeStateId;
  String officeCityId;
  String officePincode;
  String logo;
  String since;
  int handlerEditable;
  List<dynamic> doc;
  List<dynamic> docType;
  List<dynamic> userVerificationDocId;
  String isVerified;
  int percentage;
  List<dynamic> languages;

  Profile({
    required this.userId,
    required this.userTypeId,
    required this.firstName,
    required this.domain,
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
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    userId: json["user_id"].toString(),
    userTypeId: json["user_type_id"].toString(),
    firstName: json["first_name"].toString(),
    domain: json["domain"].toString(),
    middleName: json["middle_name"].toString(),
    lastName: json["last_name"].toString(),
    fullName: json["full_name"].toString(),
    shortName: json["short_name"].toString(),
    email: json["email"].toString(),
    currentPkgId: json["current_pkg_id"].toString(),
    mobile: json["mobile"].toString(),
    isDisplayWeb: json["is_display_web"].toString(),
    profilePic: json["profile_pic"].toString(),
    profilePicName: json["profile_pic_name"].toString(),
    dateOfBirth: json["date_of_birth"].toString(),
    gender: json["gender"].toString(),
    username: json["username"].toString(),
    countryId: json["country_id"].toString(),
    stateId: json["state_id"].toString(),
    cityId: json["city_id"].toString(),
    pincode: json["pincode"].toString(),
    sanadRegNo: json["sanad_reg_no"].toString(),
    sanadRegYear: json["sanad_reg_year"].toString(),
    sanadRegDate: json["sanad_reg_date"].toString(),
    welfareNo: json["welfare_no"].toString(),
    welfareDate: json["welfare_date"].toString(),
    isPhysicalChal: json["is_physical_chal"].toString(),
    physicalDetail: json["physical_detail"].toString(),
    biodata: json["biodata"].toString(),
    biodataName: json["biodata_name"].toString(),
    address: json["address"].toString(),
    officeAddress: json["office_address"].toString(),
    companyMobile: json["company_mobile"].toString(),
    aboutUser: json["about_user"].toString(),
    websiteUrl: json["website_url"].toString(),
    bloodGroup: json["blood_group"].toString(),
    bloodGroupId: json["blood_group_id"].toString(),
    distCourtRegiNo: json["dist_court_regi_no"].toString(),
    distCourtRegiDate: json["dist_court_regi_date"].toString(),
    qualification: json["qualification"].toString(),
    assoMemberNo: json["asso_member_no"].toString(),
    assoMemberType: json["asso_member_type"].toString(),
    assoMemberDate: json["asso_member_date"].toString(),
    experience: json["experience"].toString(),
    notaryNo: json["notary_no"].toString(),
    deathDate: json["death_date"].toString(),
    isAdvisory: json["is_advisory"].toString(),
    categoryId: List<String>.from(json["category_id"].map((x) => x)),
    categoriesTxt: json["categories_txt"].toString(),
    lawFirmCollege: json["law_firm_college"].toString(),
    councilId: json["council_id"].toString(),
    associationId: json["association_id"].toString(),
    fbUrl: json["fb_url"].toString(),
    instaUrl: json["insta_url"].toString(),
    twitterUrl: json["twitter_url"].toString(),
    linkedinUrl: json["linkedin_url"].toString(),
    slug: json["slug"].toString(),
    videoProfile: json["video_profile"].toString(),
    lawFirmName: json["law_firm_name"].toString(),
    officeCountryId: json["office_country_id"].toString(),
    officeStateId: json["office_state_id"].toString(),
    officeCityId: json["office_city_id"].toString(),
    officePincode: json["office_pincode"].toString(),
    logo: json["logo"].toString(),
    since: json["since"].toString(),
    handlerEditable: json["handler_editable"],
    doc: List<dynamic>.from(json["doc"].map((x) => x)),
    docType: List<dynamic>.from(json["doc_type"].map((x) => x)),
    userVerificationDocId: List<dynamic>.from(json["user_verification_doc_id"].map((x) => x)),
    isVerified: json["is_verified"].toString(),
    percentage: json["percentage"],
    languages: List<dynamic>.from(json["languages"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_type_id": userTypeId,
    "first_name": firstName,
    "domain": domain,
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
    "user_verification_doc_id": List<dynamic>.from(userVerificationDocId.map((x) => x)),
    "is_verified": isVerified,
    "percentage": percentage,
    "languages": List<dynamic>.from(languages.map((x) => x)),
  };
}

class Handlers {
  int status;
  String message;
  String csrfToken;
  List<Handler> customhandler;
  List<Handler> handlers;

  Handlers({
    required this.status,
    required this.message,
    required this.csrfToken,
    required this.customhandler,
    required this.handlers,
  });

  factory Handlers.fromJson(Map<String, dynamic> json) => Handlers(
    status: json["status"],
    message: json["message"].toString(),
    csrfToken: json["csrf_token"].toString(),
    customhandler:List<Handler>.from(json["customhandler"].map((x) => Handler.fromJson(x))),
    handlers: List<Handler>.from(json["handlers"].map((x) => Handler.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "csrf_token": csrfToken,
    "customhandler": customhandler,
    "handlers": List<dynamic>.from(handlers.map((x) => x.toJson())),
  };
}

class Handler {
  String name;
  int isSold;

  Handler({
    required this.name,
    required this.isSold,
  });

  factory Handler.fromJson(Map<String, dynamic> json) => Handler(
    name: json["name"].toString(),
    isSold: json["is_sold"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "is_sold": isSold,
  };
}
