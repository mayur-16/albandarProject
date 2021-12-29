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
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  backgroundColor: MaterialStateProperty.all(Colors.green.shade400)),
                onPressed: (){
                  showDialog(context: context, builder: (_){
                    return MycustomWidgets().showsubmemberDialogbox(logindata: logindata, context: context);
                  });
                },
                child: const Text("show my sub members",style: TextStyle(fontSize: 18),)),

          /*  ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    backgroundColor: MaterialStateProperty.all(Colors.black87)),
                onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const PunchinOut()));
                  },
                child: const Text("Punch",style: TextStyle(fontSize: 18),)),*/

          ],
        ),
      ),
    );
  }


}
