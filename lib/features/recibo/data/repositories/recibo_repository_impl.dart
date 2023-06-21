import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../domain/entities/recibo.dart';
import '../../domain/repositories/recibo_repository.dart';
import '../datasources/recibo_local_data_source.dart';
import '../models/recibo_model.dart';

class ReciboRepositoryImpl extends ReciboRepository {
  final ReciboLocalDataSource dataSource;

  ReciboRepositoryImpl(this.dataSource);

  @override
  Future<(Failure?, Recibo?)> insert(Recibo recibo) async {
    try {
      final result = await dataSource.insert(ReciboModel.fromEntity(recibo));
      return (null, result);
    } on InsertException catch (e) {
      return (InsertFailure(message: e.message), null);
    } on OperationException catch (e) {
      return (OperationFailure(message: e.message), null);
    }
  }
}