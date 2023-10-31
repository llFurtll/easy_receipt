import '../../../core/database/database.dart';
import '../../../core/error/exceptions.dart';
import '../models/recibo_model.dart';

abstract class ReciboLocalDataSource {
  Future<List<ReciboModel>> find();
  Future<ReciboModel> insert(ReciboModel recibo);
}

class ReciboLocalDataSurceImpl extends ReciboLocalDataSource {
  final DatabaseInfo databaseInfo;
  final String table = "RECIBO";

  ReciboLocalDataSurceImpl(this.databaseInfo);

  @override
  Future<List<ReciboModel>> find() async {
    try {
      final db = await databaseInfo.database;
      final result = await db.query(table, orderBy: "NUMERO DESC");
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
}