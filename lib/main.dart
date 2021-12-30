import 'dart:convert';

import 'package:albandar_project1/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

void main() {
  dovalidation();
}


dovalidation() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  bool isLoggedIn=sharedPreferences.getBool("isloggedIn")??false;
  String logindata=sharedPreferences.getString("logindata")??"";

  Map logindetails={};
  if(logindata.isNotEmpty) {
     logindetails=json.decode(logindata);
  }

  runApp(MaterialApp(
    home: isLoggedIn? HomePage(logindata: logindetails,):const LoginPage(),
    theme: ThemeData(
      fontFamily: 'Overpass',
      appBarTheme:  const AppBarTheme(
        color: Colors.blueGrey,
      ),
    ),
    debugShowCheckedModeBanner: false,
  ));

}


