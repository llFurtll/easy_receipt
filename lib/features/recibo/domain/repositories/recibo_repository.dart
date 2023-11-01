import '../../../core/error/failures.dart';
import '../entities/recibo.dart';

abstract class ReciboRepository {
  Future<(Failure?, Recibo?)> insert(Recibo recibo);
  Future<(Failure?, List<Recibo>?)> find();
  Future<(Failure?, void)> delete(Recibo recibo);
}