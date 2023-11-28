import 'dart:convert';
import 'dart:io';

class SmartTrafficApi {
  static String baseUrl = "https://6bab-103-144-92-133.ngrok-free.app";
  static String initiate = "$baseUrl/main/simulation/";
  static String status = "$baseUrl/main/simulation/status/";
  static String getResultInitiate = "$baseUrl/main/get-results/";
  static String getResultStatus = "$baseUrl/main/get-results/status/";
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

  startGetResult() async {
    String? taskId;
    await client.getUrl(Uri.parse(getResultInitiate)).then((HttpClientRequest request) async {
      return await request.close();
    }).then((HttpClientResponse response) async {
      String data = await response.transform(utf8.decoder).join();
      // string to json
      Map<String, dynamic> jsonData = jsonDecode(data);
      taskId = jsonData['task'];
    });
    return taskId;
  }

  getResultStatusCheck(String task) async {
    String url = "$getResultStatus$task";
    Map<String, dynamic>? result;
    await client.getUrl(Uri.parse(url)).then((HttpClientRequest request) async {
      return await request.close();
    }).then((HttpClientResponse response) async {
      String data = await response.transform(utf8.decoder).join();
      // string to json
      Map<String, dynamic> jsonData = jsonDecode(data);
      result = jsonData;
    });
    return result;
  }
}
