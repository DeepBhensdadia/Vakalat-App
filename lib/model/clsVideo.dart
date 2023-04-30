
class clsVideo {

  String? id;
  String? topic_id;
  String? user_id;
  String? plain_url;
  String? url;
  String? title;
  String? desc;
  String? is_delete;
  String? is_active;
  String? created_by;
  String? created_at;
  String? updated_by;
  String? updated_at;
  String? first_name;
  String? last_name;
  String? topic;
  String? topic_desc;
  String? language;
  String? category;
  String? sub_category;

  clsVideo(
      {this.id,
        this.topic_id,
        this.user_id,
        this.plain_url,
        this.url,
        this.title,
        this.desc,
        this.is_delete,
        this.is_active,
        this.created_by,
        this.created_at,
        this.updated_by,
        this.updated_at,
        this.first_name,
        this.last_name,
        this.topic,
        this.topic_desc,
        this.language,
        this.category,
        this.sub_category,});

  // This model is sub model of Login for fetching data object

  factory clsVideo.fromJson(Map<String, dynamic> json) {
    return clsVideo(
      id: json['id'] == null ? "" : json['id'] as String?,
      topic_id: json['topic_id'] == null ? "" : json['topic_id'] as String?,
      user_id: json['user_id'] == null ? "" : json['user_id'] as String?,
      plain_url: json['plain_url'] == null ? "" : json['plain_url'].toString(),
      url: json['url'] == null ? "" : json['url'] as String?,
      title: json['title'] == null ? "" : json['title'] as String?,
      desc: json['desc'] == null ? "" : json['desc'] as String?,
      is_delete: json['is_delete'] == null ? "" : json['is_delete'] as String?,
      is_active: json['is_active'] == null ? "" : json['is_active'] as String?,
      created_by: json['created_by'] == null ? "" : json['created_by'] as String?,
      created_at: json['created_at'] == null ? "" : json['created_at'] as String?,
      updated_by: json['updated_by'] == null ? "" : json['updated_by'] as String?,
      updated_at: json['updated_at'] == null ? "" : json['updated_at'] as String?,
      first_name: json['first_name'] == null ? "" : json['first_name'] as String?,
      last_name: json['last_name'] == null ? "" : json['last_name'] as String?,
      topic: json['topic'] == null ? "" : json['topic'] as String?,
      topic_desc: json['topic_desc'] == null ? "" : json['topic_desc'] as String?,
      language: json['language'] == null ? "" : json['language'] as String?,
      category: json['category'] == null ? "" : json['category'] as String?,
      sub_category: json['sub_category'] == null ? "" : json['sub_category'] as String?,
    );
  }

}
