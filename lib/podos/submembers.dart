// To parse this JSON data, do
//
//     final allAgreementDetailsofSubMember = allAgreementDetailsofSubMemberFromJson(jsonString);

import 'dart:convert';

AllAgreementDetailsofSubMember allAgreementDetailsofSubMemberFromJson(String str) => AllAgreementDetailsofSubMember.fromJson(json.decode(str));

String allAgreementDetailsofSubMemberToJson(AllAgreementDetailsofSubMember data) => json.encode(data.toJson());

class AllAgreementDetailsofSubMember {
  AllAgreementDetailsofSubMember({
    required this.recordset,
  });

  List<RecordsetofSubmemberdetails> recordset;

  factory AllAgreementDetailsofSubMember.fromJson(Map<String, dynamic> json) => AllAgreementDetailsofSubMember(
    recordset: List<RecordsetofSubmemberdetails>.from(json["recordset"].map((x) => RecordsetofSubmemberdetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofSubmemberdetails {
  RecordsetofSubmemberdetails({
    required this.memberNo,
    required this.primarymember,
    required this.title,
    required this.name,
    required this.surname,
    required this.membtype,
    required this.birthdt,
    required this.marital,
    required this.relation,
    required this.add1,
    required this.add2,
    required this.add3,
    required this.nation,
    required this.telres,
    required this.teloff,
    required this.email,
    required this.position,
    required this.cprNo,
    required this.accode,
    required this.custName,
    required this.agrNo,
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
  String primarymember;
  String title;
  String name;
  String surname;
  String membtype;
  String birthdt;
  String marital;
  String relation;
  String add1;
  String add2;
  String add3;
  String nation;
  String telres;
  String teloff;
  String email;
  String position;
  String cprNo;
  String accode;
  String custName;
  String agrNo;
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

  factory RecordsetofSubmemberdetails.fromJson(Map<String, dynamic> json) => RecordsetofSubmemberdetails(
    memberNo: json["MemberNo"],
    primarymember: json["PRIMARYMEMBER"],
    title: json["TITLE"],
    name: json["NAME"],
    surname: json["SURNAME"],
    membtype: json["MEMBTYPE"],
    birthdt: json["BIRTHDT"],
    marital: json["MARITAL"],
    relation: json["RELATION"],
    add1: json["ADD1"],
    add2: json["ADD2"],
    add3: json["ADD3"],
    nation: json["NATION"],
    telres: json["TELRES"],
    teloff: json["TELOFF"],
    email: json["Email"],
    position: json["POSITION"],
    cprNo: json["CPRNo"],
    accode: json["ACCODE"],
    custName: json["CUST_NAME"],
    agrNo: json["AGR_NO"],
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
    "PRIMARYMEMBER": primarymember,
    "TITLE": title,
    "NAME": name,
    "SURNAME": surname,
    "MEMBTYPE": membtype,
    "BIRTHDT": birthdt,
    "MARITAL": marital,
    "RELATION": relation,
    "ADD1": add1,
    "ADD2": add2,
    "ADD3": add3,
    "NATION": nation,
    "TELRES": telres,
    "TELOFF": teloff,
    "Email": email,
    "POSITION": position,
    "CPRNo": cprNo,
    "ACCODE": accode,
    "CUST_NAME": custName,
    "AGR_NO": agrNo,
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

