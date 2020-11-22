// To parse this JSON data, do
//
//     final homeCategoryClass = homeCategoryClassFromJson(jsonString);

import 'dart:convert';

HomeCategoryClass homeCategoryClassFromJson(String str) =>
    HomeCategoryClass.fromJson(json.decode(str));

String homeCategoryClassToJson(HomeCategoryClass data) =>
    json.encode(data.toJson());

class HomeCategoryClass {
  HomeCategoryClass({
    this.category,
  });

  List<Category> category;

  factory HomeCategoryClass.fromJson(Map<String, dynamic> json) =>
      HomeCategoryClass(
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
  });

  String categoryId;
  String categoryName;
  String categoryIcon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryIcon: json["category_icon"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_icon": categoryIcon,
      };
}
