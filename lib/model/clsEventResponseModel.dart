import 'package:vakalat_flutter/model/clsEvent.dart';

class clsEventResponseModel {
  int? status;
  String? message;
  List<clsEvent>? events;
  int? total;
  clsEventResponseModel({this.status, this.message, this.events, this.total});

  factory clsEventResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsEvent> listModel = List<clsEvent>.empty();
    if (json['events'] != null) {
      var list = json['events'] as List;

      listModel = list.map((i) => clsEvent.fromJson(i)).toList();
    } else {
      listModel = List<clsEvent>.empty();
    }

    return clsEventResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      events: listModel,
      total: json['total'] == null ? 0 : json['total'] as int?,
    );
  }
}
