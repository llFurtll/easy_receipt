import '../../../core/domain/usecase.dart';
import '../../../core/error/failures.dart';
import '../entities/recibo.dart';
import '../repositories/recibo_repository.dart';

class GetDeletar extends UseCase<void, DeletarParams> {
  final ReciboRepository reciboRepository;

  GetDeletar(this.reciboRepository);

  @override
  Future<(Failure?, void)> call(params) async {
    return await reciboRepository.find();
  }
}

class DeletarParams {
  final Recibo recibo;

  const DeletarParams({
    required this.recibo
  });
}