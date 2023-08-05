import 'dart:convert';

GetPackagesModel getPackagesModelFromJson(String str) => GetPackagesModel.fromJson(json.decode(str));

String getPackagesModelToJson(GetPackagesModel data) => json.encode(data.toJson());

class GetPackagesModel {
  GetPackagesModel({
    required this.status,
    required this.message,
    required this.packages,
    required this.userCountry,
  });

  final int status;
  final String message;
  final List<Package> packages;
  final String userCountry;

  factory GetPackagesModel.fromJson(Map<String, dynamic> json) => GetPackagesModel(
    status: json["status"],
    message: json["message"],
    packages: List<Package>.from(json["packages"].map((x) => Package.fromJson(x))),
    userCountry: json["user_country"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "packages": List<dynamic>.from(packages.map((x) => x.toJson())),
    "user_country": userCountry,
  };
}

class Package {
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

  final String packageId;
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
  final List<Menu> menus;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    packageId: json["package_id"],
    packageCountryId: json["package_country_id"],
    packageUsertypeId: json["package_usertype_id"],
    packageName: json["package_name"],
    packageDescription: json["package_description"],
    packagePrice: json["package_price"],
    packageDiscountPercentage: json["package_discount_percentage"],
    packageDiscountAmount: json["package_discount_amount"],
    packageStartDate: json["package_start_date"],
    packageEndDate: json["package_end_date"],
    packageFreeNotices: json["package_free_notices"],
    packageFreeBkUser: json["package_free_bk_user"],
    level: json["level"],
    isDisplayInPublic: json["is_display_in_public"],
    isRatingOn: json["is_rating_on"],
    packageIsactive: json["package_isactive"],
    packageCreatedBy: json["package_created_by"],
    packageCreatedDatetime: json["package_created_datetime"],
    packageUpdatedBy: json["package_updated_by"],
    packageUpdatedDatetime: json["package_updated_datetime"],
    packageIsdeleted: json["package_isdeleted"],
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
  Menu({
    required this.menuTitle,
  });

  final String menuTitle;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    menuTitle: json["menu_title"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "menu_title": menuTitle,
  };
}
