import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:csv/csv.dart';

class Storage {
  List<List<dynamic>> rows = List<List<dynamic>>();

  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/Flutter/desktop_app/db.csv');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(List<Map<String, String>> listData) async {
    final file = await localFile;
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
