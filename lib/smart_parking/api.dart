import 'dart:convert';
import 'dart:io';

class SmartParkingApi {
  static String baseUrl = "https://1027-2402-3a80-8f9-5b95-9163-dff1-b04c-624b.ngrok-free.app";
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
    Map<String, dynamic> data = {};
    await client.getUrl(Uri.parse(url)).then((HttpClientRequest request) async {
      return await request.close();
    }).then((HttpClientResponse response) async {
      String responseString = await response.transform(utf8.decoder).join();
      // string to json
      Map<String, dynamic> jsonData = jsonDecode(responseString);
      data = jsonData;
    });
    return data;
  }
}
