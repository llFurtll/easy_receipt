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
    } on InsertException catch (_) {
      return (InsertFailure(message: "Não foi possível inserir o recibo, por favor tente novamente!"), null);
    } on OperationException catch (_) {
      return (OperationFailure(message: "Falha na operação, por favor tente novamente!"), null);
    }
  }

  @override
  Future<(Failure?, List<Recibo>?)> find(String text) async {
    try {
      final result = await dataSource.find(text);
      return (null, result);
    } on OperationException catch (_) {
      return (OperationFailure(message: "Falha na operação, por favor tente novamente!"), null);
    }
  }

  @override
  Future<(Failure?, void)> delete(Recibo recibo) async {
    try {
      await dataSource.delete(ReciboModel.fromEntity(recibo));
      return (null, null);
    } on OperationException catch (_) {
      return (OperationFailure(message: "Falha na operação, por favor tente novamente!"), null);
    }
  }
}