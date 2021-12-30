import 'package:albandar_project1/subpages/allservicespage.dart';
import 'package:albandar_project1/subpages/memberprofile.dart';
import 'package:flutter/material.dart';
import 'package:albandar_project1/services/widgetservice.dart';

class HomePage extends StatefulWidget {
  final Map logindata;

  const HomePage({Key? key, required this.logindata}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map logindata = {};
   TextStyle cardtextstyle= const TextStyle(fontSize: 15,color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    logindata = widget.logindata;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Albander"), centerTitle: true),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: MyDrawer(logindata: logindata),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Hello\n${logindata['firstname']}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  MemberProfile(logindata: logindata)));
                    },
                    child: Hero(
                      tag:"memprof",
                      child: Card(
                        elevation: 10,
                        color: Colors.green.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Member\nProfile",
                            textAlign: TextAlign.center,
                            style: cardtextstyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 10,
                      color: Colors.red.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text("Member\nactivity",
                            textAlign: TextAlign.center,
                        style: cardtextstyle,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const AllServicesPage()));
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.blue.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Product&\nservices",
                          textAlign: TextAlign.center,
                          style: cardtextstyle,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 10,
                      color: Colors.purple.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text("Payment\n&grids",
                            textAlign: TextAlign.center,
                          style: cardtextstyle),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
