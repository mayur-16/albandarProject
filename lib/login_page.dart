import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:albandar_project1/home_page.dart';
import 'package:albandar_project1/services/apiservice.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey=GlobalKey<FormState>();
  TextEditingController membernocontroller=TextEditingController();
  TextEditingController cprnocontroller=TextEditingController();
  bool _isObscure=true;
  bool _loading=false;
  bool _membernoInvalid=false,_cprnoInvalid=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.15),
              Image.asset("assets/icons/albandericon.jpg",
                  height: 100, width: 100),
              SizedBox(height: MediaQuery.of(context).size.height*0.10),
              TextFormField(
                controller: membernocontroller,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  hintText: "Enter member number.",
                  labelText: "Member no*",
                  icon: const Icon(Icons.person),
                  errorText: _membernoInvalid?"member number is invalid":null,
                ),
                validator: (value){
                  if(value==null|| value.isEmpty)
                    {
                      return "Please enter member number";
                    }
                  return null;
                },
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.05),

              TextFormField(
                obscureText: _isObscure,
                controller: cprnocontroller,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  labelText: "CPR no*",
                  hintText: "Enter your CPR number",
                  icon: const Icon(Icons.lock_rounded),
                  errorText: _cprnoInvalid?"CPR number is invalid":null,
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _isObscure=!_isObscure;
                        });
                      },
                      icon:Icon(_isObscure?Icons.visibility_off:Icons.visibility),
                  )
                ),
                validator: (value){
                  if(value==null|| value.isEmpty)
                  {
                    return "Please enter CPR number";
                  }
                  return null;
                },
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.10),

              
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: _loading?Colors.blueGrey:Colors.blue),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){

                      setState(() {
                      //clear all error messages
                      _membernoInvalid=false;
                      _cprnoInvalid=false;
                      _loading=true;
                      });
                      
                      getLoginDetailsfromApi();
                    }
                    else {
                      return;
                    }
                  },
                  child:  Text(_loading?" loading...":"Login")),

              SizedBox(height: MediaQuery.of(context).size.height*0.10),
            ],
          ),
        ),
      ),
    );
  }

  void getLoginDetailsfromApi() async{

    String enteredMembernovalue=membernocontroller.text.trim();
    String enteredCPRnovalue=cprnocontroller.text.trim();


    MyApi.getUserdetailsforLogin(memberno: enteredMembernovalue)
        .then((value){

      List<dynamic> response = (jsonDecode(value.body))['recordset'];
      if(response.isNotEmpty)
        {
         String responseMemberno=response[0]['MemberNo'];
         String responsePrimary=response[0]['PRIMARYMEMBER'];
         String responseCprno=response[0]['CPRNo'];
         String responseACcode=response[0]['ACCODE'];
         String responseTitle=response[0]['TITLE'];
         String responseFirstname=response[0]['NAME'];
         String responseSurname=response[0]['SURNAME'];
         String responsephonenoOffice=response[0]['TELOFF'];
         String responsephonenoResidency=response[0]['TELRES'];
         String responseBirthdate=response[0]['BIRTHDT'].toString().substring(0,10);
         String responsemaritalstatus=response[0]['MARITAL'];
         String responseaddress1=response[0]['ADD1'];
         String responseaddress2=response[0]['ADD2'];
         String responseaddress3=response[0]['ADD3'];
         String responseNation=response[0]['NATION'];
         String responsePosition=response[0]['POSITION'];

         Map<String,String> logindata={
           'memberno':responseMemberno,
           'primarymemberno':responsePrimary,
           'cprno':responseCprno,
           'accode':responseACcode,
           'position':responsePosition,
           'title':responseTitle,
         'firstname':responseFirstname,
           'surname':responseSurname,
         'residencyphoneno':responsephonenoResidency,
           'officephoneno':responsephonenoOffice,
           'birthdate':responseBirthdate,
           'maritalstatus':responsemaritalstatus,
           'address1':responseaddress1,
           'address2':responseaddress2,
           'address3':responseaddress3,
           'nation':responseNation,
         };

        if(responseCprno==enteredCPRnovalue)
          {
            savedatatosqlflite(details: logindata);

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomePage(logindata: logindata,)));

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Logged In as $responseFirstname")));
          }
        else
          {
            setState(() {
              _loading=false;
              _cprnoInvalid=true;
            });
            return;
          }
        }
      else
        {
          setState(() {
            _membernoInvalid=true;
            _loading=false;
          });
          return;
        }


    }).onError((error, stackTrace){
      log(error.toString());
      setState(() {
        _loading=false;
      });
      
if(error==TimeoutException)
  {
    Fluttertoast.showToast(msg: "Server down! Please try after some time.");
    return;
  }
    });

  }

  void savedatatosqlflite({required Map<String,String> details}) async{

    //get database path
    String databasePath=await getDatabasesPath();
    String path="$databasePath/usercredentials.db";

    //open the database
    Database database=await openDatabase(path);

    //insert user details to USER TABLE
    await database.transaction((txn) async{
      int id=await txn.rawInsert(
        'INSERT INTO USER(memberno ,cprno ,accode ,position ,title ,firstname ,surname ,residencyphoneno ,'
            'officephoneno  ,birthdate ,maritalstatus ,address1,address2 ,address3 ,nation ,loggedin) '
            'VALUES("${details['memberno']}","${details['cprno']}","${details['accode']}","${details['position']}",'
            '"${details['title']}","${details['firstname']}","${details['surname']}","${details['residencyphoneno']}",'
            '"${details['officephoneno']}","${details['birthdate']}","${details['maritalstatus']}","${details['address1']}",'
            '"${details['address2']}","${details['address3']}","${details['nation']}",1)'
      );
      log(id.toString());
    });

    //Close the database
    await database.close();
  }
}
