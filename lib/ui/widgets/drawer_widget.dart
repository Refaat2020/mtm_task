import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().screenWidth/1.5,

      child: ListView(
        children: [
          Container(
            color: const Color(0xfff6f6f8),
            width: ScreenUtil().screenWidth/2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 50.h),
              child: Column(
                children: [
                  ///brand or store name
                  Padding(
                    padding:EdgeInsets.only(right: 70.w),

                    child: Text(
                      "MTM",
                      style: TextStyle(
                          color: const Color(0xff515965),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  /// branch
                  Padding(
                    padding:  EdgeInsets.only(right: 70.w),
                    child: Text(
                      "MTM TASK",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            ),
          ),

          ///icons
          Container(
            width: ScreenUtil().screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ///dashboard
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.dashboard,
                      color: Colors.black,
                    ),
                    onPressed: () {
                    },
                    label: Text(
                      "Dashboard",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

                ///orders
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.assignment,
                      color: Colors.black,
                    ),
                    onPressed: () {

                    },
                    label: Text(
                      "Orders",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

                ///exchange
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.assignment_return_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                    label: Text(
                      "Exchange",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.sp,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

                ///settings
                Container(
                  color: Colors.lightBlue.withOpacity(0.2),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: TextButton.icon(
                          icon: const Icon(
                            Icons.settings,
                          ),
                          onPressed: () {},
                          label: Text(
                            "Settings",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),

                ///orders
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.language,
                      color: Colors.black,
                    ),
                    onPressed: () {

                    },
                    label: Text(
                      "language",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///buttons
          Padding(
            padding: EdgeInsets.only(top: 100.h, right: 5.w, left: 8.w),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: 200.w,
                height: 44.h,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all( Radius.circular(10)),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xff819fe3), width: 1.8),
                ),
                child: Center(
                  child: Text(
                    "Change User",
                    style: TextStyle(
                        color: const Color(0xff819fe3),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h, right: 5.w, left: 8.w),
            child: InkWell(
              onTap: () async {

              },
              child: Container(
                width: 200.w,
                height: 44.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xff3674d9),
                ),
                child: Center(
                  child: Text(
                    "LogOut",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          )
        ],
      ),
    );
  }
}
