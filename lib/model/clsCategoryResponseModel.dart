

import 'package:vakalat_flutter/model/clsCategory.dart';

class clsCategoryResponseModel {
  int? status;
  String? message;
  List<clsCategory>? categories;

  clsCategoryResponseModel({this.status, this.message, this.categories});

  factory clsCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsCategory> listModel = List<clsCategory>.empty();
    if (json['categories'] != null) {
      var list = json['categories'] as List;

      listModel = list.map((i) => clsCategory.fromJson(i)).toList();
    } else {
      listModel = List<clsCategory>.empty();
    }

    return clsCategoryResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      categories: listModel,
    );
  }
}
