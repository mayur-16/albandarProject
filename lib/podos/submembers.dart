// To parse this JSON data, do
//
//     final subMemberDetails = subMemberDetailsFromJson(jsonString);

import 'dart:convert';

SubMemberDetails subMemberDetailsFromJson(String str) => SubMemberDetails.fromJson(json.decode(str));

String subMemberDetailsToJson(SubMemberDetails data) => json.encode(data.toJson());

class SubMemberDetails {
  SubMemberDetails({
    required this.recordset,
  });


  List<RecordsetofSubmemberdetails> recordset;

  factory SubMemberDetails.fromJson(Map<String, dynamic> json) => SubMemberDetails(
    recordset: List<RecordsetofSubmemberdetails>.from(json["recordset"].map((x) => RecordsetofSubmemberdetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofSubmemberdetails {
  RecordsetofSubmemberdetails({
     this.title,
     this.name,
     this.birthdt,
     this.teloff,
     this.email,
     this.relation,
  });

  String? title;
  String? name;
  String? birthdt;
  String? teloff;
  String? email;
  String? relation;

  factory RecordsetofSubmemberdetails.fromJson(Map<String, dynamic> json) => RecordsetofSubmemberdetails(
    title: json["TITLE"],
    name: json["NAME"],
    birthdt: json["BIRTHDT"],
    teloff: json["TELOFF"],
    email: json["Email"],
    relation: json["RELATION"],
  );

  Map<String, dynamic> toJson() => {
    "TITLE": title,
    "NAME": name,
    "BIRTHDT": birthdt,
    "TELOFF": teloff,
    "Email": email,
    "RELATION": relation,
  };
}

