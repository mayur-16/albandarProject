import 'dart:async';
import 'dart:convert';

import 'package:albandar_project1/services/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class BoatDetails extends StatelessWidget {
  final String accodevalue;
  const BoatDetails({Key? key, required this.accodevalue}) : super(key: key);

  final  TextStyle _textStyle1=const TextStyle(fontSize: 15,color: Colors.black87);
  final TextStyle _textStyle2=const TextStyle(fontSize: 14,color: Colors.black45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boat Details"),
        centerTitle: true,
      ),
      body: FutureBuilder<Response>(
          future: MyApi.getBoatdetails(accode: accodevalue),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(strokeWidth: 2));
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<dynamic> response =
                    (jsonDecode(snapshot.data!.body))['recordset'];
                if (response.isNotEmpty) {
                  String responseRegistrationNo=response[0]['RegistrationNo']??"----";
                  String responseBoatEngineNo=response[0]['BoatEngineNo']??"----";
                  String responseBoatEngineType=response[0]['BoatEngineType']??"----";
                  String responseSailingLicenseExpiryDate=response[0]['SailingLicenseExpiryDate']??"----";
                  String responseRegExpiry=response[0]['RegExpiry']??"----";
                  String responseBoatName=response[0]['BoatName']??"----";
                  String responseInsuranceNo=response[0]['InsuranceNo']??"----";
                  String responseInsuranceExpDate=response[0]['InsuranceExpDate']??"----";

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Boat Name :",style: _textStyle1),
                          Text("$responseBoatName",style: _textStyle2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Registration No :",style: _textStyle1),
                            Text("$responseRegistrationNo",style: _textStyle2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Boat Engine No :",style: _textStyle1),
                            Text("$responseBoatEngineNo",style: _textStyle2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Boat Engine Type :",style: _textStyle1),
                            Text("$responseBoatEngineType",style: _textStyle2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sailing License ExpDate :",style: _textStyle1),
                            Text("${responseSailingLicenseExpiryDate.substring(0,10)}",style: _textStyle2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Registration Expiry :",style: _textStyle1),
                            Text("${responseRegExpiry.substring(0,10)}",style: _textStyle2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Insurance No :",style: _textStyle1),
                            Text("$responseInsuranceNo",style: _textStyle2),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Insurance Expiry Date :",style: _textStyle1),
                            Text("$responseInsuranceExpDate",style: _textStyle2),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text("No boat found! Please contact your Manager"),
                  );
                }
              } else if (snapshot.hasError) {
                if (snapshot.error == TimeoutException) {
                  return Center(
                      child: Text("Server down Please contact your manager."));
                } else {
                  return Center(child: Text("Some issues please try again."));
                }
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
            return SizedBox();
          }),
    );
  }
}
