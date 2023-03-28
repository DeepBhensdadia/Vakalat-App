class clsEventImage {

  String? id;
  String? image_url;

  clsEventImage(
      {this.id,
        this.image_url,});

  // This model is sub model of Login for fetching data object

  factory clsEventImage.fromJson(Map<String, dynamic> json) {
    return clsEventImage(
      id: json['id'] == null ? "" : json['id'] as String?,
      image_url: json['image_url'] == null ? "" : json['image_url'] as String?,
    );
  }

}
