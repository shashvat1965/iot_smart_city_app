// smart traffic page

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_smart_city/constants.dart';
import 'package:iot_smart_city/smart_traffic_junction/view_model.dart';

import '../storage_service.dart';

class SmartTraffic extends StatefulWidget {
  const SmartTraffic({Key? key}) : super(key: key);

  @override
  SmartTrafficState createState() => SmartTrafficState();
}

class SmartTrafficState extends State<SmartTraffic> {
  List<dynamic> data = [10, 9, 10];
  var openLane = "A";
  bool isLoading = false;
  List<List<int>> cumulativeData = StorageService().readData();

  buttonPressHandle() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> result = await SmartTrafficViewModel().startSimulation();
    setState(() {
      isLoading = false;
      data = result['data']['cars'];
      openLane = result['data']['open_lane'];
      cumulativeData = StorageService().readData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Smart Traffic Junction",
            style: GoogleFonts.rubik(fontSize: 30.sp, color: Colors.white),
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  "Lane ${laneMap[index + 1]} : ${data[index]}",
                  style: GoogleFonts.rubik(fontSize: 20.sp),
                ),
              );
            },
            itemCount: data.length,
            shrinkWrap: true,
          ),
          SizedBox(
            width: 120.w,
            child: const Divider(
              color: Colors.grey,
              thickness: 2,
            ),
          ),
          Text("Open Lane: $openLane", style: GoogleFonts.rubik(fontSize: 25.sp)),
          ElevatedButton(
              onPressed: () {
                if(isLoading){
                  return;
                }
                buttonPressHandle();
              },
              child: const Text("Next Simulation")),
          SizedBox(
            height: 120.h,
          ),
          if (isLoading) const CircularProgressIndicator()
        ],
      ),
    );
  }
}

Map<int, String> laneMap = {1: "A", 2: "B", 3: "C"};
