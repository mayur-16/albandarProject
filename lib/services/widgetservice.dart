import 'dart:async';

import 'package:albandar_project1/login_page.dart';
import 'package:albandar_project1/services/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

import '../podos/submembers.dart';

class MyDrawer extends StatelessWidget {
  final Map logindata;
  const MyDrawer({Key? key,required this.logindata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    const Text(
                      "Profile",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.person, color: Colors.black45),
                    ),
                  ],
                )),
            ListTile(
                leading: const Text("Member no :",
                    style: TextStyle(color: Colors.black45)),
                title: Text("${logindata['memberno']}",
                    style: const TextStyle(color: Colors.black87))),
            ListTile(
                leading: const Text(
                  "Name:",
                  style: TextStyle(color: Colors.black45),
                ),
                title: Text("${logindata['firstname']}",
                    style: const TextStyle(color: Colors.black87))),
            ListTile(
                leading: const Text(
                  "Contact no :",
                  style: TextStyle(color: Colors.black45),
                ),
                title: Text(logindata['residencyphoneno'].toString().isEmpty?"--":logindata['residencyphoneno'],
                    style: const TextStyle(color: Colors.black87))),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.blue.shade700),
                onPressed: () async {

                  //get database path
                  String databasePath=await getDatabasesPath();
                  String path="$databasePath/usercredentials.db";
                  deleteDatabase(path);

                  //navigate to login page
                  Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (_)=>LoginPage()));
                  Fluttertoast.showToast(msg: "Logged out successfully");
                },
                child: const Text("Logout",style: TextStyle(fontFamily: 'Overpass'),)),
          ],
        ),
      ),
    );
  }
}

class MycustomWidgets{

  TextStyle style1=const TextStyle(color: Colors.black38,fontSize: 13);
  TextStyle style2=const TextStyle(color: Colors.black45,fontSize: 13);
  TextStyle style3=const TextStyle(color: Colors.black54,fontSize: 12);

  Dialog showsubmemberDialogbox({required Map logindata,required BuildContext context}){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(15)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: FutureBuilder<AllAgreementDetailsofSubMember>(
              future: MyApi.getAllAgreementDetailsofsubmember(
                  primarymember: logindata['memberno']),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.recordset.isNotEmpty) {
                      List<RecordsetofSubmemberdetails> listofdata =
                          snapshot.data!.recordset;

                      return ListView.separated(
                          itemCount: listofdata.length,
                          itemBuilder: (_, index) {

                            String telno="${listofdata[index].teloff}";
                            String name="${listofdata[index].title} ${listofdata[index].name}";
                            String birthdate=listofdata[index].birthdt.substring(0,10);
                            String relation="${listofdata[index].relation}";

                            return ListTile(
                              leading: Text(
                                  "Tel no:\n$telno",style: style1),
                              title: Text(name,style: style2),
                              subtitle: Text("Birthdate : $birthdate",style: style3,),
                              trailing: Text("($relation)",style: style3,),);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(height: 0,thickness: 1);
                          });
                    } else {
                      return const Text("No submembers present for You!");
                    }
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
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              }),
        ),
      ),
    );
  }
}
