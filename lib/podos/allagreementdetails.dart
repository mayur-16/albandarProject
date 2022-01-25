// To parse this JSON data, do
//
//     final allAgreementDetails = allAgreementDetailsFromJson(jsonString);

import 'dart:convert';

AllAgreementDetails allAgreementDetailsFromJson(String str) => AllAgreementDetails.fromJson(json.decode(str));

String allAgreementDetailsToJson(AllAgreementDetails data) => json.encode(data.toJson());

class AllAgreementDetails {
  AllAgreementDetails({
    required this.recordset,
  });

  List<RecordsetofAllAgreementdetails> recordset;


  factory AllAgreementDetails.fromJson(Map<String, dynamic> json) => AllAgreementDetails(
    recordset: List<RecordsetofAllAgreementdetails>.from(json["recordset"].map((x) => RecordsetofAllAgreementdetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofAllAgreementdetails {
  RecordsetofAllAgreementdetails({
    required this.memberNo,
    required this.name,
    required this.membtype,
    required this.agrNo,
    required this.custName,
    required this.fromdt,
    required this.todt,
    required this.description,
    required this.membercode,
    required this.membername,
    required this.value1,
    required this.amount,
    required this.disper,
    required this.disamt,
    required this.vatcateory,
    required this.vat,
  });

  String memberNo;
  String name;
  String membtype;
  String agrNo;
  String custName;
  String fromdt;
  String todt;
  String description;
  String membercode;
  String membername;
  int value1;
  double amount;
  int disper;
  int disamt;
  String vatcateory;
  String vat;

  factory RecordsetofAllAgreementdetails.fromJson(Map<String, dynamic> json) => RecordsetofAllAgreementdetails(
    memberNo: json["MemberNo"],
    name: json["NAME"],
    membtype: json["MEMBTYPE"],
    agrNo: json["AGR_NO"],
    custName: json["CUST_NAME"],
    fromdt: json["FROMDT"].toString().substring(0,10),
    todt: json["TODT"].toString().substring(0,10),
    description: json["DESCRIPTION"],
    membercode: json["MEMBERCODE"],
    membername: json["MEMBERNAME"],
    value1: json["VALUE1"],
    amount: json["AMOUNT"].toDouble(),
    disper: json["DISPER"],
    disamt: json["DISAMT"],
    vatcateory: json["VATCATEORY"],
    vat: json["VAT"],
  );

  Map<String, dynamic> toJson() => {
    "MemberNo": memberNo,
    "NAME": name,
    "MEMBTYPE": membtype,
    "AGR_NO": agrNo,
    "CUST_NAME": custName,
    "FROMDT": fromdt,
    "TODT": todt,
    "DESCRIPTION": description,
    "MEMBERCODE": membercode,
    "MEMBERNAME": membername,
    "VALUE1": value1,
    "AMOUNT": amount,
    "DISPER": disper,
    "DISAMT": disamt,
    "VATCATEORY": vatcateory,
    "VAT": vat,
  };
}

