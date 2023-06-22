import '../../../core/domain/usecase.dart';
import '../../../core/error/failures.dart';
import '../entities/recibo.dart';
import '../repositories/recibo_repository.dart';

class GetInsertRecibo extends UseCase<Recibo?, InsertReciboParams> {
  final ReciboRepository repository;

  GetInsertRecibo(this.repository);

  @override
  Future<(Failure?, Recibo?)> call(InsertReciboParams params) async {
    return await repository.insert(params.recibo);
  }
}

class InsertReciboParams {
  final Recibo recibo;

  const InsertReciboParams({
    required this.recibo
  });
}