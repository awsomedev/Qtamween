// To parse this JSON data, do
//
//     final featuredProductDetailClass = featuredProductDetailClassFromJson(jsonString);

import 'dart:convert';

FeaturedProductDetailClass featuredProductDetailClassFromJson(String str) =>
    FeaturedProductDetailClass.fromJson(json.decode(str));

String featuredProductDetailClassToJson(FeaturedProductDetailClass data) =>
    json.encode(data.toJson());

class FeaturedProductDetailClass {
  FeaturedProductDetailClass({
    this.products,
  });

  List<Product> products;

  factory FeaturedProductDetailClass.fromJson(Map<String, dynamic> json) =>
      FeaturedProductDetailClass(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
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
