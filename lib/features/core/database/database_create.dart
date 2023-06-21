import 'package:sqflite/sqflite.dart';

Future<void> create(Database database) async {
  await _createTable(
    database,
    "RECIBO",
    {
      "ID": "INTEGER PRIMARY KEY,",
      "NUMERO": "INT NOT NULL,",
      "VALOR": "REAL NOT NULL,",
      "NOMEPAGADOR": "TEXT NOT NULL,",
      "ENDERECOPAGADOR": "TEXT NOT NULL,",
      "VALORPAGADOR": "TEXT NOT NULL,",
      "REFERENTE": "TEXT NOT NULL,",
      "DATA": "DATETIME NOT NULL,",
      "NOMEEMITENTE": "TEXT NOT NULL,",
      "CPFRGCNPJEMITENTE": "TEXT NOT NULL,",
      "ENDERECOEMITENTE": "TEXT NOT NULL,",
      "ASSINATURA": "TEXT NOT NULL)",
    }
  );
}

Future<void> _createTable(Database db, String table, Map<String, String> columns) async {
  String sql = "CREATE TABLE IF NOT EXISTS $table (\n";
  for (var key in columns.keys) {
    sql += "$key ${columns[key]}";
  }
  await db.execute(sql);
}