import 'dart:convert';
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
  bool isLoading = false;
  List<String> occupiedSpots = [];
  List<String> vacantSpots = [];
  List<String> reservedSpots = [];
  List<String> incompatibleSpots = [];

  buttonPressHandle() async {
    isLoading = true;
    setState(() {});
    var data = await SmartParkingViewModel().startSimulation();
    String dataString = json.encode(data);
    print(dataString);
    occupiedSpots = SmartParkingViewModel().getOccupiedParkingSpots(dataString);
    vacantSpots = SmartParkingViewModel().getVacantParkingSpots(dataString);
    reservedSpots = SmartParkingViewModel().getListOfReserved(dataString);
    incompatibleSpots = SmartParkingViewModel().getListOfIncompatible(dataString);
    print(occupiedSpots);
    print(vacantSpots);
    print(reservedSpots);
    print(incompatibleSpots);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                Text("Vacant", style: GoogleFonts.rubik(fontSize: 30.sp, color: Colors.black)),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Text(vacantSpots[index],
                          textAlign: TextAlign.center, style: GoogleFonts.rubik(fontSize: 20.sp, color: Colors.white)),
                    ));
                  },
                  itemCount: vacantSpots.length,
                ),
                Text("Reserved", style: GoogleFonts.rubik(fontSize: 30.sp, color: Colors.black)),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Text(reservedSpots[index],
                          textAlign: TextAlign.center, style: GoogleFonts.rubik(fontSize: 20.sp, color: Colors.white)),
                    ));
                  },
                  itemCount: reservedSpots.length,
                ),
                Text("Occupied", style: GoogleFonts.rubik(fontSize: 30.sp, color: Colors.black)),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Text(occupiedSpots[index],
                          textAlign: TextAlign.center, style: GoogleFonts.rubik(fontSize: 20.sp, color: Colors.white)),
                    ));
                  },
                  itemCount: occupiedSpots.length,
                ),
                Text("Incompatible", style: GoogleFonts.rubik(fontSize: 30.sp, color: Colors.black)),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Text(incompatibleSpots[index],
                          textAlign: TextAlign.center, style: GoogleFonts.rubik(fontSize: 20.sp, color: Colors.white)),
                    ));
                  },
                  itemCount: incompatibleSpots.length,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                buttonPressHandle();
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
