import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';

class DatabaseInstance {
  /// Create and return sqlite instance
  static Future<Database> createInstance() async {
    WidgetsFlutterBinding.ensureInitialized();
    final String path = join(await getDatabasesPath(), 'mozika.db');
    debugPrint(path);
    return openDatabase(join(await getDatabasesPath(), 'mozika.db'),
        onCreate: ((db, version) {
      return db.execute(Constants.sqliteInitTable);
    }), version: 1);
  }
}
