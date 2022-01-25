
import 'dart:developer';

import 'package:albandar_project1/home_page.dart';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'login_page.dart';



//for fetching background location
 const fetchBackground="fetchBackground";

/*void callbackDispatcher(_) {
  Workmanager().executeTask((taskName, inputData) async{
    switch (taskName){
      case fetchBackground:
        LocationData locationData;
        bool islocationServiceEnabled=await MyLocationService().isLocationserviceEnabled();
        if(!islocationServiceEnabled)
          {
            await MyLocationService().enableLocationService();
          }
        PermissionStatus islocationHasPermission=await MyLocationService().isLocationservicehasPermission();
        if(islocationHasPermission==PermissionStatus.denied)
          {
            PermissionStatus requestedPermission=await MyLocationService().requestLocationPermission();
            if(requestedPermission==PermissionStatus.granted ||requestedPermission==PermissionStatus.grantedLimited)
              {
                locationData= await MyLocationService().getLocationData();
              }
          }else if(islocationHasPermission==PermissionStatus.granted||islocationHasPermission==PermissionStatus.grantedLimited)
            {
              locationData= await MyLocationService().getLocationData();
              log("${locationData.latitude} ${locationData.longitude}",name: "lat long");
              MyNotification().showNotificationWithoutSound(locationData);
            }
        break;
    }
    return Future.value(true);
  });
}*/

void main() {
  dovalidation();
}


dovalidation() async {
  WidgetsFlutterBinding.ensureInitialized();

  //get database path
  String databasePath=await getDatabasesPath();
  String path="$databasePath/usercredentials.db";


 //check whether database exists
  bool doesdatabaseExists=await databaseExists(path);
  log(doesdatabaseExists.toString(),name: "check");

  //initially assume your not logged In and logindata is empty
  bool isLoggedIn=false;
  List<Map> logindata=[{}];

  if(doesdatabaseExists)
    {
       //open the database
  Database database=await openDatabase(path);

  //check whether already logged in
  List<Map> loggedIn=await database.rawQuery(' SELECT LOGGEDIN FROM USER');

  if(loggedIn.isNotEmpty) {

    if (loggedIn.first['loggedin'] == 1) {
      logindata = await database.rawQuery('SELECT * FROM USER');
      isLoggedIn = true;
    }
  }
  database.close();
    }
  else{
    //create new database and create table
    Database database=await openDatabase(path,version: 1,
        onCreate: (Database db,int version)async{
          //when creating the db,create the table
          await db.execute('CREATE TABLE USER(memberno TEXT,cprno TEXT,accode TEXT,position TEXT,title TEXT,firstname TEXT,'
              'surname TEXT,residencyphoneno TEXT ,officephoneno TEXT ,birthdate TEXT,maritalstatus TEXT,address1 TEXT,'
              'address2 TEXT,address3 TEXT,nation TEXT,loggedin INTEGER)');
        });

    database.close();
  }


  runApp(MaterialApp(
    home: isLoggedIn? HomePage(logindata: logindata.first,):const LoginPage(),
   // home: const LoginPage(),
    theme: ThemeData(
      fontFamily: 'Overpass',
      appBarTheme:   AppBarTheme(
        color: Color(0xff023e8a),
      ),
    ),
    debugShowCheckedModeBanner: false,
  ));

}


