import 'package:iot_smart_city/smart_traffic_junction/api.dart';
import 'package:iot_smart_city/storage_service.dart';

class SmartTrafficViewModel {
  static String currentGenerateTask = "";
  static String currentGetResultTask = "";

  Future<Map<String, dynamic>> startSimulation() async {
    currentGenerateTask = await SmartTrafficApi().startSimulation();
    String status = "";
    do {
      await Future.delayed(const Duration(seconds: 2));
      status = await SmartTrafficApi().checkStatus(currentGenerateTask);
      print("Generation Status: $status");
    } while (status != "SUCCESS");

    print("generation done");
    Map<String, dynamic> data = {};
    if (status == "SUCCESS") {
      status = "";
      currentGetResultTask = await SmartTrafficApi().startGetResult();
      do {
        await Future.delayed(const Duration(seconds: 2));
        data = await SmartTrafficApi().getResultStatusCheck(currentGetResultTask);
        status = data['status'];
        print("Fetch Status: $status");
      } while (status != "SUCCESS");
    } else {
      currentGetResultTask = "ERROR";
    }
    StorageService().updateData(data['data']['cars']);
    return data;
  }
}
