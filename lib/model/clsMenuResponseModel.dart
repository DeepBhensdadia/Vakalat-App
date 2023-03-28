import 'package:vakalat_flutter/model/clsMenu.dart';

class clsMenuResponseModel {
  int? status;
  String? message;
  List<clsMenu>? menus;

  clsMenuResponseModel({this.status, this.message, this.menus});

  factory clsMenuResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsMenu> listModel = List<clsMenu>.empty();
    if (json['menus'] != null) {
      var list = json['menus'] as List;

      listModel = list.map((i) => clsMenu.fromJson(i)).toList();
    } else {
      listModel = List<clsMenu>.empty();
    }

    return clsMenuResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      menus: listModel,
    );
  }
}
