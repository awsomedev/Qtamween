// To parse this JSON data, do
//
//     final accoundDetailClass = accoundDetailClassFromJson(jsonString);

import 'dart:convert';

AccoundDetailClass accoundDetailClassFromJson(String str) =>
    AccoundDetailClass.fromJson(json.decode(str));

String accoundDetailClassToJson(AccoundDetailClass data) =>
    json.encode(data.toJson());

class AccoundDetailClass {
  AccoundDetailClass({
    this.status,
    this.message,
    this.accountDetails,
  });

  String status;
  String message;
  AccountDetails accountDetails;

  factory AccoundDetailClass.fromJson(Map<String, dynamic> json) =>
      AccoundDetailClass(
        status: json["status"],
        message: json["message"],
        accountDetails: AccountDetails.fromJson(json["account_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "account_details": accountDetails.toJson(),
      };
}

class AccountDetails {
  AccountDetails({
    this.customersMobile,
    this.customersEmail,
    this.customersName,
    this.customersId,
  });

  String customersMobile;
  String customersEmail;
  String customersName;
  String customersId;

  factory AccountDetails.fromJson(Map<String, dynamic> json) => AccountDetails(
        customersMobile: json["customers_mobile"],
        customersEmail: json["customers_email"],
        customersName: json["customers_name"],
        customersId: json["customers_id"],
      );

  Map<String, dynamic> toJson() => {
        "customers_mobile": customersMobile,
        "customers_email": customersEmail,
        "customers_name": customersName,
        "customers_id": customersId,
      };
}
