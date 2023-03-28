
class clsAboutUsResponseModel {
  int? status;
  String? message;
  String? about_us;

  clsAboutUsResponseModel({this.status, this.message, this.about_us});

  factory clsAboutUsResponseModel.fromJson(Map<String, dynamic> json) {


    return clsAboutUsResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      about_us: json['about_us'] == null ? "" : json['about_us'] as String?,
    );
  }
}
