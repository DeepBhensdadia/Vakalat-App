// cat clsAAA.dart > cls.dart
// cat clsAAAResponseModel.dart > clsResponseModel.dart
class clsAAA {

  String? id;

  clsAAA(
      {this.id,});

  // This model is sub model of Login for fetching data object

  factory clsAAA.fromJson(Map<String, dynamic> json) {
    return clsAAA(
      id: json['id'] == null ? "" : json['id'] as String?,
    );
  }

}
