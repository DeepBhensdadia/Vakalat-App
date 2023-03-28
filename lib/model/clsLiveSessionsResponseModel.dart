import 'package:vakalat_flutter/model/clsLiveSessions.dart';

class clsLiveSessionsResponseModel {
  int? status;
  String? message;
  List<clsLiveSessions>? live_session;
  int? total;

  clsLiveSessionsResponseModel({this.status, this.message, this.live_session , this.total});

  factory clsLiveSessionsResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsLiveSessions> listModel = List<clsLiveSessions>.empty();
    if (json['live_session'] != null) {
      var list = json['live_session'] as List;

      listModel = list.map((i) => clsLiveSessions.fromJson(i)).toList();
    } else {
      listModel = List<clsLiveSessions>.empty();
    }

    return clsLiveSessionsResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      live_session: listModel,
      total: json['total'] == null ? 0 : json['total'] as int?,
    );
  }
}
