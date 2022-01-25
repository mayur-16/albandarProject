import 'dart:async';
import 'dart:developer';

import 'package:albandar_project1/podos/receipt_details.dart';
import 'package:albandar_project1/services/apiservice.dart';
import 'package:flutter/material.dart';

class ReceiptTab extends StatelessWidget {
  final String accode;
  final Map<String,TextStyle> textstyles;

  const ReceiptTab({Key? key,required this.accode,required this.textstyles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<ReceiptDetails>(
        future: MyApi.getReceiptDetails(accode: accode),
        builder: (_,snapshot){

          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator(),);
          }else if(snapshot.connectionState==ConnectionState.done)
          {
            if(snapshot.hasData)
            {
              List<RecordsetofReceiptDetails> data=snapshot.data!.recordset;

              return Padding(
                padding: const EdgeInsets.all(9.0),
                child: ListView.separated(

                  itemCount: data.length,
                  itemBuilder: (_,index)
                  {
                    //converting datetime to dd-mm-yyyy value
                    String dateval= "${data[index].receiptDate.day}-${data[index].receiptDate.month}-${data[index].receiptDate.year}";

                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      tileColor: Colors.blueGrey.shade100,
                      leading: Text("$dateval",style: textstyles['textStyle4'],),
                      title: Text("${data[index].receiptNo}",style: textstyles['textStyle3'],),
                      subtitle: Text("${data[index].receiptdescription}",style: textstyles['textStyle2'],),
                      trailing: Text("${data[index].receiptAmount} BD",style: textstyles['textStyle1'],),);
                  },
                  separatorBuilder: (_,index) {
                    return SizedBox(height: 8);
                  },
                ),
              );
            }else if(snapshot.hasError)
            {
              log("${snapshot.error}",name: "error");
              if(snapshot.error==TimeoutException)
              {
                return Center(child: Text("Server down Please Try Again!"),);
              }
            }
          }
          return SizedBox();
        });
  }
}
