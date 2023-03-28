
class clsPrivacyPolicyResponseModel {
  int? status;
  String? message;
  String? privacy_policy;

  clsPrivacyPolicyResponseModel({this.status, this.message, this.privacy_policy});

  factory clsPrivacyPolicyResponseModel.fromJson(Map<String, dynamic> json) {


    return clsPrivacyPolicyResponseModel(
      status: json['status'] == null ? 0 : json['status'] as int?,
      message: json['message'] == null ? "" : json['message'] as String?,
      privacy_policy: json['privacy_policy'] == null ? "" : json['privacy_policy'] as String?,
    );
  }
}
