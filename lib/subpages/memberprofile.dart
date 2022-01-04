import 'dart:async';

import 'package:flutter/material.dart';

import '../podos/submembers.dart';
import '../services/apiservice.dart';

class MemberProfile extends StatefulWidget {

  final Map logindata;
  const MemberProfile({Key? key,required this.logindata}) : super(key: key);

  @override
  _MemberProfileState createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {

  TextStyle style1=const TextStyle(color: Colors.black38,fontSize: 13);
  TextStyle style2=const TextStyle(color: Colors.black45,fontSize: 13);
  TextStyle style3=const TextStyle(color: Colors.black54,fontSize: 12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Hero(
          tag: "memprof",
          child: Card(
            color: Colors.lightBlue.shade800,
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side:   BorderSide(color: Colors.lightBlue.shade800),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text("Member Profile\n[${widget.logindata['firstname']}]",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20,color: Colors.white54,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: FutureBuilder<SubMemberDetails>(
                          future: MyApi.getSubMemberdetails(
                              memberno: widget.logindata['memberno']),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.recordset.isNotEmpty) {
                                  List<RecordsetofSubmemberdetails> listofdata =
                                      snapshot.data!.recordset;

                                  return ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: listofdata.length,
                                      itemBuilder: (_, index) {

                                        String telno="${listofdata[index].teloff}";
                                        String name="${listofdata[index].title} ${listofdata[index].name}";
                                        String birthdate=listofdata[index].birthdt!.substring(0,10);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
