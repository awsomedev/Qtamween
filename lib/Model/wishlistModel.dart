// To parse this JSON data, do
//
//     final wishlistClass = wishlistClassFromJson(jsonString);

import 'dart:convert';

WishlistClass wishlistClassFromJson(String str) =>
    WishlistClass.fromJson(json.decode(str));

String wishlistClassToJson(WishlistClass data) => json.encode(data.toJson());

class WishlistClass {
  WishlistClass({
    this.status,
    this.message,
    this.wishlist,
  });

  String status;
  String message;
  List<Wishlist> wishlist;

  factory WishlistClass.fromJson(Map<String, dynamic> json) => WishlistClass(
        status: json["status"],
        message: json["message"],
        wishlist: List<Wishlist>.from(
            json["wishlist"].map((x) => Wishlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "wishlist": List<dynamic>.from(wishlist.map((x) => x.toJson())),
      };
}

class Wishlist {
  Wishlist({
    this.productId,
    this.productName,
    this.productImage,
    this.productAmount,
  });

  String productId;
  String productName;
  String productImage;
  String productAmount;

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        productAmount: json["product_amount"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
        "product_amount": productAmount,
      };
}
