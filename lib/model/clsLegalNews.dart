class clsLegalNews {

  String? id;
  String? title;
  String? link;
  String? sort_desc;
  String? photo;
  String? photo_url;
  String? user_id;
  String? is_active;
  String? is_delete;
  String? created_by;
  String? created_at;
  String? updated_by;
  String? updated_at;
  String? law_firm_college;

  clsLegalNews(
      {this.id,
        this.title,
        this.link,
        this.sort_desc,
        this.photo,
        this.photo_url,
        this.user_id,
        this.is_active,
        this.is_delete,
        this.created_by,
        this.created_at,
        this.updated_by,
        this.updated_at,
        this.law_firm_college,});

  // This model is sub model of Login for fetching data object

  factory clsLegalNews.fromJson(Map<String, dynamic> json) {
    return clsLegalNews(
      id: json['id'] == null ? "" : json['id'] as String?,
      title: json['title'] == null ? "" : json['title'] as String?,
      link: json['link'] == null ? "" : json['link'] as String?,
      sort_desc: json['sort_desc'] == null ? "" : json['sort_desc'] as String?,
      photo: json['photo'] == null ? "" : json['photo'] as String?,
      photo_url: json['photo_url'] == null ? "" : json['photo_url'] as String?,
      user_id: json['user_id'] == null ? "" : json['user_id'] as String?,
      is_active: json['is_active'] == null ? "" : json['is_active'] as String?,
      is_delete: json['is_delete'] == null ? "" : json['is_delete'] as String?,
      created_by: json['created_by'] == null ? "" : json['created_by'] as String?,
      created_at: json['created_at'] == null ? "" : json['created_at'] as String?,
      updated_by: json['updated_by'] == null ? "" : json['updated_by'] as String?,
      updated_at: json['updated_at'] == null ? "" : json['updated_at'] as String?,
      law_firm_college: json['law_firm_college'] == null ? "" : json['law_firm_college'] as String?,
    );
  }

}
