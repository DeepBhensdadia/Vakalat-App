

import 'dart:convert';

ClsStateResponseModel clsStateResponseModelFromJson(String str) => ClsStateResponseModel.fromJson(json.decode(str));

String clsStateResponseModelToJson(ClsStateResponseModel data) => json.encode(data.toJson());

class ClsStateResponseModel {
  ClsStateResponseModel({
    required this.status,
    required this.message,
    required this.states,
  });

  final int status;
  final String message;
  final List<Rajya> states;

  factory ClsStateResponseModel.fromJson(Map<String, dynamic> json) => ClsStateResponseModel(
    status: json["status"],
    message: json["message"],
    states: List<Rajya>.from(json["states"].map((x) => Rajya.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "states": List<dynamic>.from(states.map((x) => x.toJson())),
  };
}

class Rajya {
  Rajya({
    required this.stateId,
    required this.stateName,
  });

  final String stateId;
  final String stateName;

  factory Rajya.fromJson(Map<String, dynamic> json) => Rajya(
    stateId: json["state_id"],
    stateName: json["state_name"],
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "state_name": stateName,
  };
}
