// To parse this JSON data, do
//
//     final confirmOrderClass = confirmOrderClassFromJson(jsonString);

import 'dart:convert';

ConfirmOrderClass confirmOrderClassFromJson(String str) =>
    ConfirmOrderClass.fromJson(json.decode(str));

String confirmOrderClassToJson(ConfirmOrderClass data) =>
    json.encode(data.toJson());

class ConfirmOrderClass {
  ConfirmOrderClass({
    this.status,
    this.message,
    this.addressStatus,
    this.timesloat,
    this.address,
    this.amountArray,
    this.areaData,
    this.checkoutStatus,
  });

  String status;
  String message;
  String addressStatus;
  List<Timesloat> timesloat;
  Address address;
  AmountArray amountArray;
  List<AreaDatum> areaData;
  String checkoutStatus;

  factory ConfirmOrderClass.fromJson(Map<String, dynamic> json) =>
      ConfirmOrderClass(
        status: json["status"],
        message: json["message"],
        addressStatus: json["address_status"],
        timesloat: List<Timesloat>.from(
            json["timesloat"].map((x) => Timesloat.fromJson(x))),
        address: Address.fromJson(json["address"]),
        amountArray: AmountArray.fromJson(json["amount_array"]),
        areaData: List<AreaDatum>.from(
            json["area_data"].map((x) => AreaDatum.fromJson(x))),
        checkoutStatus: json["checkout_status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "address_status": addressStatus,
        "timesloat": List<dynamic>.from(timesloat.map((x) => x.toJson())),
        "address": address.toJson(),
        "amount_array": amountArray.toJson(),
        "area_data": List<dynamic>.from(areaData.map((x) => x.toJson())),
        "checkout_status": checkoutStatus,
      };
}

class Address {
  Address({
    this.customersAddressId,
    this.zone,
    this.street,
    this.building,
    this.areaName,
    this.address,
    this.location,
    this.latitude,
    this.longitude,
    this.distance,
  });

  String customersAddressId;
  String zone;
  String street;
  String building;
  String areaName;
  String address;
  String location;
  String latitude;
  String longitude;
  String distance;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        customersAddressId: json["customers_address_id"],
        zone: json["zone"],
        street: json["street"],
        building: json["building"],
        areaName: json["area_name"],
        address: json["address"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "customers_address_id": customersAddressId,
        "zone": zone,
        "street": street,
        "building": building,
        "area_name": areaName,
        "address": address,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "distance": distance,
      };
}

class AmountArray {
  AmountArray({
    this.billAmount,
    this.deliveryCharge,
    this.totalAmount,
  });

  String billAmount;
  String deliveryCharge;
  String totalAmount;

  factory AmountArray.fromJson(Map<String, dynamic> json) => AmountArray(
        billAmount: json["bill_amount"],
        deliveryCharge: json["delivery_charge"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "bill_amount": billAmount,
        "delivery_charge": deliveryCharge,
        "total_amount": totalAmount,
      };
}

class AreaDatum {
  AreaDatum({
    this.areaId,
    this.areaName,
  });

  String areaId;
  String areaName;

  factory AreaDatum.fromJson(Map<String, dynamic> json) => AreaDatum(
        areaId: json["area_id"],
        areaName: json["area_name"],
      );

  Map<String, dynamic> toJson() => {
        "area_id": areaId,
        "area_name": areaName,
      };
}

class Timesloat {
  Timesloat({
    this.timeSlotId,
    this.timeSloat,
  });

  String timeSlotId;
  String timeSloat;

  factory Timesloat.fromJson(Map<String, dynamic> json) => Timesloat(
        timeSlotId: json["time_slot_id"],
        timeSloat: json["time_sloat"],
      );

  Map<String, dynamic> toJson() => {
        "time_slot_id": timeSlotId,
        "time_sloat": timeSloat,
      };
}
