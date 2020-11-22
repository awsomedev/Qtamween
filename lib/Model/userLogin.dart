// To parse this JSON data, do
//
//     final userLoginClass = userLoginClassFromJson(jsonString);

import 'dart:convert';

UserLoginClass userLoginClassFromJson(String str) =>
    UserLoginClass.fromJson(json.decode(str));

String userLoginClassToJson(UserLoginClass data) => json.encode(data.toJson());

class UserLoginClass {
  UserLoginClass({
    this.status,
    this.message,
    this.loginStatus,
    this.customerDetails,
  });

  String status;
  String message;
  String loginStatus;
  CustomerDetails customerDetails;

  factory UserLoginClass.fromJson(Map<String, dynamic> json) => UserLoginClass(
        status: json["status"],
        message: json["message"],
        loginStatus: json["login_status"],
        customerDetails: CustomerDetails.fromJson(json["customer_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "login_status": loginStatus,
        "customer_details": customerDetails.toJson(),
      };
}

class CustomerDetails {
  CustomerDetails({
    this.customersId,
    this.customersName,
  });

  String customersId;
  String customersName;

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        customersId: json["customers_id"],
        customersName: json["customers_name"],
      );

  Map<String, dynamic> toJson() => {
        "customers_id": customersId,
        "customers_name": customersName,
      };
}
