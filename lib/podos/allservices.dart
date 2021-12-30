// To parse this JSON data, do
//
//     final allServices = allServicesFromJson(jsonString);

import 'dart:convert';

AllServices allServicesFromJson(String str) => AllServices.fromJson(json.decode(str));

String allServicesToJson(AllServices data) => json.encode(data.toJson());

class AllServices {
  AllServices({
    required this.recordset,
  });

  List<RecordsetofALlServices> recordset;

  factory AllServices.fromJson(Map<String, dynamic> json) => AllServices(
    recordset: List<RecordsetofALlServices>.from(json["recordset"].map((x) => RecordsetofALlServices.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}

class RecordsetofALlServices {
  RecordsetofALlServices({
    required this.serviceid,
    required this.serviceDescription,
    required this.memberPrice,
  });

  int serviceid;
  String serviceDescription;
  int memberPrice;

  factory RecordsetofALlServices.fromJson(Map<String, dynamic> json) => RecordsetofALlServices(
    serviceid: json["serviceid"],
    serviceDescription: json["ServiceDescription"],
    memberPrice: json["MemberPrice"],
  );

  Map<String, dynamic> toJson() => {
    "serviceid": serviceid,
    "ServiceDescription": serviceDescription,
    "MemberPrice": memberPrice,
  };
}
