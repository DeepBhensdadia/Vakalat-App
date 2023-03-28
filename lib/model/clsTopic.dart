class clsTopic {

  String? id;
  String? parent_id;
  String? lang_id;
  String? cat_id;
  String? sub_cat_id;
  String? title;
  String? description;
  String? is_delete;
  String? is_active;
  String? created_by;
  String? created_at;
  String? updated_by;
  String? updated_at;

  clsTopic(
      {this.id,
        this.parent_id,
        this.lang_id,
        this.cat_id,
        this.sub_cat_id,
        this.title,
        this.description,
        this.is_delete,
        this.is_active,
        this.created_by,
        this.created_at,
        this.updated_by,
        this.updated_at,});

  // This model is sub model of Login for fetching data object

  factory clsTopic.fromJson(Map<String, dynamic> json) {
    return clsTopic(
      id: json['id'] == null ? "" : json['id'] as String?,
      parent_id: json['parent_id'] == null ? "" : json['parent_id'] as String?,
      lang_id: json['lang_id'] == null ? "" : json['lang_id'] as String?,
      cat_id: json['cat_id'] == null ? "" : json['cat_id'] as String?,
      sub_cat_id: json['sub_cat_id'] == null ? "" : json['sub_cat_id'] as String?,
      title: json['title'] == null ? "" : json['title'] as String?,
      description: json['description'] == null ? "" : json['description'] as String?,
      is_delete: json['is_delete'] == null ? "" : json['is_delete'] as String?,
      is_active: json['is_active'] == null ? "" : json['is_active'] as String?,
      created_by: json['created_by'] == null ? "" : json['created_by'] as String?,
      created_at: json['created_at'] == null ? "" : json['created_at'] as String?,
      updated_by: json['updated_by'] == null ? "" : json['updated_by'] as String?,
      updated_at: json['updated_at'] == null ? "" : json['updated_at'] as String?,
    );
  }

}
