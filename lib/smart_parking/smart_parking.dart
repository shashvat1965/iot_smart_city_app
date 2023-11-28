import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_smart_city/smart_parking/view_model.dart';

import '../constants.dart';

class SmartParking extends StatefulWidget {
  const SmartParking({Key? key}) : super(key: key);

  @override
  SmartParkingState createState() => SmartParkingState();
}

class SmartParkingState extends State<SmartParking> {
  var openLane = "A";
  bool isLoading = false;

  buttonPressHandle() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Text(
            "Smart Parking Lot",
            style: GoogleFonts.rubik(fontSize: 40.sp, color: Colors.white),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: Text("Parking Lot ${index + 1}: ${Random().nextBool() ? "Available" : "Not Available"}",
                      textAlign: TextAlign.center, style: GoogleFonts.rubik(fontSize: 20.sp, color: Colors.white)),
                ));
              },
              itemCount: 40,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
              onPressed: () {
                SmartParkingViewModel().startSimulation();
              },
              child: Text(
                "Smart Parking Lot",
                style: GoogleFonts.rubik(fontSize: 15.sp),
              )),
        ],
      ),
    );
  }
}
