import '../../../core/database/database.dart';
import '../models/recibo_model.dart';

abstract class ReciboLocalDataSource {
  Future<List<ReciboModel>> find();
  Future<ReciboModel> insert(ReciboModel recibo);
}

class ReciboLocalDataSurceImpl extends ReciboLocalDataSource {
  final DatabaseInfo databaseInfo;

  ReciboLocalDataSurceImpl(this.databaseInfo);

  @override
  Future<List<ReciboModel>> find() async {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  Future<ReciboModel> insert(ReciboModel recibo) async {
    // TODO: implement insert
    throw UnimplementedError();
  }
}