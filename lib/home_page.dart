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
   TextStyle cardtextStyle1= const TextStyle(fontSize: 15,color: Colors.white70);
  TextStyle cardtextStyle2= const TextStyle(fontSize: 15,color: Colors.white);
  final ButtonStyle cardStyle1=ElevatedButton.styleFrom(
       primary: Colors.lightBlue.shade800,
       onPrimary: Colors.black45,
       shadowColor: Colors.blue.shade300,
       elevation: 15,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15),
       ));

  final ButtonStyle cardStyle2=ElevatedButton.styleFrom(
      primary: Colors.lightBlue,
      onPrimary: Colors.black45,
      shadowColor: Colors.blue.shade300,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ));

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/icons/albandericon.jpg",height: 100,width: 100),
            const SizedBox(height: 20),
            Text(
              "${logindata['title']} ${logindata['firstname']} ${logindata['surname']}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.extent(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              primary: false,
              padding: const EdgeInsets.all(8),
              maxCrossAxisExtent: 200.0,
              childAspectRatio: 1.8,
              shrinkWrap: true,
              children: [
                Hero(
                  tag: "memprof",
                  child: ElevatedButton(
                    style: cardStyle1,
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    MemberProfile(logindata: logindata)));
                      },
                      child: Text("Member\nProfile",
                      textAlign: TextAlign.center,
                          style: cardtextStyle1,)),
                ),

                ElevatedButton(
                    style: cardStyle2,
                    onPressed: (){},
                    child: Text("Member\nagreement",
                      textAlign: TextAlign.center,
                      style: cardtextStyle2,)),

                ElevatedButton(
                    style: cardStyle2,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const AllServicesPage()));
                    },
                    child: Text("Product&\nservices",
                      textAlign: TextAlign.center,
                      style: cardtextStyle2,)),

                ElevatedButton(
                    style: cardStyle1,
                    onPressed: (){},
                    child: Text("Payment\n&bills",
                      textAlign: TextAlign.center,
                      style: cardtextStyle1,)),

                ElevatedButton(
                    style: cardStyle1,
                    onPressed: (){},
                    child: Text("Reports",
                      textAlign: TextAlign.center,
                      style: cardtextStyle1,)),

                ElevatedButton(
                    style: cardStyle2,
                    onPressed: (){},
                    child: Text("Notifications",
                      textAlign: TextAlign.center,
                      style: cardtextStyle2,)),

                ElevatedButton(
                    style: cardStyle2,
                    onPressed: (){},
                    child: Text("Dependence",
                      textAlign: TextAlign.center,
                      style: cardtextStyle2,)),

                ElevatedButton(
                    style: cardStyle1,
                    onPressed: (){},
                    child: Text("Boat",
                      textAlign: TextAlign.center,
                      style: cardtextStyle1,)),

              ],),
            ),
          ],
        ),
      ),
    );
  }
}
