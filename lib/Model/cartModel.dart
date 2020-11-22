// To parse this JSON data, do
//
//     final myCartClass = myCartClassFromJson(jsonString);

import 'dart:convert';

MyCartClass myCartClassFromJson(String str) =>
    MyCartClass.fromJson(json.decode(str));

String myCartClassToJson(MyCartClass data) => json.encode(data.toJson());

class MyCartClass {
  MyCartClass({
    this.status,
    this.message,
    this.orders,
  });

  String status;
  String message;
  List<Order> orders;

  factory MyCartClass.fromJson(Map<String, dynamic> json) => MyCartClass(
        status: json["status"],
        message: json["message"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.ordersId,
    this.billNumber,
    this.date,
    this.total,
    this.status,
  });

  String ordersId;
  String billNumber;
  String date;
  String total;
  String status;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        ordersId: json["orders_id"],
        billNumber: json["bill_number"],
        date: json["date"],
        total: json["total"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "orders_id": ordersId,
        "bill_number": billNumber,
        "date": date,
        "total": total,
        "status": status,
      };
}

OrderSuccessClass orderSuccessClassFromJson(String str) =>
    OrderSuccessClass.fromJson(json.decode(str));

String orderSuccessClassToJson(OrderSuccessClass data) =>
    json.encode(data.toJson());

class OrderSuccessClass {
  OrderSuccessClass({
    this.order,
    this.status,
    this.message,
  });

  String order;
  String status;
  String message;

  factory OrderSuccessClass.fromJson(Map<String, dynamic> json) =>
      OrderSuccessClass(
        order: json["order"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "status": status,
        "message": message,
      };
}
