
class clsCategory {
  String? cat_id;
  String? cat_parent_id;
  String? cat_name;
  String? cat_meta_desc;
  String? cat_img;
  String? cat_description;
  String? cat_url;
  List<clsCategory>? subcategories;

  clsCategory({
    this.cat_id,
    this.cat_parent_id,
    this.cat_name,
    this.cat_meta_desc,
    this.cat_img,
    this.cat_description,
    this.cat_url,
    this.subcategories,
  });

  // This model is sub model of Login for fetching data object

  factory clsCategory.fromJson(Map<String, dynamic> json) {
    List<clsCategory> listModel = List<clsCategory>.empty();
    if (json['subcategories'] != null) {

      var list = json['subcategories'] as List;

      listModel = list.map((i) => clsCategory.fromJson(i)).toList();
    } else {
      listModel = List<clsCategory>.empty();
    }

    return clsCategory(
      cat_id: json['cat_id'] == null ? "" : json['cat_id'] as String?,
      cat_parent_id:
          json['cat_parent_id'] == null ? "" : json['cat_parent_id'] as String?,
      cat_name: json['cat_name'] == null ? "" : json['cat_name'] as String?,
      cat_meta_desc:
          json['cat_meta_desc'] == null ? "" : json['cat_meta_desc'] as String?,
      cat_img: json['cat_img'] == null ? "" : json['cat_img'] as String?,
      cat_description: json['cat_description'] == null
          ? ""
          : json['cat_description'] as String?,
      cat_url: json['cat_url'] == null ? "" : json['cat_url'] as String?,
      subcategories: listModel,
    );
  }
}
