import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInstance {
  /// Create sqlite instance
  static Future<Database> createInstance() async {
    WidgetsFlutterBinding.ensureInitialized();
    final String path = join(await getDatabasesPath(), 'mozika.db');
    debugPrint(path);
    return openDatabase(join(await getDatabasesPath(), 'mozika.db'),
        onCreate: ((db, version) {
      return db.execute(
          "CREATE TABLE audio(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, folder TEXT, uri_path TEXT)");
    }), version: 1);
  }
}
