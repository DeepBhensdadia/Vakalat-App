
class clsUserCategory {

  String? uc_user_id;
  String? uc_category_id;
  String? cat_name;

  clsUserCategory(
      {this.uc_user_id,
        this.uc_category_id,
        this.cat_name,});

  // This model is sub model of Login for fetching data object

  factory clsUserCategory.fromJson(Map<String, dynamic> json) {
    return clsUserCategory(
      uc_user_id: json['uc_user_id'] == null ? "" : json['uc_user_id'] as String?,
      uc_category_id: json['uc_category_id'] == null ? "" : json['uc_category_id'] as String?,
      cat_name: json['cat_name'] == null ? "" : json['cat_name'] as String?,
    );
  }

}
