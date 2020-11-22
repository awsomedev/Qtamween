// To parse this JSON data, do
//
//     final viewAddressClass = viewAddressClassFromJson(jsonString);

import 'dart:convert';

ViewAddressClass viewAddressClassFromJson(String str) =>
    ViewAddressClass.fromJson(json.decode(str));

String viewAddressClassToJson(ViewAddressClass data) =>
    json.encode(data.toJson());

class ViewAddressClass {
  ViewAddressClass({
    this.status,
    this.message,
    this.customerAddress,
  });

  String status;
  String message;
  List<CustomerAddress> customerAddress;

  factory ViewAddressClass.fromJson(Map<String, dynamic> json) =>
      ViewAddressClass(
        status: json["status"],
        message: json["message"],
        customerAddress: List<CustomerAddress>.from(
            json["customer_address"].map((x) => CustomerAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "customer_address":
            List<dynamic>.from(customerAddress.map((x) => x.toJson())),
      };
}

class CustomerAddress {
  CustomerAddress({
    this.customersAddressId,
    this.defaultAddress,
    this.areaName,
    this.zone,
    this.street,
    this.building,
    this.address,
    this.location,
    this.latitude,
    this.longitude,
    this.addressType,
  });

  String customersAddressId;
  String defaultAddress;
  String areaName;
  String zone;
  String street;
  String building;
  String address;
  String location;
  String latitude;
  String longitude;
  String addressType;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) =>
      CustomerAddress(
        customersAddressId: json["customers_address_id"],
        defaultAddress: json["default_address"],
        areaName: json["area_name"],
        zone: json["zone"],
        street: json["street"],
        building: json["building"],
        address: json["address"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        addressType: json["address_type"],
      );

  Map<String, dynamic> toJson() => {
        "customers_address_id": customersAddressId,
        "default_address": defaultAddress,
        "area_name": areaName,
        "zone": zone,
        "street": street,
        "building": building,
        "address": address,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "address_type": addressType,
      };
}
