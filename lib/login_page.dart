import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:albandar_project1/home_page.dart';
import 'package:albandar_project1/services/apiservice.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              Image.asset("assets/icons/albandaricon.jpg",
                  height: 100, width: 100),
              SizedBox(height: MediaQuery.of(context).size.height*0.10),
              TextFormField(
                controller: membernocontroller,
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
                style: ElevatedButton.styleFrom(primary: _loading?Colors.blueGrey:Colors.green),
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
         String responseCprno=response[0]['CPRNo'];
         String responseACcode=response[0]['ACCODE'];
         String responseFirstname=response[0]['NAME'];
         String responsephoneno=response[0]['TELOFF'];

         Map<String,String> logindata={
           'memberno':responseMemberno,
           'cprno':responseCprno,
           'accode':responseACcode,
         'firstname':responseFirstname,
         'phoneno':responsephoneno
         };

         savedatatosharedpreference(details: logindata);

        if(responseCprno==enteredCPRnovalue)
          {
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

  void savedatatosharedpreference({required Map<String,String> details}) async{
    
    //convert map to string
    String data=json.encode(details);
    
    //save data to sharedpreference
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setBool("isloggedIn", true);
    sharedPreferences.setString("logindata", data);

  }
}
