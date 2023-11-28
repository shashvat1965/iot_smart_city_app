import 'dart:convert';

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

  List<String> getVacantParkingSpots(String jsonStr) {
    List<String> vacantParkingSpots = [];

    try {
      // Parse the JSON string
      Map<String, dynamic> jsonData = json.decode(jsonStr);

      // Extract the list of vacant parking spots
      List<dynamic> vacantList = jsonData['data']['vacant'];

      // Extract names of vacant parking spots and add them to the result list
      for (Map<String, dynamic> spot in vacantList) {
        vacantParkingSpots.add(spot['name']);
      }
    } catch (e) {
      print("Error: $e");
    }

    return vacantParkingSpots;
  }

  List<String> getOccupiedParkingSpots(String jsonStr) {
    List<String> occupiedParkingSpots = [];

    try {
      // Parse the JSON string
      Map<String, dynamic> jsonData = json.decode(jsonStr);

      // Extract the list of occupied parking spots
      List<dynamic> occupiedList = jsonData['data']['occupied'];

      // Extract names of occupied parking spots and add them to the result list
      for (Map<String, dynamic> spot in occupiedList) {
        occupiedParkingSpots.add(spot['name']);
      }
    } catch (e) {
      print("Error: $e");
    }

    return occupiedParkingSpots;
  }

  getListOfReserved(String jsonStr) {
    List<String> reservedParkingSpots = [];

    try {
      // Parse the JSON string
      Map<String, dynamic> jsonData = json.decode(jsonStr);

      // Extract the list of vacant parking spots
      List<dynamic> reservedList = jsonData['data']['reserved'];

      // Extract names of vacant parking spots and add them to the result list
      for (Map<String, dynamic> spot in reservedList) {
        reservedParkingSpots.add(spot['name']);
      }
    } catch (e) {
      print("Error: $e");
    }

    return reservedParkingSpots;
  }

  getListOfIncompatible(String jsonStr) {
    List<String> incompatibleParkingSpots = [];

    try {
      // Parse the JSON string
      Map<String, dynamic> jsonData = json.decode(jsonStr);

      // Extract the list of vacant parking spots
      List<dynamic> reservedList = jsonData['data']['incompatible'];

      // Extract names of vacant parking spots and add them to the result list
      for (Map<String, dynamic> spot in reservedList) {
        incompatibleParkingSpots.add(spot['name']);
      }
    } catch (e) {
      print("Error: $e");
    }

    return incompatibleParkingSpots;
  }
}
