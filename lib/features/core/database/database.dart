import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_create.dart';

abstract class DatabaseInfo {
  Future<Database> get database;
}

class DatabaseInfoImpl extends DatabaseInfo {
  Database? _database;

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "recibo.db"),
      version: 1,
      onCreate: (db, version) => create(db),
    );
  }

  @override
  Future<Database> get database async {
    if (_database == null) {
      await _initDatabase();
    }
    
    return _database!;
  }
}