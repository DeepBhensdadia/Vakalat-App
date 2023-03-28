
class clsEvent {

  String? event_id;
  String? event_type_id;
  String? photo;
  String? event_title;
  String? description;
  String? location;
  String? from_date;
  String? to_date;
  String? from_time;
  String? to_time;
  String? contact_number;
  String? registration_required;
  String? registration_fees;
  String? created_by;
  String? user_master_id;
  String? created_datetime;
  String? updated_by;
  String? updated_datetime;
  String? is_delete;
  String? first_name;
  String? last_name;
  String? law_firm_college;
  String? image_url;
  String? is_cover;
  String? city_name;
  String? state_name;
  String? country_name;

  clsEvent(
      {this.event_id,
        this.event_type_id,
        this.photo,
        this.event_title,
        this.description,
        this.location,
        this.from_date,
        this.to_date,
        this.from_time,
        this.to_time,
        this.contact_number,
        this.registration_required,
        this.registration_fees,
        this.created_by,
        this.user_master_id,
        this.created_datetime,
        this.updated_by,
        this.updated_datetime,
        this.is_delete,
        this.first_name,
        this.last_name,
        this.law_firm_college,
        this.image_url,
        this.is_cover,
        this.city_name,
        this.state_name,
        this.country_name,});

  // This model is sub model of Login for fetching data object

  factory clsEvent.fromJson(Map<String, dynamic> json) {
    return clsEvent(
      event_id: json['event_id'] == null ? "" : json['event_id'] as String?,
      event_type_id: json['event_type_id'] == null ? "" : json['event_type_id'] as String?,
      photo: json['photo'] == null ? "" : json['photo'] as String?,
      event_title: json['event_title'] == null ? "" : json['event_title'] as String?,
      description: json['description'] == null ? "" : json['description'] as String?,
      location: json['location'] == null ? "" : json['location'] as String?,
      from_date: json['from_date'] == null ? "" : json['from_date'] as String?,
      to_date: json['to_date'] == null ? "" : json['to_date'] as String?,
      from_time: json['from_time'] == null ? "" : json['from_time'] as String?,
      to_time: json['to_time'] == null ? "" : json['to_time'] as String?,
      contact_number: json['contact_number'] == null ? "" : json['contact_number'] as String?,
      registration_required: json['registration_required'] == null ? "" : json['registration_required'] as String?,
      registration_fees: json['registration_fees'] == null ? "" : json['registration_fees'] as String?,
      created_by: json['created_by'] == null ? "" : json['created_by'] as String?,
      user_master_id: json['user_master_id'] == null ? "" : json['user_master_id'] as String?,
      created_datetime: json['created_datetime'] == null ? "" : json['created_datetime'] as String?,
      updated_by: json['updated_by'] == null ? "" : json['updated_by'] as String?,
      updated_datetime: json['updated_datetime'] == null ? "" : json['updated_datetime'] as String?,
      is_delete: json['is_delete'] == null ? "" : json['is_delete'] as String?,
      first_name: json['first_name'] == null ? "" : json['first_name'] as String?,
      last_name: json['last_name'] == null ? "" : json['last_name'] as String?,
      law_firm_college: json['law_firm_college'] == null ? "" : json['law_firm_college'] as String?,
      image_url: json['image_url'] == null ? "" : json['image_url'] as String?,
      is_cover: json['is_cover'] == null ? "" : json['is_cover'] as String?,
      city_name: json['city_name'] == null ? "" : json['city_name'] as String?,
      state_name: json['state_name'] == null ? "" : json['state_name'] as String?,
      country_name: json['country_name'] == null ? "" : json['country_name'] as String?,
    );
  }

}
