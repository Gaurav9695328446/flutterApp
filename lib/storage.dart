import 'dart:io';
import 'package:csv/csv.dart';

class Storage {
  Future<String> get localPath async {
    Directory dir = new Directory('C:/Users/gaura/Documents');
    return dir.path;
  }

  Future<File> cleanFile(csvFileName) async {
    final path = await localPath;
    final File file = File('$path/$csvFileName');
    return file.writeAsString('');
  }

  Future<File> writeData(
      List<Map<String, String>> listData, csvFileName) async {
    List<List<dynamic>> rows = List<List<dynamic>>();
    final path = await localPath;
    final File file = File('$path/$csvFileName');

    for (int i = 0; i < listData.length + 1; i++) {
      List<dynamic> row = List();
      if (i == 0) {
        row.add('Tran No.');
        row.add('Lane');
        row.add('Vehicle No.');
        row.add('Trans Type');
        row.add('Amount');
        row.add('Vehicle Type');
      } else {
        row.add(listData[i - 1]['transNo']);
        row.add(listData[i - 1]['lane']);
        row.add(listData[i - 1]['vehicleNo']);
        row.add(listData[i - 1]['transType']);
        row.add(listData[i - 1]['amount']);
        row.add(listData[i - 1]['vehicleType']);
      }
      rows.add(row);
    }
    String csv = const ListToCsvConverter().convert(rows);
    return file.writeAsString(csv);
  }
}
