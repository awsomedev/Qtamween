// To parse this JSON data, do
//
//     final offerProductClass = offerProductClassFromJson(jsonString);

import 'dart:convert';

OfferProductClass offerProductClassFromJson(String str) =>
    OfferProductClass.fromJson(json.decode(str));

String offerProductClassToJson(OfferProductClass data) =>
    json.encode(data.toJson());

class OfferProductClass {
  OfferProductClass({
    this.offerProducts,
  });

  List<OfferProduct> offerProducts;

  factory OfferProductClass.fromJson(Map<String, dynamic> json) =>
      OfferProductClass(
        offerProducts: List<OfferProduct>.from(
            json["offer_products"].map((x) => OfferProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offer_products":
            List<dynamic>.from(offerProducts.map((x) => x.toJson())),
      };
}

class OfferProduct {
  OfferProduct({
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

  factory OfferProduct.fromJson(Map<String, dynamic> json) => OfferProduct(
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
