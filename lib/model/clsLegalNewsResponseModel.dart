import 'package:vakalat_flutter/model/clsLegalNews.dart';

class clsLegalNewsResponseModel {
  int? status;
  String? message;
  List<clsLegalNews>? legal_news;
  int? total;

  clsLegalNewsResponseModel({this.status, this.message, this.legal_news , this.total});

  factory clsLegalNewsResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsLegalNews> listModel = List<clsLegalNews>.empty();
    if (json['legal_news'] != null) {
      var list = json['legal_news'] as List;

      listModel = list.map((i) => clsLegalNews.fromJson(i)).toList();
    } else {
      listModel = List<clsLegalNews>.empty();
    }

    return clsLegalNewsResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      legal_news: listModel,
      total: json['total'] == null ? 0 : json['total'] as int?,
    );
  }
}
