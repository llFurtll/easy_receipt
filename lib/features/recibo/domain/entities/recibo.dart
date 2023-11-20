class Recibo {
  int? id;
  final int? numero;
  final String? valor;
  final String? nomePagador;
  final String? enderecoPagador;
  final String? valorPagador;
  final String? referente;
  final String? cidadeUf;
  final String? dia;
  final String? mes;
  final String? ano;
  final String? nomeEmitente;
  final String? cpfRgCnpjEmitente;
  final String? enderecoEmitente;
  final String? assinatura;
  final String? compartilhar;

  Recibo({
    required this.id,
    required this.numero,
    required this.valor,
    required this.nomePagador,
    required this.enderecoPagador,
    required this.valorPagador,
    required this.referente,
    required this.cidadeUf,
    required this.dia,
    required this.mes,
    required this.ano,
    required this.nomeEmitente,
    required this.cpfRgCnpjEmitente,
    required this.enderecoEmitente,
    required this.assinatura,
    required this.compartilhar
  });
}