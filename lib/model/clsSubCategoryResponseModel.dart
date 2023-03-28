

import 'package:vakalat_flutter/model/clsSubCategory.dart';

class clsSubCategoryResponseModel {
  int? status;
  String? message;
  List<clsSubCategory>? sub_category;

  clsSubCategoryResponseModel({this.status, this.message, this.sub_category});

  factory clsSubCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsSubCategory> listModel = List<clsSubCategory>.empty();
    if (json['sub_category'] != null) {
      var list = json['sub_category'] as List;

      listModel = list.map((i) => clsSubCategory.fromJson(i)).toList();
    } else {
      listModel = List<clsSubCategory>.empty();
    }

    return clsSubCategoryResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      sub_category: listModel,
    );
  }
}
