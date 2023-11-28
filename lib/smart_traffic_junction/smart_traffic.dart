// smart traffic page

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iot_smart_city/constants.dart';
import 'package:iot_smart_city/smart_traffic_junction/view_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../storage_service.dart';
class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
class SmartTraffic extends StatefulWidget {
  const SmartTraffic({Key? key}) : super(key: key);

  @override
  SmartTrafficState createState() => SmartTrafficState();
}

class SmartTrafficState extends State<SmartTraffic> {
  List<dynamic> data = [10, 9, 10];
  var openLane = "A";
  bool isLoading = false;
  List<List<int>> cumulativeData =  StorageService().readData();


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

  List<ChartData> convertToChartData(List<List<int>> cumulativeData) {
    print("here");



    print(cumulativeData.length);
    List<ChartData> chartDataList = [];

      for (int i  = 0; i < cumulativeData[0].length; i++ ) {
        print(cumulativeData[0][i].toString());
        chartDataList.add(
          ChartData(
            "Iteration $i", // x
            cumulativeData[0][i].toDouble(), // y
          ),
        );
      }

    return chartDataList;
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
          Container(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 15.w,
              top: 15.h,
              bottom: 10.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              series: <SplineSeries<ChartData, String>>[
                SplineSeries<ChartData, String>(
                  dataSource: convertToChartData(cumulativeData),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                ),
              ],
            ),
          ),
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
