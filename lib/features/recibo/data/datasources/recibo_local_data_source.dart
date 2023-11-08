import '../../../core/database/database.dart';
import '../../../core/error/exceptions.dart';
import '../models/recibo_model.dart';

abstract class ReciboLocalDataSource {
  Future<List<ReciboModel>> find(String text);
  Future<ReciboModel> insert(ReciboModel recibo);
  Future<void> delete(ReciboModel recibo);
}

class ReciboLocalDataSurceImpl extends ReciboLocalDataSource {
  final DatabaseInfo databaseInfo;
  final String table = "RECIBO";

  ReciboLocalDataSurceImpl(this.databaseInfo);

  @override
  Future<List<ReciboModel>> find(String text) async {
    try {
      String where = "";
      if (text.isNotEmpty) {
        where += "NUMERO LIKE ? OR NOME_EMITENTE LIKE ? OR CPF_RG_CNPJ_EMITENTE LIKE ? OR NOME_PAGADOR LIKE ? OR REFERENTE LIKE ? OR VALOR_PAGADOR LIKE ?";
      }

      final db = await databaseInfo.database;
      final result = await db.query(
        table, orderBy: "NUMERO DESC",
        where: where.isNotEmpty ? where : null,
        whereArgs: where.isNotEmpty ? ['%$text%', '%$text%', '%$text%', '%$text%', '%$text%', '%$text%'] : null
      );
      final response = <ReciboModel>[];
      for (Map item in result) {
        response.add(ReciboModel.fromMap(item));
      }

      return response;
    } catch (_) {
      throw const OperationException("erro-operation");
    }
  }

  @override
  Future<ReciboModel> insert(ReciboModel recibo) async {
    try {
      final db = await databaseInfo.database;
      final result = await db.insert(table, recibo.toJson());
      if (result == 0) {
        throw const InsertException("erro-insert-recibo");
      }

      return recibo;
    } on InsertException {
      rethrow;
    } catch (_) {
      throw const OperationException("erro-operation");
    }
  }

  @override
  Future<void> delete(ReciboModel recibo) async {
    try {
      final db = await databaseInfo.database;
      final result = await db.delete(table, where: "NUMERO = ?", whereArgs: [ recibo.numero ]);

      if (result <= 0) {
        throw Exception();
      }
    } catch (_) {
      throw const OperationException("erro-operation");
    }
  }
}