import 'package:location/location.dart';

class MyLocationService{

  late bool _serviceenabled;
  late PermissionStatus _permissionStatus;
  late LocationData _locationData;
  late bool _backgroundlocation;

  Future<bool> isLocationserviceEnabled()async{
    _serviceenabled=await Location().serviceEnabled();
    return _serviceenabled;
  }

  Future<bool> enableLocationService()async{
    _serviceenabled=await Location().requestService();
    return _serviceenabled;
  }

  Future<PermissionStatus> isLocationservicehasPermission()async{
    _permissionStatus=await Location().hasPermission();
    return _permissionStatus;
  }

  Future<PermissionStatus> requestLocationPermission()async{
    _permissionStatus=await Location().requestPermission();
    return _permissionStatus;
  }

  Future<bool> requestforbackgroundLocationPermission()async{
    _backgroundlocation=await Location().enableBackgroundMode();
    return _backgroundlocation;
  }

  Future<LocationData> getLocationData()async{
    _locationData=await Location().getLocation();
    return _locationData;
  }

}