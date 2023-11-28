import 'package:hive/hive.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  var box = Hive.box('smart_traffic');

  updateData(List<dynamic> data) {
    List<List<int>> dataFromStorage = readData();
    // update data
    dataFromStorage[0].add(int.parse(data[0].toString()));
    dataFromStorage[1].add(int.parse(data[1].toString()));
    dataFromStorage[2].add(int.parse(data[2].toString()));

    box.put('data', dataFromStorage);
  }

  List<List<int>> readData() {
    List<List<int>> data = box.get('data');
    return data;
  }
}
