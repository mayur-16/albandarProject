
import 'package:albandar_project1/tabs/payment_tab.dart';
import 'package:albandar_project1/tabs/receipt_tab.dart';
import 'package:flutter/material.dart';

class PaymentsAndBills extends StatelessWidget {
  final String accode;
   PaymentsAndBills({Key? key,required this.accode}) : super(key: key);
  final TextStyle textStyle1=TextStyle(fontSize: 14,color: Colors.black54,fontWeight: FontWeight.bold);
  final TextStyle textStyle2=TextStyle(fontSize: 12,color: Colors.black45);
  final TextStyle textStyle3=TextStyle(fontSize: 15,color: Colors.deepPurple.shade400,fontWeight: FontWeight.bold);
  final TextStyle textStyle4=TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment & Bills"),
          bottom: TabBar(
              tabs: [
                Tab(text: "invoices", icon: Icon(Icons.payments),),
                Tab(text: "receipts", icon: Icon(Icons.receipt),)
              ],
          ),
          centerTitle: true,
        ),
       body: TabBarView(
           children:[
             PaymentTab(accode: accode,
               textstyles: {"textStyle1":textStyle1,"textStyle2":textStyle2,"textStyle3":textStyle3,"textStyle4":textStyle4},),

             ReceiptTab(accode: accode,
               textstyles: {"textStyle1":textStyle1,"textStyle2":textStyle2,"textStyle3":textStyle3,"textStyle4":textStyle4},),
           ] ),

      ),
    );
  }


}
