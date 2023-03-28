
class clsLegalNotice {

  String? id;
  String? user_id;
  String? title;
  String? desc;
  String? photo;
  String? attachment;
  String? from_notice;
  String? to_notice;
  String? notice_date;
  String? publish_start_date;
  String? publish_end_date;
  String? status;
  String? is_active;
  String? is_delete;
  String? created_by;
  String? created_at;
  String? updated_by;
  String? updated_at;
  String? first_name;
  String? last_name;

  clsLegalNotice(
      {this.id,
        this.user_id,
        this.title,
        this.desc,
        this.photo,
        this.attachment,
        this.from_notice,
        this.to_notice,
        this.notice_date,
        this.publish_start_date,
        this.publish_end_date,
        this.status,
        this.is_active,
        this.is_delete,
        this.created_by,
        this.created_at,
        this.updated_by,
        this.updated_at,
        this.first_name,
        this.last_name,});

  // This model is sub model of Login for fetching data object

  factory clsLegalNotice.fromJson(Map<String, dynamic> json) {
    return clsLegalNotice(
      id: json['id'] == null ? "" : json['id'] as String?,
      user_id: json['user_id'] == null ? "" : json['user_id'] as String?,
      title: json['title'] == null ? "" : json['title'] as String?,
      desc: json['desc'] == null ? "" : json['desc'] as String?,
      photo: json['photo'] == null ? "" : json['photo'] as String?,
      attachment: json['attachment'] == null ? "" : json['attachment'] as String?,
      from_notice: json['from_notice'] == null ? "" : json['from_notice'] as String?,
      to_notice: json['to_notice'] == null ? "" : json['to_notice'] as String?,
      notice_date: json['notice_date'] == null ? "" : json['notice_date'] as String?,
      publish_start_date: json['publish_start_date'] == null ? "" : json['publish_start_date'] as String?,
      publish_end_date: json['publish_end_date'] == null ? "" : json['publish_end_date'] as String?,
      status: json['status'] == null ? "" : json['status'] as String?,
      is_active: json['is_active'] == null ? "" : json['is_active'] as String?,
      is_delete: json['is_delete'] == null ? "" : json['is_delete'] as String?,
      created_by: json['created_by'] == null ? "" : json['created_by'] as String?,
      created_at: json['created_at'] == null ? "" : json['created_at'] as String?,
      updated_by: json['updated_by'] == null ? "" : json['updated_by'] as String?,
      updated_at: json['updated_at'] == null ? "" : json['updated_at'] as String?,
      first_name: json['first_name'] == null ? "" : json['first_name'] as String?,
      last_name: json['last_name'] == null ? "" : json['last_name'] as String?,
    );
  }

}
