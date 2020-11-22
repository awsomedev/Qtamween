// To parse this JSON data, do
//
//     final addressDetailClass = addressDetailClassFromJson(jsonString);

import 'dart:convert';

AddressDetailClass addressDetailClassFromJson(String str) =>
    AddressDetailClass.fromJson(json.decode(str));

String addressDetailClassToJson(AddressDetailClass data) =>
    json.encode(data.toJson());

class AddressDetailClass {
  AddressDetailClass({
    this.status,
    this.message,
    this.editAddress,
    this.areaData,
    this.addressType,
  });

  String status;
  String message;
  EditAddress editAddress;
  List<AreaDatum> areaData;
  List<AddressType> addressType;

  factory AddressDetailClass.fromJson(Map<String, dynamic> json) =>
      AddressDetailClass(
        status: json["status"],
        message: json["message"],
        editAddress: EditAddress.fromJson(json["edit_address"]),
        areaData: List<AreaDatum>.from(
            json["area_data"].map((x) => AreaDatum.fromJson(x))),
        addressType: List<AddressType>.from(
            json["address_type"].map((x) => AddressType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "edit_address": editAddress.toJson(),
        "area_data": List<dynamic>.from(areaData.map((x) => x.toJson())),
        "address_type": List<dynamic>.from(addressType.map((x) => x.toJson())),
      };
}

class AddressType {
  AddressType({
    this.addressTypeId,
    this.addressType,
  });

  String addressTypeId;
  String addressType;

  factory AddressType.fromJson(Map<String, dynamic> json) => AddressType(
        addressTypeId: json["address_type_id"],
        addressType: json["address_type"],
      );

  Map<String, dynamic> toJson() => {
        "address_type_id": addressTypeId,
        "address_type": addressType,
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

class EditAddress {
  EditAddress({
    this.areaId,
    this.zone,
    this.street,
    this.building,
    this.address,
    this.location,
    this.latitude,
    this.longitude,
    this.addressTypeId,
  });

  String areaId;
  String zone;
  String street;
  String building;
  String address;
  String location;
  String latitude;
  String longitude;
  String addressTypeId;

  factory EditAddress.fromJson(Map<String, dynamic> json) => EditAddress(
        areaId: json["area_id"],
        zone: json["zone"],
        street: json["street"],
        building: json["building"],
        address: json["address"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        addressTypeId: json["address_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "area_id": areaId,
        "zone": zone,
        "street": street,
        "building": building,
        "address": address,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
        "address_type_id": addressTypeId,
      };
}
