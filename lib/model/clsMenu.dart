class clsMenu {

  String? menu_id;
  String? menu_title;

  clsMenu(
      {this.menu_id,
        this.menu_title,});

  // This model is sub model of Login for fetching data object

  factory clsMenu.fromJson(Map<String, dynamic> json) {
    return clsMenu(
      menu_id: json['menu_id'] == null ? "" : json['menu_id'] as String?,
      menu_title: json['menu_title'] == null ? "" : json['menu_title'] as String?,
    );
  }

}
