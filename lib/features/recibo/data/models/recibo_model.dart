import '../../domain/entities/recibo.dart';

class ReciboModel extends Recibo {
  ReciboModel({
    required super.id,
    required super.numero,
    required super.valor,
    required super.nomePagador,
    required super.enderecoPagador,
    required super.valorPagador,
    required super.referente,
    required super.cidadeUf,
    required super.data,
    required super.nomeEmitente,
    required super.cpfRgCnpjEmitente,
    required super.enderecoEmitente,
    required super.assinatura
  });

  factory ReciboModel.fromEntity(Recibo recibo) {
    return ReciboModel(
      id: recibo.id,
      numero: recibo.numero,
      valor: recibo.valor,
      nomePagador: recibo.nomePagador,
      enderecoPagador: recibo.enderecoPagador,
      valorPagador: recibo.valorPagador,
      referente: recibo.referente,
      cidadeUf: recibo.cidadeUf,
      data: recibo.data,
      nomeEmitente: recibo.nomeEmitente,
      cpfRgCnpjEmitente: recibo.cpfRgCnpjEmitente,
      enderecoEmitente: recibo.enderecoEmitente,
      assinatura: recibo.assinatura
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "NUMERO": numero,
      "VALOR": valor,
      "NOME_PAGADOR": nomePagador,
      "ENDERECO_PAGADOR": enderecoPagador,
      "VALOR_PAGADOR": valorPagador,
      "REFERENTE": referente,
      "CIDADE_UF": cidadeUf,
      "DATA": data,
      "NOME_EMITENTE": nomeEmitente,
      "CPF_RG_CNPJ_EMITENTE": cpfRgCnpjEmitente,
      "ENDERECO_EMITENTE": enderecoEmitente,
      "ASSINATURA": assinatura
    };
  }
}