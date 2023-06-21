import 'package:sqflite/sqflite.dart';

Future<void> create(Database database) async {
  await _createTable(
    database,
    "RECIBO",
    {
      "ID": "INTEGER PRIMARY KEY,",
      "NUMERO": "INT NOT NULL,",
      "VALOR": "REAL NOT NULL,",
      "NOME_PAGADOR": "TEXT NOT NULL,",
      "ENDERECO_PAGADOR": "TEXT NOT NULL,",
      "VALOR_PAGADOR": "TEXT NOT NULL,",
      "REFERENTE": "TEXT NOT NULL,",
      "CIDADE_UF": "TEXT NOT NULL,",
      "DATA": "DATETIME NOT NULL,",
      "NOME_EMITENTE": "TEXT NOT NULL,",
      "CPF_RG_CNPJ_EMITENTE": "TEXT NOT NULL,",
      "ENDERECO_EMITENTE": "TEXT NOT NULL,",
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