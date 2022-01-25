import 'dart:async';

import 'package:albandar_project1/podos/allagreementdetails.dart';
import 'package:albandar_project1/services/apiservice.dart';
import 'package:albandar_project1/subpages/single_agreementpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllAgreementPage extends StatelessWidget {
  final Map logindata;

  const AllAgreementPage({Key? key, required this.logindata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<AllAgreementDetails>(
        future: MyApi.getAllAgreementDetails(memberno: logindata['memberno']),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<RecordsetofAllAgreementdetails> listofdata =
                  snapshot.data!.recordset;

              return ListView.builder(
                  itemCount: listofdata.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    String membertypevalue = '--';
                    if (index == 0) {
                      String membtype = listofdata[index].membtype;
                      switch (membtype) {
                        case "F":
                          {
                            membertypevalue = "Family";
                          }
                          break;
                        case "C":
                          {
                            membertypevalue = "Corporate";
                          }
                          break;

                        case "S":
                          {
                            membertypevalue = "Single";
                          }
                          break;
                      }
                    }
                    return Card(
                        elevation: 6,
                        color: index == 0 ? Colors.red.shade100 : null,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        margin: index == 0
                            ? EdgeInsets.symmetric(vertical: 16, horizontal: 8)
                            : EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: InkWell(
                          splashColor: Colors.grey,
                          onTap: (){
                            Navigator.of(context).push(_createRoute(data: listofdata[index]));
                          },
                          child: Padding(
                            padding: index == 0
                                ? EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8)
                                : EdgeInsets.all(9.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${listofdata[index].name} (${listofdata[index].memberNo})",
                                  style: index == 0
                                      ? TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue.shade700),
                                ),
                                if (index == 0)
                                  Text(
                                    "Member Type : $membertypevalue",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black54),
                                  ),
                                Text(
                                    "${listofdata[index].fromdt.toString().substring(0, 10)} to ${listofdata[index].todt.toString().substring(0, 10)}"
                                    " (${listofdata[index].description})",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black87)),
                                Text("Price : ${listofdata[index].amount} Bd",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black54))
                              ],
                            ),
                          ),
                        ));
                  });
            } else if (snapshot.hasError) {
              if (snapshot.error == TimeoutException) {
                return const Text("Server is down! please try again!");
              } else {
                return const Text("Some issues! please contact your manager.");
              }
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }

  Route _createRoute({required RecordsetofAllAgreementdetails data}) {

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  SingleAgreementPage(agreementdetails: data),
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset(0.0,0.0);
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

}
