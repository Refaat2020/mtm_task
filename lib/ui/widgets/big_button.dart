import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigButton extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Function onTap;
  final Color textColor;
  final Color containerColor;
  final Color borderColor;

   BigButton({
    required this.height,
    required this.width,
    required this.name ,
    required this.onTap,
    required this.textColor,
    required this.containerColor,
    required this.borderColor,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        onTap();
      } ,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color:containerColor ,
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: borderColor,width:1.5 )
        ),
        child: Center(
          child: Text(name , style: TextStyle(color: textColor , fontWeight: FontWeight.bold,fontSize: 13.sp),),
        ),
      ),
    );
  }
}