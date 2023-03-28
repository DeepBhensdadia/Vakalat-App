import 'package:vakalat_flutter/model/clsLawyerDetail.dart';
import 'package:vakalat_flutter/model/clsServices.dart';
import 'package:vakalat_flutter/model/clsUserCategory.dart';

class clsLawyerDetailResponseModel {
  int? status;
  String? message;
  clsLawyerDetail? lawyer_data;
  List<clsUserCategory>? user_category;
  List<clsServices>? services;

  clsLawyerDetailResponseModel({this.status, this.message, this.lawyer_data , this.user_category ,this.services});

  factory clsLawyerDetailResponseModel.fromJson(Map<String, dynamic> json) {


   clsLawyerDetail objLawyerDetail = clsLawyerDetail();
    if (json['lawyer_data'] != null) {
      var json_lawyer_data = json['lawyer_data'] as Map<String, dynamic> ;

      objLawyerDetail = clsLawyerDetail.fromJson(json_lawyer_data);
    } else {
      objLawyerDetail = clsLawyerDetail();
    }

    List<clsUserCategory> listModel_UserCategory = List<clsUserCategory>.empty();
    if (json['user_category'] != null) {
      var list = json['user_category'] as List;

      listModel_UserCategory = list.map((i) => clsUserCategory.fromJson(i)).toList();
    } else {
      listModel_UserCategory = List<clsUserCategory>.empty();
    }

   List<clsServices> listModel_Services = List<clsServices>.empty();
   if (json['services'] != null) {
     var list = json['services'] as List;

     listModel_Services = list.map((i) => clsServices.fromJson(i)).toList();
   } else {
     listModel_Services = List<clsServices>.empty();
   }

    return clsLawyerDetailResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      lawyer_data: objLawyerDetail,
        user_category: listModel_UserCategory,
      services: listModel_Services,
    );
  }
}
