// To parse this JSON data, do
//
//     final orderDetailClass = orderDetailClassFromJson(jsonString);

import 'dart:convert';

OrderDetailClass orderDetailClassFromJson(String str) =>
    OrderDetailClass.fromJson(json.decode(str));

String orderDetailClassToJson(OrderDetailClass data) =>
    json.encode(data.toJson());

class OrderDetailClass {
  OrderDetailClass({
    this.status,
    this.message,
    this.orderItems,
    this.orderDetails,
  });

  String status;
  String message;
  List<OrderItem> orderItems;
  OrderDetails orderDetails;

  factory OrderDetailClass.fromJson(Map<String, dynamic> json) =>
      OrderDetailClass(
        status: json["status"],
        message: json["message"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        orderDetails: OrderDetails.fromJson(json["order_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "order_details": orderDetails.toJson(),
      };
}

class OrderDetails {
  OrderDetails({
    this.ordersId,
    this.billNumber,
    this.date,
    this.subTotal,
    this.deliveryCharge,
    this.grandTotal,
    this.status,
  });

  String ordersId;
  String billNumber;
  String date;
  String subTotal;
  String deliveryCharge;
  String grandTotal;
  String status;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        ordersId: json["orders_id"],
        billNumber: json["bill_number"],
        date: json["date"],
        subTotal: json["sub_total"],
        deliveryCharge: json["delivery_charge"],
        grandTotal: json["grand_total"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "orders_id": ordersId,
        "bill_number": billNumber,
        "date": date,
        "sub_total": subTotal,
        "delivery_charge": deliveryCharge,
        "grand_total": grandTotal,
        "status": status,
      };
}

class OrderItem {
  OrderItem({
    this.productId,
    this.productName,
    this.productPrice,
    this.quantity,
    this.productImage,
  });

  String productId;
  String productName;
  String productPrice;
  String quantity;
  String productImage;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        quantity: json["quantity"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_price": productPrice,
        "quantity": quantity,
        "product_image": productImage,
      };
}
