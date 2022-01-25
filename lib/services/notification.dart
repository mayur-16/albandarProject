import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';

class MyNotification {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin= FlutterLocalNotificationsPlugin();

  Future showNotificationWithoutSound(LocationData locationData) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =  AndroidNotificationDetails(
        '1',
        'location-bg',
        channelDescription: 'fetch location in background',
        playSound: false, importance: Importance.max, priority: Priority.high);
    IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(presentSound: false);

    NotificationDetails platformChannelSpecifics =  NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Location fetched',
            "${locationData.latitude} , ${locationData.longitude}",
      platformChannelSpecifics,
      payload: '',
    );
  }

  MyNotification() {
    var initializationSettingsAndroid =  AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS =  IOSInitializationSettings();
    var initializationSettings =  InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
}