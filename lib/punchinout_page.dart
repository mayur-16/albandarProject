import 'dart:developer';

import 'package:albandar_project1/services/locationservice.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PunchinOut extends StatefulWidget {
  const PunchinOut({Key? key}) : super(key: key);

  @override
  _PunchinOutState createState() => _PunchinOutState();
}

class _PunchinOutState extends State<PunchinOut> {
  late LatLng _latLng;
  bool _loading = true;

  final ButtonStyle _buttonStyle =
      ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown));

  @override
  void initState() {
    super.initState();
    getlocationdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Punch"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GoogleMap(
                    onMapCreated: _onMapCreated,
                    mapType: MapType.hybrid,
                    myLocationEnabled: true,
                    initialCameraPosition:
                        CameraPosition(target: _latLng, zoom: 16),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Punch In"),
                style: _buttonStyle,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Punch In"),
                style: _buttonStyle,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {}

  Future<void> getlocationdata() async {
    bool islocationEnabled =
        await MyLocationService().isLocationserviceEnabled();

    bool isBackgroundlocationEnabled=await MyLocationService().requestforbackgroundLocationPermission();
    log(isBackgroundlocationEnabled.toString(),name: "background");

    if (!islocationEnabled) {
      bool enableLocation = await MyLocationService().enableLocationService();
      if (!enableLocation) {
        Fluttertoast.showToast(
            msg: "App needs location service to work properly!");
        return;
      }
    }
    PermissionStatus isLocationServicehasPermission =
        await MyLocationService().isLocationservicehasPermission();
    if (isLocationServicehasPermission == PermissionStatus.denied) {
      await MyLocationService()
          .requestLocationPermission()
          .then((permissionStatus) async {
        if (permissionStatus == PermissionStatus.denied ||
            permissionStatus == PermissionStatus.deniedForever) {
          Fluttertoast.showToast(msg: "please accept the Location permission!");
          return;
        } else {
          LocationData locationData =
              await MyLocationService().getLocationData();
          log(locationData.latitude.toString());
          _latLng =
              LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0);
          setState(() {
            _loading = false;
          });
        }
      });
    } else if (isLocationServicehasPermission ==
        PermissionStatus.deniedForever) {
      Fluttertoast.showToast(
          msg: "We cannot ask the Location permission again!\n"
              "Please enable it through settings");
      return;
    } else if (isLocationServicehasPermission == PermissionStatus.granted ||
        isLocationServicehasPermission == PermissionStatus.grantedLimited) {
      LocationData locationData = await MyLocationService().getLocationData();
      log(locationData.latitude.toString());
      _latLng = LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0);
      setState(() {
        _loading = false;
      });
    }
  }
}
