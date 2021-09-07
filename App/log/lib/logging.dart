import 'package:stack_trace/stack_trace.dart' show Trace;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class Logging {

  static bool writeMode = false;

  static void d(message) {
    const level = 1;
    final frames = Trace.current(level).frames;
    final frame = frames.isEmpty ? null : frames.first;
    String text = '$frame $message';
    print(text);

    if (writeMode) {
      write(text);
      read().then((String ans) {
        print("$ans");
      });
    }
  }

  static void write(String text) async {
    print("write $text");
    getFilePath().then((File file) {
      file.writeAsString(text);
    });
  }

  static Future<String> read() async {
    final file = await getFilePath();
    return await file.readAsString();
  }

  static  Future<File> getFilePath() async {
    final directory = await getTemporaryDirectory(); // getApplicationDocumentsDirectory()
    return File(directory.path + '/' + "testlog.txt");
  }
}