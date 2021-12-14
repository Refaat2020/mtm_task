import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'current_location_state.dart';

class CurrentLocationCubit extends Cubit<CurrentLocationState> {
  CurrentLocationCubit() : super(CurrentLocationInitial());

 double lat = 0.0;
 double long = 0.0 ;

  Future getLocation(BuildContext context) async {
    emit(CurrentLocationLoading());
    ///request using gps
    LocationPermission permission = await Geolocator.checkPermission();
    LocationPermission permissions = await Geolocator.requestPermission();

    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Open GPS",style: TextStyle(color: Colors.white,fontSize: 13),),backgroundColor: Colors.black,elevation: 2.0,duration: Duration(milliseconds: 800),));
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }
    Position position = await
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
    lat = position.latitude;
    long = position.longitude;
    emit(CurrentLocationLocated());
  }

  checkLocation(BuildContext context)async{
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied) {
      await Permission.locationWhenInUse.request();
      print("gps denied");
      getLocation(context);
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      print("gps isRestricted");

      // The OS restricts access, for example because of parental controls.
    }

  }
}
