import 'package:vakalat_flutter/model/clsJob.dart';

class clsJobResponseModel {
  int? status;
  String? message;
  List<clsJob>? jobs;
  int? total;
  clsJobResponseModel({this.status, this.message, this.jobs , this.total});

  factory clsJobResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsJob> listModel = List<clsJob>.empty();
    if (json['jobs'] != null) {
      var list = json['jobs'] as List;

      listModel = list.map((i) => clsJob.fromJson(i)).toList();
    } else {
      listModel = List<clsJob>.empty();
    }

    return clsJobResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      jobs: listModel,
      total: json['total'] == null ? 0 : json['total'] as int?,
    );
  }
}
