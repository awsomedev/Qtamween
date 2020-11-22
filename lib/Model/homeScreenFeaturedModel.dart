// To parse this JSON data, do
//
//     final featuredProductClass = featuredProductClassFromJson(jsonString);

import 'dart:convert';

FeaturedProductClass featuredProductClassFromJson(String str) =>
    FeaturedProductClass.fromJson(json.decode(str));

String featuredProductClassToJson(FeaturedProductClass data) =>
    json.encode(data.toJson());

class FeaturedProductClass {
  FeaturedProductClass({
    this.featuredProducts,
  });

  List<FeaturedProduct> featuredProducts;

  factory FeaturedProductClass.fromJson(Map<String, dynamic> json) =>
      FeaturedProductClass(
        featuredProducts: List<FeaturedProduct>.from(
            json["featured_products"].map((x) => FeaturedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "featured_products":
            List<dynamic>.from(featuredProducts.map((x) => x.toJson())),
      };
}

class FeaturedProduct {
  FeaturedProduct({
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

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) =>
      FeaturedProduct(
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
