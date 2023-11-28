import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:iot_smart_city/constants.dart';
import 'package:iot_smart_city/smart_traffic_junction/smart_traffic.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('smart_traffic');
  List<List<int>> data = [[],[],[]];
  box.put('data', data);
  runApp(ScreenUtilInit(
      designSize: const Size(411.42857142857144, 867.4285714285714),
      builder: (_, child) {
        return const MaterialApp(home: MyApp());
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Group 13 IOT Project",
                style: GoogleFonts.rubik(fontSize: 40.sp, color: Colors.white),
              ),
              SizedBox(
                height: 100.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SmartTraffic()));
                  },
                  child: Text("Smart Traffic Junction", style: GoogleFonts.rubik(fontSize: 15.sp))),
              SizedBox(
                height: 12.5.h,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Smart Parking Lot",
                    style: GoogleFonts.rubik(fontSize: 15.sp),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
