
import 'dart:convert';

ClsCountriesResponseModel clsCountriesResponseModelFromJson(String str) => ClsCountriesResponseModel.fromJson(json.decode(str));

String clsCountriesResponseModelToJson(ClsCountriesResponseModel data) => json.encode(data.toJson());

class ClsCountriesResponseModel {
  ClsCountriesResponseModel({
    required this.status,
    required this.message,
    required this.countries,
  });

  final int status;
  final String message;
  final List<Country> countries;

  factory ClsCountriesResponseModel.fromJson(Map<String, dynamic> json) => ClsCountriesResponseModel(
    status: json["status"],
    message: json["message"],
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
  };
}

class Country {
  Country({
    required this.countryId,
    required this.countryName,
  });

  final String countryId;
  final String countryName;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    countryId: json["country_id"],
    countryName: json["country_name"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "country_name": countryName,
  };
}
