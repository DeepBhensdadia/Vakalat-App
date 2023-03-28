import 'package:vakalat_flutter/model/clsEventDetail.dart';
import 'package:vakalat_flutter/model/clsEventImage.dart';

class clsEventDetailResponseModel {
  int? status;
  String? message;
  clsEventDetail? event;
  List<clsEventImage>? images;
  clsEventDetailResponseModel({this.status, this.message, this.event , this.images});

  factory clsEventDetailResponseModel.fromJson(Map<String, dynamic> json) {

    clsEventDetail objEventDetail = clsEventDetail();
    if (json['event'] != null) {
      var json_event = json['event'] as Map<String, dynamic> ;

      objEventDetail = clsEventDetail.fromJson(json_event);
    } else {
      objEventDetail = clsEventDetail();
    }

    List<clsEventImage> listModel_images = List<clsEventImage>.empty();
    if (json['images'] != null) {
      var list = json['images'] as List;

      listModel_images = list.map((i) => clsEventImage.fromJson(i)).toList();
    } else {
      listModel_images = List<clsEventImage>.empty();
    }

    return clsEventDetailResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      event: objEventDetail,
      images: listModel_images,
    );
  }
}
