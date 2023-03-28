import 'package:vakalat_flutter/model/clsAAA.dart';

class clsAAAResponseModel {
  int? status;
  String? message;
  List<clsAAA>? a_list;

  clsAAAResponseModel({this.status, this.message, this.a_list});

  factory clsAAAResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsAAA> listModel = List<clsAAA>.empty();
    if (json['lawyers'] != null) {
      var list = json['lawyers'] as List;

      listModel = list.map((i) => clsAAA.fromJson(i)).toList();
    } else {
      listModel = List<clsAAA>.empty();
    }

    return clsAAAResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      a_list: listModel,
    );
  }
}
