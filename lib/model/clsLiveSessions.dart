
class clsLiveSessions {

  String? id;
  String? photo;
  String? title;
  String? description;
  String? from_date;
  String? to_date;
  String? is_paid;
  String? fees;
  String? is_delete;
  String? is_active;
  String? created_by;
  String? created_datetime;
  String? updated_by;
  String? updated_datetime;

  clsLiveSessions(
      {this.id,
        this.photo,
        this.title,
        this.description,
        this.from_date,
        this.to_date,
        this.is_paid,
        this.fees,
        this.is_delete,
        this.is_active,
        this.created_by,
        this.created_datetime,
        this.updated_by,
        this.updated_datetime,});

  // This model is sub model of Login for fetching data object

  factory clsLiveSessions.fromJson(Map<String, dynamic> json) {
    return clsLiveSessions(
      id: json['id'] == null ? "" : json['id'] as String?,
      photo: json['photo'] == null ? "" : json['photo'] as String?,
      title: json['title'] == null ? "" : json['title'] as String?,
      description: json['description'] == null ? "" : json['description'] as String?,
      from_date: json['from_date'] == null ? "" : json['from_date'] as String?,
      to_date: json['to_date'] == null ? "" : json['to_date'] as String?,
      is_paid: json['is_paid'] == null ? "" : json['is_paid'] as String?,
      fees: json['fees'] == null ? "" : json['fees'] as String?,
      is_delete: json['is_delete'] == null ? "" : json['is_delete'] as String?,
      is_active: json['is_active'] == null ? "" : json['is_active'] as String?,
      created_by: json['created_by'] == null ? "" : json['created_by'] as String?,
      created_datetime: json['created_datetime'] == null ? "" : json['created_datetime'] as String?,
      updated_by: json['updated_by'] == null ? "" : json['updated_by'] as String?,
      updated_datetime: json['updated_datetime'] == null ? "" : json['updated_datetime'] as String?,
    );
  }

}
