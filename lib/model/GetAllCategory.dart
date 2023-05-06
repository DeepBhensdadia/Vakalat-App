// To parse this JSON data, do
//
//     final getAllCategory = getAllCategoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetAllCategory getAllCategoryFromJson(String str) =>
    GetAllCategory.fromJson(json.decode(str));

String getAllCategoryToJson(GetAllCategory data) => json.encode(data.toJson());

class GetAllCategory {
  final int status;
  final String message;
  final List<Category> categories;

  GetAllCategory({
    required this.status,
    required this.message,
    required this.categories,
  });

  factory GetAllCategory.fromJson(Map<String, dynamic> json) => GetAllCategory(
        status: json["status"],
        message: json["message"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  List<Child> getAllCategory() {
    List<Child> temp = <Child>[];
    for (Category element in categories) {
      temp.addAll(element.getMainWithSub());
    }
    temp.sort((a, b) => a.name.compareTo(b.name));

    return temp;
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  final String id;
  final String name;
  final List<Child> children;

  Category({
    required this.id,
    required this.name,
    required this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        children:
            List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
      );

  List<Child> getMainWithSub() {
    List<Child> temp = <Child>[];
    temp.addAll(children);
    temp.add(Child(id: id, name: name, children: []));
    return temp;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
      };
}

class Child {
  final String id;
  final String name;
  final List<dynamic> children;

  Child({
    required this.id,
    required this.name,
    required this.children,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["id"],
        name: json["name"],
        children: List<dynamic>.from(json["children"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "children": List<dynamic>.from(children.map((x) => x)),
      };
}
