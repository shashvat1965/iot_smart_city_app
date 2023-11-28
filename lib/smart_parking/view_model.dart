import 'api.dart';

class SmartParkingViewModel {
  static String currentGenerateTask = "";

  Future<Map<String, dynamic>> startSimulation() async {
    currentGenerateTask = await SmartParkingApi().startSimulation();
    String status = "";
    Map<String, dynamic> data = {};
    do {
      await Future.delayed(const Duration(seconds: 2));
      data = await SmartParkingApi().checkStatus(currentGenerateTask);
      status = data['status'];
    } while (status != "SUCCESS");

    print("generation done");
    return data;
  }
}
