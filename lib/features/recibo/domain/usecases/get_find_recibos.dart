import '../../../core/domain/usecase.dart';
import '../../../core/error/failures.dart';
import '../entities/recibo.dart';
import '../repositories/recibo_repository.dart';

class GetFindRecibos extends UseCase<List<Recibo>?, FindRecibosParams> {
  final ReciboRepository reciboRepository;

  GetFindRecibos(this.reciboRepository);

  @override
  Future<(Failure?, List<Recibo>?)> call(params) async {
    return await reciboRepository.find(params.text);
  }
}

class FindRecibosParams {
  final String text;

  const FindRecibosParams({
    required this.text
  });
}