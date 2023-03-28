import 'package:vakalat_flutter/model/clsTopic.dart';

class clsTopicResponseModel {
  int? status;
  String? message;
  List<clsTopic>? topics;

  clsTopicResponseModel({this.status, this.message, this.topics});

  factory clsTopicResponseModel.fromJson(Map<String, dynamic> json) {
    List<clsTopic> listModel = List<clsTopic>.empty();
    if (json['topics'] != null) {
      var list = json['topics'] as List;

      listModel = list.map((i) => clsTopic.fromJson(i)).toList();
    } else {
      listModel = List<clsTopic>.empty();
    }

    return clsTopicResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      topics: listModel,
    );
  }
}
