import 'package:vakalat_flutter/model/clsCollege.dart';

class clsCollegeResponseModel {
  int? status;
  String? message;
  List<clsCollege>? colleges;
  int? total;

  clsCollegeResponseModel({this.status, this.message, this.colleges, this.total});

  factory clsCollegeResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsCollege> listModel = List<clsCollege>.empty();
    if (json['colleges'] != null) {
      var list = json['colleges'] as List;

      listModel = list.map((i) => clsCollege.fromJson(i)).toList();
    } else {
      listModel = List<clsCollege>.empty();
    }

    return clsCollegeResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      colleges: listModel,
      total: json['total'] == null ? 0 : json['total'] as int?,
    );
  }
}
