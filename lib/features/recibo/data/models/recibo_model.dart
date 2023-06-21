import '../../domain/entities/recibo.dart';

class ReciboModel extends Recibo {
  const ReciboModel({
    required super.numero,
    required super.valor,
    required super.nomePagador,
    required super.enderecoPagador,
    required super.valorPagador,
    required super.referente,
    required super.data,
    required super.nomeEmitente,
    required super.cpfRgCnpjEmitente,
    required super.enderecoEmitente,
    required super.assinatura
  });
}