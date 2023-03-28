import 'package:vakalat_flutter/model/clsCity.dart';

class clsCityResponseModel {
  int? status;
  String? message;
  List<clsCity>? cities;

  clsCityResponseModel({this.status, this.message, this.cities});

  factory clsCityResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsCity> listModel = List<clsCity>.empty();
    if (json['cities'] != null) {
      var list = json['cities'] as List;

      listModel = list.map((i) => clsCity.fromJson(i)).toList();
    } else {
      listModel = List<clsCity>.empty();
    }

    return clsCityResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      cities: listModel,
    );
  }
}
