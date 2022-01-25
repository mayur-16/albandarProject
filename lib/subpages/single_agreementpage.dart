import 'package:albandar_project1/podos/allagreementdetails.dart';
import 'package:flutter/material.dart';

class SingleAgreementPage extends StatelessWidget {
  final RecordsetofAllAgreementdetails agreementdetails;
   SingleAgreementPage({Key? key,required this.agreementdetails}) : super(key: key);

  final TextStyle style1=TextStyle(color: Colors.black54,fontSize: 15);
  final TextStyle style2=TextStyle(color: Colors.black45,fontSize: 13);

  @override
  Widget build(BuildContext context) {
    String membertypevalue=agreementdetails.membtype=='F'?"Family":"Single";
    return Scaffold(
      appBar: AppBar(
        title: Text("Agreement Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Name :",style: style1),
                Text("${agreementdetails.name}",style: style2),
              ],
            ),
            Divider(thickness: 2,color: Colors.grey.shade300),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Agreement No :",style: style1),
                Text("${agreementdetails.agrNo}",style: style2),
              ],
            ),
            Divider(thickness: 2,color: Colors.grey.shade300),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Agreement duration :",style: style1),
                Text("${agreementdetails.fromdt} to ${agreementdetails.todt}",style: style2),
              ],
            ),
            Divider(thickness: 2,color: Colors.grey.shade300),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Description :",style: style1),
                Text("${agreementdetails.description}",style: style2),
              ],
            ),
            Divider(thickness: 2,color: Colors.grey.shade300),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Member type :",style: style1),
                Text("$membertypevalue",style: style2),
              ],
            ),
            Divider(thickness: 2,color: Colors.grey.shade300),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount :",style: style1),
                Text("${agreementdetails.amount} bd",style: style2),
              ],
            ),
            Divider(thickness: 2,color: Colors.grey.shade300),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount :",style: style1),
                Text("${agreementdetails.disamt} bd (${agreementdetails.disper} %)",style: style2),
              ],
            ),
            Divider(thickness: 2,color: Colors.grey.shade300),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Final Price :",style: style1),
                Text("${agreementdetails.value1} bd",style: style2),
              ],
            ),
            Divider(thickness: 2,color: Colors.grey.shade300),

          ],
        ),
      ),
    );
  }
}
