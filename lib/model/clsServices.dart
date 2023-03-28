class clsServices {

  String? sm_id;
  String? sm_title;

  clsServices(
      {this.sm_id,
        this.sm_title,});

  factory clsServices.fromJson(Map<String, dynamic> json) {
    return clsServices(
      sm_id: json['sm_id'] == null ? "" : json['sm_id'] as String?,
      sm_title: json['sm_title'] == null ? "" : json['sm_title'] as String?,
    );
  }

}
