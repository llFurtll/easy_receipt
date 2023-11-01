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

  @override
  Future<(Failure?, List<Recibo>?)> find() async {
    try {
      final result = await dataSource.find();
      return (null, result);
    } on OperationException catch (e) {
      return (OperationFailure(message: e.message), null);
    }
  }

  @override
  Future<(Failure?, void)> delete(Recibo recibo) async {
    try {
      await dataSource.delete(ReciboModel.fromEntity(recibo));
      return (null, null);
    } on OperationException catch (e) {
      return (OperationFailure(message: e.message), null);
    }
  }
}