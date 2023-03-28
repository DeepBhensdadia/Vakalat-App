import 'package:vakalat_flutter/model/clsLegalNotice.dart';

class clsLegalNoticeResponseModel {
  int? status;
  String? message;
  List<clsLegalNotice>? legal_notices;
  int? total;

  clsLegalNoticeResponseModel({this.status, this.message, this.legal_notices , this.total});

  factory clsLegalNoticeResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsLegalNotice> listModel = List<clsLegalNotice>.empty();
    if (json['legal_notices'] != null) {
      var list = json['legal_notices'] as List;

      listModel = list.map((i) => clsLegalNotice.fromJson(i)).toList();
    } else {
      listModel = List<clsLegalNotice>.empty();
    }

    return clsLegalNoticeResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      legal_notices: listModel,
      total: json['total'] == null ? 0 : json['total'] as int?,
    );
  }
}
