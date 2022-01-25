// To parse this JSON data, do
//
//     final invoiceDetails = invoiceDetailsFromJson(jsonString);

import 'dart:convert';

InvoiceDetails invoiceDetailsFromJson(String str) => InvoiceDetails.fromJson(json.decode(str));

String invoiceDetailsToJson(InvoiceDetails data) => json.encode(data.toJson());

class InvoiceDetails {
  InvoiceDetails({
    required this.recordset,
  });

  List<RecordsetofInvoiceDetails> recordset;

  factory InvoiceDetails.fromJson(Map<String, dynamic> json) => InvoiceDetails(
    recordset: List<RecordsetofInvoiceDetails>.from(json["recordset"].map((x) => RecordsetofInvoiceDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofInvoiceDetails {
  RecordsetofInvoiceDetails({
    required this.invNo,
    required this.invDate,
    required this.invAmount,
    required this.invdescription,
  });

  String invNo;
  DateTime invDate;
  int invAmount;
  String invdescription;

  factory RecordsetofInvoiceDetails.fromJson(Map<String, dynamic> json) => RecordsetofInvoiceDetails(
    invNo: json["INV_NO"],
    invDate: DateTime.parse (json["INV_DATE"]),
    invAmount: json["INV_AMOUNT"],
    invdescription: json["DESCRIPTION"],
  );

  Map<String, dynamic> toJson() => {
    "INV_NO": invNo,
    "INV_DATE": invDate.toIso8601String(),
    "INV_AMOUNT": invAmount,
    "DESCRIPTION":invdescription,
  };
}
