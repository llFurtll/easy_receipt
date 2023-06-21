import 'package:decimal/decimal.dart';

class Recibo {
  int? id;
  final int? numero;
  final Decimal? valor;
  final String? nomePagador;
  final String? enderecoPagador;
  final Decimal? valorPagador;
  final String? referente;
  final String? cidadeUf;
  final String? data;
  final String? nomeEmitente;
  final String? cpfRgCnpjEmitente;
  final String? enderecoEmitente;
  final String? assinatura;

  Recibo({
    required this.id,
    required this.numero,
    required this.valor,
    required this.nomePagador,
    required this.enderecoPagador,
    required this.valorPagador,
    required this.referente,
    required this.cidadeUf,
    required this.data,
    required this.nomeEmitente,
    required this.cpfRgCnpjEmitente,
    required this.enderecoEmitente,
    required this.assinatura
  });
}