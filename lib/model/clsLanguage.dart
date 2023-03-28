class clsLanguage {

  String? id;
  String? title;
  String? description;
  String? is_delete;
  String? is_active;
  String? created_by;
  String? created_datetime;
  String? updated_by;
  String? updated_datetime;

  clsLanguage(
      {this.id,
        this.title,
        this.description,
        this.is_delete,
        this.is_active,
        this.created_by,
        this.created_datetime,
        this.updated_by,
        this.updated_datetime,});

  // This model is sub model of Login for fetching data object

  factory clsLanguage.fromJson(Map<String, dynamic> json) {
    return clsLanguage(
      id: json['id'] == null ? "" : json['id'] as String?,
      title: json['title'] == null ? "" : json['title'] as String?,
      description: json['description'] == null ? "" : json['description'] as String?,
      is_delete: json['is_delete'] == null ? "" : json['is_delete'] as String?,
      is_active: json['is_active'] == null ? "" : json['is_active'] as String?,
      created_by: json['created_by'] == null ? "" : json['created_by'] as String?,
      created_datetime: json['created_datetime'] == null ? "" : json['created_datetime'] as String?,
      updated_by: json['updated_by'] == null ? "" : json['updated_by'] as String?,
      updated_datetime: json['updated_datetime'] == null ? "" : json['updated_datetime'] as String?,
    );
  }

}
