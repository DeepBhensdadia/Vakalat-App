

import 'package:vakalat_flutter/model/clsLawyer.dart';

class clsLawyerResponseModel {
  int? status;
  String? message;
  List<clsLawyer>? lawyers;
  int? total;
  clsLawyerResponseModel({this.status, this.message, this.lawyers , this.total});

  factory clsLawyerResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsLawyer> listModel = List<clsLawyer>.empty();
    if (json['lawyers'] != null) {
      var list = json['lawyers'] as List;

      listModel = list.map((i) => clsLawyer.fromJson(i)).toList();
    } else {
      listModel = List<clsLawyer>.empty();
    }

    return clsLawyerResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      lawyers: listModel,
      total: json['total'] == null ? 0 : json['total'] as int?,
    );
  }
}
