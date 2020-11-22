// To parse this JSON data, do
//
//     final productDetailsClass = productDetailsClassFromJson(jsonString);

import 'dart:convert';

ProductDetailsClass productDetailsClassFromJson(String str) =>
    ProductDetailsClass.fromJson(json.decode(str));

String productDetailsClassToJson(ProductDetailsClass data) =>
    json.encode(data.toJson());

class ProductDetailsClass {
  ProductDetailsClass({
    this.status,
    this.message,
    this.productDetails,
    this.productImages,
    this.relatedProducts,
    this.groupType,
    this.productGroups,
  });

  String status;
  String message;
  ProductDetails productDetails;
  List<ProductImage> productImages;
  List<RelatedProduct> relatedProducts;
  String groupType;
  List<ProductGroup> productGroups;

  factory ProductDetailsClass.fromJson(Map<String, dynamic> json) =>
      ProductDetailsClass(
        status: json["status"],
        message: json["message"],
        productDetails: ProductDetails.fromJson(json["product_details"]),
        productImages: List<ProductImage>.from(
            json["product_images"].map((x) => ProductImage.fromJson(x))),
        relatedProducts: List<RelatedProduct>.from(
            json["related_products"].map((x) => RelatedProduct.fromJson(x))),
        groupType: json["group_type"],
        productGroups: List<ProductGroup>.from(
            json["product_groups"].map((x) => ProductGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "product_details": productDetails.toJson(),
        "product_images":
            List<dynamic>.from(productImages.map((x) => x.toJson())),
        "related_products":
            List<dynamic>.from(relatedProducts.map((x) => x.toJson())),
        "group_type": groupType,
        "product_groups":
            List<dynamic>.from(productGroups.map((x) => x.toJson())),
      };
}

class ProductDetails {
  ProductDetails({
    this.productId,
    this.productName,
    this.productDescription,
    this.productPrice,
    this.productOfferPrice,
    this.productStock,
    this.productMinStock,
    this.productMaxStock,
    this.icon,
    this.productTypeQuantity,
    this.productRating,
    this.wishlistStatus,
  });

  String productId;
  String productName;
  String productDescription;
  String productPrice;
  String productOfferPrice;
  String productStock;
  String productMinStock;
  String productMaxStock;
  String icon;
  String productTypeQuantity;
  String productRating;
  int wishlistStatus;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        productId: json["product_id"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productPrice: json["product_price"],
        productOfferPrice: json["product_offer_price"],
        productStock: json["product_stock"],
        productMinStock: json["product_min_stock"],
        productMaxStock: json["product_max_stock"],
        icon: json["icon"],
        productTypeQuantity: json["product_type_quantity"],
        productRating: json["product_rating"],
        wishlistStatus: json["wishlist_status"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_description": productDescription,
        "product_price": productPrice,
        "product_offer_price": productOfferPrice,
        "product_stock": productStock,
        "product_min_stock": productMinStock,
        "product_max_stock": productMaxStock,
        "icon": icon,
        "product_type_quantity": productTypeQuantity,
        "product_rating": productRating,
        "wishlist_status": wishlistStatus,
      };
}

class ProductGroup {
  ProductGroup({
    this.productId,
    this.productQuantity,
  });

  String productId;
  String productQuantity;

  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
        productId: json["product_id"],
        productQuantity: json["product_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_quantity": productQuantity,
      };
}

class ProductImage {
  ProductImage({
    this.productImages,
  });

  String productImages;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        productImages: json["product_images"],
      );

  Map<String, dynamic> toJson() => {
        "product_images": productImages,
      };
}

class RelatedProduct {
  RelatedProduct({
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

  factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
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
