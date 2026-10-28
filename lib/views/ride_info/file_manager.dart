// ----------------------------------------------------------------------
// File helper
//
// Small helper for local files used by the location callback.
// ----------------------------------------------------------------------
import 'dart:io';

import 'package:path_provider/path_provider.dart';

// >>> START  class FileManager
class FileManager {
  // >>> START  FileManager.writeToLogFile()  -  write to log file
  static Future<void> writeToLogFile(String log) async {
    final file = await _getTempLogFile();
    await file.writeAsString(log, mode: FileMode.append);
  }
  // <<< END    FileManager.writeToLogFile()

  // >>> START  FileManager.readLogFile()  -  read log file
  static Future<String> readLogFile() async {
    final file = await _getTempLogFile();
    return file.readAsString();
  }
  // <<< END    FileManager.readLogFile()

  // >>> START  FileManager._getTempLogFile()  -  get temp log file
  static Future<File> _getTempLogFile() async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/log.txt');
    if (!await file.exists()) {
      await file.writeAsString('');
    }
    return file;
  }
  // <<< END    FileManager._getTempLogFile()

  // >>> START  FileManager.clearLogFile()  -  clear log file
  static Future<void> clearLogFile() async {
    final file = await _getTempLogFile();
    await file.writeAsString('');
  }
  // <<< END    FileManager.clearLogFile()
}
// <<< END    class FileManager
