import 'dart:async';

import 'package:albandar_project1/services/apiservice.dart';
import 'package:flutter/material.dart';

import '../podos/allservices.dart';

class AllServicesPage extends StatelessWidget {
  const AllServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style1=const TextStyle(color: Colors.black38,fontSize: 13);
    TextStyle style2=const TextStyle(color: Colors.black45,fontSize: 13);
    TextStyle style3=const TextStyle(color: Colors.black54,fontSize: 12);

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Services"),
        centerTitle: true,
      ),
      body: FutureBuilder<AllServices>(
          future: MyApi.getAllServices(),
          builder: (_,snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.recordset.isNotEmpty) {
                  List<RecordsetofALlServices> listofdata =
                      snapshot.data!.recordset;

                  return ListView.separated(
                      shrinkWrap: true,
                      itemCount: listofdata.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(listofdata[index].serviceDescription,style: style2),
                          trailing: Text("${listofdata[index].memberPrice} Bd",style: style3),);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 0,thickness: 1);
                      });
                } else {
                  return const Center(child: Text("No Services available"));
                }
              } else if (snapshot.hasError) {

                if (snapshot.error == TimeoutException) {
                  return const Center(
                    child: Text(
                        "Server is down! please try again!"),
                  );
                } else {
                  return const Center(
                    child: Text(
                        "Some issues! please contact your manager."),
                  );
                }
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
            return const SizedBox();
          }),
    );

  }
}
