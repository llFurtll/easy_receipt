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
    required super.dia,
    required super.mes,
    required super.ano,
    required super.nomeEmitente,
    required super.cpfRgCnpjEmitente,
    required super.enderecoEmitente,
    required super.assinatura
  });

  factory ReciboModel.fromMap(Map item) {
    return ReciboModel(
      id: item['ID'],
      numero: item['NUMERO'],
      valor: item['VALOR']?.toString(),
      nomePagador: item['NOME_PAGADOR'],
      enderecoPagador: item['ENDERECO_PAGADOR'],
      valorPagador: item['VALOR_PAGADOR'],
      referente: item['REFERENTE'],
      cidadeUf: item['CIDADE_UF'],
      dia: item['DIA'],
      mes: item['MES'],
      ano: item['ANO'],
      nomeEmitente: item['NOME_EMITENTE'],
      cpfRgCnpjEmitente: item['CPF_RG_CNPJ_EMITENTE'],
      enderecoEmitente: item['ENDERECO_EMITENTE'],
      assinatura: item['ASSINATURA']
    );
  }

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
      dia: recibo.dia,
      mes: recibo.mes,
      ano: recibo.ano,
      nomeEmitente: recibo.nomeEmitente,
      cpfRgCnpjEmitente: recibo.cpfRgCnpjEmitente,
      enderecoEmitente: recibo.enderecoEmitente,
      assinatura: recibo.assinatura
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "NUMERO": numero,
      "VALOR": valor,
      "NOME_PAGADOR": nomePagador,
      "ENDERECO_PAGADOR": enderecoPagador,
      "VALOR_PAGADOR": valorPagador,
      "REFERENTE": referente,
      "CIDADE_UF": cidadeUf,
      "DIA": dia,
      "MES": mes,
      "ANO": ano,
      "NOME_EMITENTE": nomeEmitente,
      "CPF_RG_CNPJ_EMITENTE": cpfRgCnpjEmitente,
      "ENDERECO_EMITENTE": enderecoEmitente,
      "ASSINATURA": assinatura
    };
  }
}