// To parse this JSON data, do
//
//     final invoiceDetails = invoiceDetailsFromJson(jsonString);

import 'dart:convert';

ReceiptDetails receiptDetailsFromJson(String str) => ReceiptDetails.fromJson(json.decode(str));

String receiptDetailsToJson(ReceiptDetails data) => json.encode(data.toJson());

class ReceiptDetails {
  ReceiptDetails({
    required this.recordset,
  });

  List<RecordsetofReceiptDetails> recordset;

  factory ReceiptDetails.fromJson(Map<String, dynamic> json) => ReceiptDetails(
    recordset: List<RecordsetofReceiptDetails>.from(json["recordset"].map((x) => RecordsetofReceiptDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
  };
}


class RecordsetofReceiptDetails {
  RecordsetofReceiptDetails({
    required this.receiptNo,
    required this.receiptDate,
    required this.receiptAmount,
    required this.receiptdescription,
  });

  String receiptNo;
  DateTime receiptDate;
  int receiptAmount;
  String receiptdescription;

  factory RecordsetofReceiptDetails.fromJson(Map<String, dynamic> json) => RecordsetofReceiptDetails(
    receiptNo: json["REFNO"],
    receiptDate: DateTime.parse (json["REFDT"]),
    receiptAmount: json["REFAMOUNT"],
    receiptdescription: json["DESCRIPTION"],
  );

  Map<String, dynamic> toJson() => {
    "INV_NO": receiptNo,
    "INV_DATE": receiptDate.toIso8601String(),
    "INV_AMOUNT": receiptAmount,
    "DESCRIPTION":receiptdescription,
  };
}
