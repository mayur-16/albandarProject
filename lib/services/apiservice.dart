import 'package:albandar_project1/podos/allagreementdetails.dart';
import 'package:albandar_project1/podos/allservices.dart';
import 'package:albandar_project1/podos/invoice_details.dart';
import 'package:albandar_project1/podos/receipt_details.dart';
import 'package:http/http.dart'as http;

import '../podos/submembers.dart';

class MyApi{

  // GET USER DETAILS FOR LOGIN
  static Future<http.Response> getUserdetailsforLogin({required String memberno})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5000/api/member/$memberno"))
        .timeout(const Duration(seconds: 10));

    return response;
  }

  // GET ALL SERVICES
  static Future<AllServices> getAllServices()async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5000/api/productservices/allservices"))
        .timeout(const Duration(seconds: 10));

    AllServices allServices=allServicesFromJson(response.body);

    return allServices;
  }

  // GET ALL AGGREEMENT DETAILS OF BOTH PRIMARY AND DEPENDENTS FROM MEMBERNO
  static Future<AllAgreementDetails> getAllAgreementDetails({required String memberno})async{

    http.Response response=await http.get(Uri
        .parse("http://15.185.46.105:5000/api/member/getAllAgreementDetails/$memberno"))
        .timeout(const Duration(seconds: 10));

    AllAgreementDetails allAgreementDetails=allAgreementDetailsFromJson(response.body);

    return allAgreementDetails;
  }

  // GET ALL AGGREEMENT DETAILS OF MEMBER FROM MEMBERNO
  static Future<http.Response> getAllAgreementDetailsofmember({required String memberno})async{

    http.Response response=await http.get(Uri
        .parse("http://15.185.46.105:5000/api/member/getAllAgreementDetailsofmember/$memberno"))
        .timeout(const Duration(seconds: 10));

    return response;
  }

  // GET ALLAGREEMENT DETAILS OF SUB MEMBER FROM PRIMARYNO
  static Future<AllAgreementDetailsofSubMember> getAllAgreementDetailsofsubmember({required String primarymember})async{

    http.Response response=await http.get(Uri
        .parse("http://15.185.46.105:5000/api/member/getAllAgreementDetailsofsubmembers/$primarymember"))
        .timeout(const Duration(seconds: 10));

    AllAgreementDetailsofSubMember allAgreementDetails=allAgreementDetailsofSubMemberFromJson(response.body);

    return allAgreementDetails;
  }

  // GET BOAT DETAILS FROM ACCODE
  static Future<http.Response> getBoatdetails({required String accode})async{

    http.Response response=await http.get(Uri.parse("http://15.185.46.105:5000/api/member/getboatdetails/$accode"))
        .timeout(const Duration(seconds: 10));

    return response;
  }

  // GET INVOICE DETAILS FROM ACCODE OF MEMBER
  static Future<InvoiceDetails> getInvoiceDetails({required String accode})async{
//http://15.185.46.105:5000/api/member/getInvoiceDetails/1188
    http.Response response=await http.get(Uri
        .parse("http://15.185.46.105:5000/api/member/getInvoiceDetails/$accode"))
        .timeout(const Duration(seconds: 10));

    InvoiceDetails invoiceDetails =invoiceDetailsFromJson(response.body);

    return invoiceDetails;
  }


  // GET RECEIPT DETAILS FROM ACCODE OF MEMBER
  static Future<ReceiptDetails> getReceiptDetails({required String accode})async{
//http://15.185.46.105:5000/api/member/getInvoiceDetails/1188
    http.Response response=await http.get(Uri
        .parse("http://15.185.46.105:5000/api/member/getReceiptDetails/$accode"))
        .timeout(const Duration(seconds: 10));

    ReceiptDetails receiptDetails =receiptDetailsFromJson(response.body);

    return receiptDetails;
  }

}