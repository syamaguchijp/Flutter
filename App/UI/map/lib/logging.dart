import 'package:stack_trace/stack_trace.dart' show Trace;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Logging {

  static bool dumpLog = true;
  static bool writeMode = false;

  static void d(message) {
    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;
    String text = '$frame $message';
    if (dumpLog) {
      print(text);
    }
    if (writeMode) {
      write(text);
    }
  }

  static void write(String text) {
    print("write $text");
    getFilePath().then((File file) {
      file.writeAsStringSync(text + "\n", mode: FileMode.append);
    });
  }

  static Future<String> read() async {
    final file = await getFilePath();
    return await file.readAsString();
  }

  static Future<File> getFilePath() async {
    final directory = await getTemporaryDirectory(); // getApplicationDocumentsDirectory()
    return File(directory.path + '/' + "testlog.txt");
  }

  static Future<void> deleteFile() async {
    try {
      final file = await getFilePath();
      await file.delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //region: 位置情報系ファイル

  static Future<void> writeLocation(Position pt) async {

    String txt = "${pt.latitude},${pt.longitude}\n";
    print("writeLocation $txt");
    await getLocationFilePath().then((File file) {
      file.writeAsString(txt, mode: FileMode.append);
    });
  }

  static Future<List<LatLng>> readLocation() async {

    List<LatLng> ans = [];
    final file = await getLocationFilePath();
    await file.readAsLines().then((lines) {
        lines.forEach((l) {
          print("readLocation ${l}");
          try {
            List<String> temp = l.split(",");
            if (temp.length == 2) {
              ans.add(LatLng(double.parse(temp[0]), double.parse(temp[1])));
            }
          } catch(e) {
            print(e.toString());
          }
        });
    });
    return await ans;
  }

  static  Future<File> getLocationFilePath() async {

    final directory = await getTemporaryDirectory(); // getApplicationDocumentsDirectory()
    return File(directory.path + '/' + "locationlog.txt");
  }

  static Future<void> deleteLocationFile() async {
    try {
      final file = await getLocationFilePath();
      await file.delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //endregion
}