import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mtm_task/constant/camera_position.dart';
import 'package:mtm_task/constant/k_colors.dart';
import 'package:mtm_task/cubit/current_location_cubit.dart';
import 'package:mtm_task/cubit/search_destination_cubit.dart';
import 'package:mtm_task/cubit/search_source_cubit.dart';
import 'package:mtm_task/ui/screens/search_destination_screen.dart';
import 'package:mtm_task/ui/screens/search_screen.dart';
import 'package:mtm_task/ui/widgets/big_button.dart';
import 'package:mtm_task/ui/widgets/drawer_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _googleMapController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HashSet<Marker> markers = HashSet<Marker>();
  late FocusNode focusNodeFrom;
  late FocusNode focusNodeTo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNodeFrom = FocusNode();
    focusNodeTo = FocusNode();
    context.read<CurrentLocationCubit>().checkLocation(context);
    context.read<CurrentLocationCubit>().getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    final current = context.watch<CurrentLocationCubit>();
    final searchSource = context.watch<SearchSourceCubit>();
    final searchDestination = context.watch<SearchDestinationCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body: Stack(
        children: [
          BlocListener<CurrentLocationCubit, CurrentLocationState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is CurrentLocationLocated) {
                _googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(current.lat, current.long),
                        zoom: 11.5)));
                markers.add(
                  Marker(
                    markerId: const MarkerId("userLocation"),
                    position: LatLng(current.lat, current.long),
                    infoWindow: const InfoWindow(title: "You"),
                  ),
                );
              }
            },
            child: GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              markers: markers,
              myLocationButtonEnabled: false,
              myLocationEnabled: false,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (controller) {
                _googleMapController = controller;
              },
            ),
          ),
          Positioned(
            top: 80.h,
            left: 20.w,
            child: Container(
              height: 150.h,
              width: ScreenUtil().screenWidth / 1.1,
              decoration: BoxDecoration(
                color: kBackground,
                borderRadius: BorderRadius.all(Radius.circular(3.r)),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// menu Button
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    ///source location
                    Container(
                      width: ScreenUtil().screenWidth / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                      child: TextFormField(
                        controller: searchSource.sourceController,
                        focusNode: focusNodeFrom,
                        onTap: () {
                          focusNodeFrom.unfocus();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ));
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 10.w,
                          ),
                          hintText: "Your location",
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.1)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.1)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.1)),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10.h,
                    ),

                    /// destinations
                    Container(
                      width: ScreenUtil().screenWidth / 1.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                      child: TextFormField(
                        controller: searchDestination.destinationController,
                        focusNode: focusNodeTo,
                        onTap: () {
                          focusNodeTo.unfocus();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchDestinationScreen(),
                              ));
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        keyboardType: TextInputType.text,
                        // controller: search.textEditingController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: 10.w,
                          ),
                          hintText: "Destination",
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.1)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.1)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: ScreenUtil().screenHeight / 1.15,
              left: 45.w,
              child: BigButton(
                  height: 50.h,
                  width: ScreenUtil().screenWidth / 1.3,
                  name: "REQUEST RD",
                  onTap: () {
                    if (searchSource.sourceController.text ==""||searchDestination.destinationController.text == "") {
                      AwesomeDialog(
                        width:ScreenUtil().screenWidth/1.2,
                        context: context,
                        animType: AnimType.SCALE,
                        autoHide: const Duration(seconds: 3),
                        dialogType: DialogType.ERROR,
                        title: "Warning",
                        desc: "Please select source/destination",

                      ).show();
                    }else{
                      AwesomeDialog(
                        width:ScreenUtil().screenWidth/1.2,
                        context: context,
                        animType: AnimType.SCALE,
                        autoHide: const Duration(seconds: 3),
                        dialogType: DialogType.SUCCES,
                        title: "Success",
                        desc: "100KM",

                      ).show();
                    }
                  },
                  textColor: Colors.white,
                  containerColor: kButton,
                  borderColor: kButton),
          ),
        ],
      ),
    );
  }
}
