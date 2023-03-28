import 'package:vakalat_flutter/model/clsJobDetail.dart';

class clsJobDetailResponseModel {
  int? status;
  String? message;
  clsJobDetail? job;

  clsJobDetailResponseModel({this.status, this.message, this.job , });

  factory clsJobDetailResponseModel.fromJson(Map<String, dynamic> json) {
    clsJobDetail objJobDetail = clsJobDetail();

    if (json['job'] != null) {
      var json_job_data = json['job'] as Map<String, dynamic> ;

      objJobDetail = clsJobDetail.fromJson(json_job_data);
    } else {
      objJobDetail = clsJobDetail();
    }


    return clsJobDetailResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      job: objJobDetail,
    );
  }
}
