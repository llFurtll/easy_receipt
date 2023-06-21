import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_create.dart';

abstract class DatabaseInfo<T> {
  Future<void> initDatabase();
  Future<T> getDatabase();
}

class DatabaseInfoImpl extends DatabaseInfo<Database> {
  @override
  Future<void> initDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), "recibo.db"),
      version: 1,
      onCreate: (db, version) => create(db),
    );
  }

  @override
  Future<Database> getDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), "recibo.db"));
  }
}