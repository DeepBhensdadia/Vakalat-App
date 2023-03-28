class clsCity {

  String? city_id;
  String? city_name;
  clsCity(
      {this.city_id,
        this.city_name,});

  // This model is sub model of Login for fetching data object

  factory clsCity.fromJson(Map<String, dynamic> json) {
    return clsCity(
      city_id: json['city_id'] == null ? "" : json['city_id'] as String?,
      city_name: json['city_name'] == null ? "" : json['city_name'] as String?,
    );
  }

}
