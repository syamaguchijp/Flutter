import 'package:stack_trace/stack_trace.dart' show Trace;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

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
}