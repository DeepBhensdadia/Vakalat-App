
import 'dart:convert';

ClsCitiesResponseModel clsCitiesResponseModelFromJson(String str) => ClsCitiesResponseModel.fromJson(json.decode(str));

String clsCitiesResponseModelToJson(ClsCitiesResponseModel data) => json.encode(data.toJson());

class ClsCitiesResponseModel {
  ClsCitiesResponseModel({
    required this.status,
    required this.message,
    required this.cities,
  });

  final int status;
  final String message;
  final List<City> cities;

  factory ClsCitiesResponseModel.fromJson(Map<String, dynamic> json) => ClsCitiesResponseModel(
    status: json["status"],
    message: json["message"],
    cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
  };
}

class City {
  City({
    required this.cityId,
    required this.cityName,
  });

  final String cityId;
  final String cityName;

  factory City.fromJson(Map<String, dynamic> json) => City(
    cityId: json["city_id"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "city_name": cityName,
  };
}
