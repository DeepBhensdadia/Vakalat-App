
import 'dart:convert';

GetHandlerList getHandlerListFromJson(String str) => GetHandlerList.fromJson(json.decode(str));

String getHandlerListToJson(GetHandlerList data) => json.encode(data.toJson());

class GetHandlerList {
  final int status;
  final String message;
  final dynamic csrfToken;
  final List<Handler> handlers;

  GetHandlerList({
    required this.status,
    required this.message,
    required this.csrfToken,
    required this.handlers,
  });

  factory GetHandlerList.fromJson(Map<String, dynamic> json) => GetHandlerList(
    status: json["status"],
    message: json["message"],
    csrfToken: json["csrf_token"],
    handlers: List<Handler>.from(json["handlers"].map((x) => Handler.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "csrf_token": csrfToken,
    "handlers": List<dynamic>.from(handlers.map((x) => x.toJson())),
  };
}

class Handler {
  final String name;
  final int isSold;

  Handler({
    required this.name,
    required this.isSold,
  });

  factory Handler.fromJson(Map<String, dynamic> json) => Handler(
    name: json["name"],
    isSold: json["is_sold"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "is_sold": isSold,
  };
}
