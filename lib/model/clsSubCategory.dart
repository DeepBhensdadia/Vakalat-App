
class clsSubCategory {

  String? cat_id;
  String? cat_parent_id;
  String? cat_name;
  String? cat_url;

  clsSubCategory(
      {this.cat_id,
        this.cat_parent_id,
        this.cat_name,
        this.cat_url,});

  // This model is sub model of Login for fetching data object

  factory clsSubCategory.fromJson(Map<String, dynamic> json) {
    return clsSubCategory(
      cat_id: json['cat_id'] == null ? "" : json['cat_id'] as String?,
      cat_parent_id: json['cat_parent_id'] == null ? "" : json['cat_parent_id'] as String?,
      cat_name: json['cat_name'] == null ? "" : json['cat_name'] as String?,
      cat_url: json['cat_url'] == null ? "" : json['cat_url'] as String?,
    );
  }

}
