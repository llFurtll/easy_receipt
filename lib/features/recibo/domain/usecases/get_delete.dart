import 'dart:io';

import '../../../core/domain/usecase.dart';
import '../../../core/error/failures.dart';
import '../entities/recibo.dart';
import '../repositories/recibo_repository.dart';

class GetDeletar extends UseCase<void, DeletarParams> {
  final ReciboRepository reciboRepository;

  GetDeletar(this.reciboRepository);

  @override
  Future<(Failure?, void)> call(params) async {
    final (error, _) = await reciboRepository.delete(params.recibo);

    if (error == null) {
      final assinatura = File(params.recibo.assinatura!);
      final directoryPath = assinatura.parent;
      directoryPath.deleteSync(recursive: true);
    }

    return (error, null);
  }
}

class DeletarParams {
  final Recibo recibo;

  const DeletarParams({
    required this.recibo
  });
}