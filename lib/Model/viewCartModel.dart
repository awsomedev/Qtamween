// To parse this JSON data, do
//
//     final viewCartClass = viewCartClassFromJson(jsonString);

import 'dart:convert';

ViewCartClass viewCartClassFromJson(String str) =>
    ViewCartClass.fromJson(json.decode(str));

String viewCartClassToJson(ViewCartClass data) => json.encode(data.toJson());

class ViewCartClass {
  ViewCartClass({
    this.status,
    this.message,
    this.cartProducts,
    this.amountDetails,
    this.checkoutStatus,
    this.addressStatus,
  });

  String status;
  String message;
  List<CartProduct> cartProducts;
  AmountDetails amountDetails;
  String checkoutStatus;
  String addressStatus;

  factory ViewCartClass.fromJson(Map<String, dynamic> json) => ViewCartClass(
        status: json["status"],
        message: json["message"],
        cartProducts: List<CartProduct>.from(
            json["cart_products"].map((x) => CartProduct.fromJson(x))),
        amountDetails: AmountDetails.fromJson(json["amount_details"]),
        checkoutStatus: json["checkout_status"],
        addressStatus: json["address_status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "cart_products":
            List<dynamic>.from(cartProducts.map((x) => x.toJson())),
        "amount_details": amountDetails.toJson(),
        "checkout_status": checkoutStatus,
        "address_status": addressStatus,
      };
}

class AmountDetails {
  AmountDetails({
    this.billAmount,
    this.deliveryCharge,
    this.grandTotal,
  });

  String billAmount;
  String deliveryCharge;
  String grandTotal;

  factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
        billAmount: json["bill_amount"],
        deliveryCharge: json["delivery_charge"],
        grandTotal: json["grand_total"],
      );

  Map<String, dynamic> toJson() => {
        "bill_amount": billAmount,
        "delivery_charge": deliveryCharge,
        "grand_total": grandTotal,
      };
}

class CartProduct {
  CartProduct({
    this.productId,
    this.productName,
    this.productImage,
    this.productAmount,
    this.quantity,
    this.outOfStockStatus,
  });

  String productId;
  String productName;
  String productImage;
  String productAmount;
  String quantity;
  String outOfStockStatus;

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        productAmount: json["product_amount"],
        quantity: json["quantity"],
        outOfStockStatus: json["out_of_stock_status"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
        "product_amount": productAmount,
        "quantity": quantity,
        "out_of_stock_status": outOfStockStatus,
      };
}
