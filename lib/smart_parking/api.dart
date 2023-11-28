import 'dart:convert';
import 'dart:io';

class SmartParkingApi {
  static String baseUrl = "https://b3b1-2a09-bac5-3cd7-1eb-00-31-dc.ngrok-free.app";
  static String initiate = "$baseUrl/main/park-sim/";
  static String status = "$baseUrl/main/park-sim/status/";
  HttpClient client = HttpClient();

  startSimulation() async {
    String? taskId;
    await client.getUrl(Uri.parse(initiate)).then((HttpClientRequest request) async {
      return await request.close();
    }).then((HttpClientResponse response) async {
      String data = await response.transform(utf8.decoder).join();
      // string to json
      Map<String, dynamic> jsonData = jsonDecode(data);
      print(jsonData);
      taskId = jsonData['task'];
    });
    return taskId;
  }

  checkStatus(String task) async {
    String url = "$status$task";
    String? taskStatus;
    await client.getUrl(Uri.parse(url)).then((HttpClientRequest request) async {
      return await request.close();
    }).then((HttpClientResponse response) async {
      String data = await response.transform(utf8.decoder).join();
      // string to json
      Map<String, dynamic> jsonData = jsonDecode(data);
      taskStatus = jsonData['status'];
    });
    return taskStatus;
  }
}
