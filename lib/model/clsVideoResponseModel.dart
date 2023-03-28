import 'package:vakalat_flutter/model/clsVideo.dart';

class clsVideoResponseModel {
  int? status;
  String? message;
  List<clsVideo>? videos;
  int? total;

  clsVideoResponseModel({this.status, this.message, this.videos, this.total});

  factory clsVideoResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsVideo> listModel = List<clsVideo>.empty();
    if (json['videos'] != null) {
      var list = json['videos'] as List;
      listModel = list.map((i) => clsVideo.fromJson(i)).toList();
    } else {
      listModel = List<clsVideo>.empty();
    }

    return clsVideoResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int,
      message: json['message'] == null ? "" : json['message'] as String?,
      videos: listModel,
      total: json['total'] == null ? 0 : json['total'] as int,
    );
  }
}
