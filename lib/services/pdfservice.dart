
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

import '../podos/submembers.dart';

class MyPdf {

  final Document pdf = Document(); //Create new blank document;


  //Different textstyles for pdf
  TextStyle style1bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 23);
  TextStyle style2bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: PdfColors.grey600);
  TextStyle style2bold2 = TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: PdfColors.grey500);
  TextStyle style3bold = TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: PdfColors.white);

  TextStyle style1normal =
  TextStyle(fontWeight: FontWeight.normal, fontSize: 24);
  TextStyle style2normal =
  TextStyle(fontWeight: FontWeight.normal, fontSize: 22,color: PdfColors.grey700);
  TextStyle style3normal =
  TextStyle(fontWeight: FontWeight.normal, fontSize: 19);

  Future<Document> writeProfileReportPdf({required Map logindata, required List<RecordsetofSubmemberdetails> submemberdata}) async{

    //load profile image
    ByteData byteData=await rootBundle.load('assets/images/reportprofileimage.jpg');
    Uint8List imagebytes=byteData.buffer.asUint8List();
    //PdfImage profileimage=PdfImage.file(pdf.document, bytes: imagebytes);

    //get marital status
    String marriedStatusvalue=logindata['maritalstatus']=="M"?"Married":"Single";
    String resphonenumvalue=logindata['residencyphoneno'].toString().isEmpty?" --":logindata['residencyphoneno'];
    String officePhonenumvalue=logindata['officephoneno'].toString().isEmpty?" --":logindata['officephoneno'];


    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const EdgeInsets.all(20),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      build: (context) {
        return [
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            color: PdfColor.fromHex("0096c7"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(MemoryImage(imagebytes)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${logindata['title']} ${logindata['firstname']} ${logindata['surname']}",style: style3bold),
                    Text("${logindata['birthdate']}",style: style3bold),
                  ]
                ),
              ]
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Member no: ${logindata['memberno']}",style: style2bold),
              Text("Cpr no: ${logindata['cprno']}",style:  style2bold),
            ]
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ac code: ${logindata['accode']}",style: style2bold),
                Text("Marital status: $marriedStatusvalue",style: style2bold),
              ]
          ),

          Text("Residency phone no: $resphonenumvalue",style: style2bold),
          Text("Office phone no: $officePhonenumvalue",style: style2bold),

          Divider(height: 20,thickness: 10,color: PdfColors.grey200),

          Text("Address:",style: style2normal),
          Text("${logindata['address1']},\n${logindata['address2']},\n${logindata['address3']}",style: style2bold),

          Divider(height: 20,thickness: 10,color: PdfColors.grey200),

          if(submemberdata.isNotEmpty) Text("Dependents:",style: style2normal),
          SizedBox(height: 5),
          for(var element in submemberdata) Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${element.title} ${element.name} (${element.relation})",style: style2bold),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                Text("Agreement period:\n(${element.fromdt} - ${element.todt})\n[${element.description}]",style: style2bold),
              ]),
            Divider(thickness: 1,color: PdfColors.grey300),
            ]
          ),

        ];
      },
    ));

    return pdf;
  }

  Future<void> savePdf(
      {required String saveAs, required Document pdfdocument}) async {
    //Get Application directory containing path
    Directory directory = await getTemporaryDirectory();

    //get the path from directory to create new path
    File file = File("${directory.path}/$saveAs");

    //save the created pdf in the path
    file.writeAsBytesSync(await pdfdocument.save());
  }

  Future<void> downloadPdf(
      {required String saveAs, required Document pdfdocument}) async {
    //Get downloads directory containing path
    Directory? directory = await getExternalStorageDirectory();

    print(directory?.path);
    /*String finalPath=directory.path+Platform.pathSeparator+'Download';
    final savedDir=Directory(finalPath);*/


    //check whether there is downloads directory
   /* bool hasExisted=await savedDir.exists();
    if(!hasExisted)
      {
        savedDir.create();
      }*/


    //show downloading message
   // Fluttertoast.showToast(msg: "saved as ${savedDir.path}/$saveAs",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG);

   // print("saved as ${savedDir.path}/$saveAs");

   /* //get the path from directory to create new path
    File file = File("${savedDir.path}/$saveAs");

    //save the created pdf in the path
    file.writeAsBytesSync(await pdfdocument.save());*/
  }

  Future<File> getsavedPdfFile({required String savedAs}) async {
    //Get Application directory containing path
    Directory directory = await getTemporaryDirectory();

    //get the path from directory to create new path
    File file = File("${directory.path}/$savedAs");

    return file;
  }
}