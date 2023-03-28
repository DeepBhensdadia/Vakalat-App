class GeneralResponseModel {

  int? status;
  String? message;
  String? access_token;

  // General Model for all Class
  GeneralResponseModel({this.status, this.message, this.access_token});

  factory GeneralResponseModel.fromJson(Map<String, dynamic> json) {
    print('sdfd');
    return GeneralResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      access_token: json['access_token'] == null ? "" : json['access_token'] as String?,
    );
  }
}
