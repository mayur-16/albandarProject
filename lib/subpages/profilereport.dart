import 'package:albandar_project1/subpages/allagreementpage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:pdf/widgets.dart'  as pw;

import '../podos/submembers.dart';
import '../services/apiservice.dart';
import '../services/pdfservice.dart';

class ProfileReportPage extends StatefulWidget {
  final Map logindata;

  const ProfileReportPage({Key? key,required this.logindata}) : super(key: key);

  @override
  _ProfileReportPageState createState() => _ProfileReportPageState();
}

class _ProfileReportPageState extends State<ProfileReportPage> {
  pw.Document pdfFile=pw.Document();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Member Details"),
        centerTitle: true,
      /*  actions: [
          IconButton(onPressed: (){
            MyPdf().downloadPdf(saveAs: "profilereport.pdf", pdfdocument: pdfFile);

          }, icon: const Icon(Icons.save_alt)),
          IconButton(onPressed: (){
          },icon: const Icon(Icons.share),)
        ],*/
      ),
      body: FutureBuilder<AllAgreementDetailsofSubMember>(
          future: MyApi.getAllAgreementDetailsofsubmember(
              primarymember: widget.logindata['memberno']),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {

                  List<RecordsetofSubmemberdetails> listofdata =
                      snapshot.data!.recordset;

                 return FutureBuilder<PDFDocument>(
                      future: createandSavePdf(submembersDetails: listofdata),
                      builder: (_,snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting)
                        {
                          return const Center(child: Text("Please wait..."));
                        }
                        else if(snapshot.connectionState==ConnectionState.done)
                        {
                          if(snapshot.hasData)
                          {
                            return PDFViewer(document: snapshot.data!);
                          }
                        }

                        return const SizedBox();
                      });

              } else if (snapshot.hasError) {

                if (snapshot.error == TimeoutException) {
                  return const Text(
                      "Server is down! please try again!");
                } else {
                  return const Text(
                      "Some issues! please contact your manager.");
                }
              }
            } else {
              return const Center(child: Text("Getting data. Please wait!"));
            }
            return const SizedBox();
          }),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Color(0xff0077b6),elevation: 6),
              onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AllAgreementPage(logindata: widget.logindata,)));
              },
              child: Text("Show All Agreement Details")),
        ),
      ),
    );
  }

  Future<PDFDocument> createandSavePdf({required List<RecordsetofSubmemberdetails> submembersDetails})async{

    //Create save and display pdf
    String pdfName = 'profilereport.pdf';
    pw.Document pdf=await MyPdf().writeProfileReportPdf(logindata: widget.logindata,submemberdata: submembersDetails);
    await MyPdf().savePdf(saveAs: pdfName,pdfdocument: pdf);

    File savedFile=await MyPdf().getsavedPdfFile(savedAs: pdfName);

    PDFDocument savedDoc=await PDFDocument.fromFile(savedFile);
    return savedDoc;

  }
}
