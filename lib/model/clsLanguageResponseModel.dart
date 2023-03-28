import 'package:vakalat_flutter/model/clsLanguage.dart';

class clsLanguageResponseModel {
  int? status;
  String? message;
  List<clsLanguage>? languages;

  clsLanguageResponseModel({this.status, this.message, this.languages});

  factory clsLanguageResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsLanguage> listModel = List<clsLanguage>.empty();
    if (json['languages'] != null) {
      var list = json['languages'] as List;

      listModel = list.map((i) => clsLanguage.fromJson(i)).toList();
    } else {
      listModel = List<clsLanguage>.empty();
    }

    return clsLanguageResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      languages: listModel,
    );
  }
}
