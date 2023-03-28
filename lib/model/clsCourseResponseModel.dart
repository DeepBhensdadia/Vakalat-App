import 'package:vakalat_flutter/model/clsCourse.dart';

class clsCourseResponseModel {
  int? status;
  String? message;
  List<clsCourse>? courses;
  int? total;

  clsCourseResponseModel({this.status, this.message, this.courses, this.total});

  factory clsCourseResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsCourse> listModel = List<clsCourse>.empty();
    if (json['courses'] != null) {
      var list = json['courses'] as List;

      listModel = list.map((i) => clsCourse.fromJson(i)).toList();
    } else {
      listModel = List<clsCourse>.empty();
    }

    return clsCourseResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      courses: listModel,
      total: json['total'] == null ? 0 : json['total'] as int?,
    );
  }
}
