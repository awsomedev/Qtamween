// To parse this JSON data, do
//
//     final categoryDetailsClass = categoryDetailsClassFromJson(jsonString);

import 'dart:convert';

CategoryDetailsClass categoryDetailsClassFromJson(String str) =>
    CategoryDetailsClass.fromJson(json.decode(str));

String categoryDetailsClassToJson(CategoryDetailsClass data) =>
    json.encode(data.toJson());

class CategoryDetailsClass {
  CategoryDetailsClass({
    this.status,
    this.message,
    this.products,
    this.subCategory,
  });

  String status;
  String message;
  List<Product> products;
  List<SubCategory> subCategory;

  factory CategoryDetailsClass.fromJson(Map<String, dynamic> json) =>
      CategoryDetailsClass(
        status: json["status"],
        message: json["message"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        subCategory: List<SubCategory>.from(
            json["sub_category"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.wishlistStatus,
    this.productId,
    this.countryIcon,
    this.productName,
    this.productPrice,
    this.productQuantity,
    this.productImage,
  });

  int wishlistStatus;
  String productId;
  String countryIcon;
  String productName;
  String productPrice;
  String productQuantity;
  String productImage;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        wishlistStatus: json["wishlist_status"],
        productId: json["product_id"],
        countryIcon: json["country_icon"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productQuantity: json["product_quantity"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "wishlist_status": wishlistStatus,
        "product_id": productId,
        "country_icon": countryIcon,
        "product_name": productName,
        "product_price": productPrice,
        "product_quantity": productQuantity,
        "product_image": productImage,
      };
}

class SubCategory {
  SubCategory({
    this.subCategoryId,
    this.subCategory,
  });

  String subCategoryId;
  String subCategory;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        subCategoryId: json["sub_category_id"],
        subCategory: json["sub_category"],
      );

  Map<String, dynamic> toJson() => {
        "sub_category_id": subCategoryId,
        "sub_category": subCategory,
      };
}
