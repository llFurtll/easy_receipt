import 'dart:io';

import 'package:easy_receipt/features/recibo/domain/entities/recibo.dart';
import 'package:flutter/material.dart';
import 'package:screen_manager/screen_view.dart';

import '../../../../core/ui/cores.dart';
import '../controller/recibo_list_controller.dart';
import '../injection/recibo_list_injection.dart';

class ReciboListScreen extends Screen {
  const ReciboListScreen({super.key});

  @override
  ReciboListInjection build(BuildContext context) {
    return ReciboListInjection(
      context: context,
      child: const ScreenBridge<ReciboListController, ReciboListInjection>(
        child: ReciboListView(),
      )
    );
  }
}

class ReciboListView extends ScreenView<ReciboListController> {
  const ReciboListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.scaffold,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFab(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 10.0,
      backgroundColor: Cores.appBar,
      toolbarHeight: 130.0,
      title: const Text(
        "Recibos",
        style: TextStyle(
          color: Colors.white
        ),
      ),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35.0
      ),
      flexibleSpace: const Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: Icon(
            Icons.receipt_long_outlined,
            size: 120.0,
            color: Colors.white,
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0)
        )
      ),
    );
  }

  Widget _buildBody() {
    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, value, child) {
        if (value) return const Center(child: CircularProgressIndicator());

        if (controller.isError) {
          return Center(
            child: Text(
              controller.messageError,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Cores.text,
                fontSize: 35.0
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          );
        }

        final lista = controller.recibos;
        final sizeList = lista.length;

        if (sizeList == 0) {
          return const Center(
            child: Text(
              "Você não possuí nenhum recibo!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Cores.text,
                fontSize: 35.0
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (context, index) => _buildCard(lista[index], context),
          separatorBuilder: (context, index) => const SizedBox(height: 15.0,),
          itemCount: sizeList
        );
      },
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: Cores.fab,
      onPressed: controller.newRecibo,
      child: const Icon(Icons.add),
    );
  }

  Widget _buildCard(Recibo recibo, BuildContext context) {
    return Card(
      elevation: 10,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.only(left: 10, right: 10),
        textColor: Colors.black,
        iconColor: Colors.grey,
        shape: InputBorder.none,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle("Nº: ", "${recibo.numero}"),
            _buildTitle("Valor: ", "${recibo.valor}")
          ],
        ),
        children: [
          InkWell(
            onTap: () => controller.showRecibo(recibo),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: _buildTitle(
                      "Informações do pagador",
                      ""
                    ),
                  ),
                  _spacer(),
                  _buildTitle(
                    "Recebi(emos) de: ",
                    "${recibo.nomePagador}"
                  ),
                  _buildTitle(
                    "Endereço: " ,
                    "${recibo.enderecoPagador}"
                  ),
                  _buildTitle(
                    "A importância de: ",
                    "${recibo.valorPagador}"
                  ),
                  _buildTitle(
                    "Referente: ",
                    "${recibo.referente}"
                  ),
                  _spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: _buildTitle(
                      "Data/Local do recibo",
                      ""
                    ),
                  ),
                  _spacer(),
                  _buildTitle(
                    "Cidade/Estado: ",
                    "${recibo.cidadeUf}"
                  ),
                  _buildTitle(
                    "Dia: ",
                    "${recibo.dia}"
                  ),
                  _buildTitle(
                    "Mês: ",
                    "${recibo.mes}",
                  ),
                  _buildTitle(
                    "Ano: ",
                    "${recibo.ano}"
                  ),
                  _spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: _buildTitle(
                      "Informações do emitente",
                      ""
                    ),
                  ),
                  _spacer(),
                  _buildTitle(
                    "Emitente: ",
                    "${recibo.nomeEmitente}"
                  ),
                  _buildTitle(
                    "CPF/RG/CNPJ: ",
                    "${recibo.cpfRgCnpjEmitente}"
                  ),
                  _buildTitle(
                    "Endereço: ",
                    "${recibo.enderecoEmitente}"
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: [
                        _buildAssinatura(context, recibo),
                        _buildDeletar(context, recibo),
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      )
    );
  }

  Widget _buildTitle(String title, String content) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          TextSpan(
            text: content
          )
        ]
      ),
      maxLines: null,
    );
  }

  Widget _buildAssinatura(BuildContext context, Recibo recibo) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Cores.primary
      ),
      onPressed: () => showAssinatura(context, recibo),
      child: const Text("Ver assinatura"),
    );
  }

  Widget _buildDeletar(BuildContext context, Recibo recibo) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      onPressed: () => deletarAssinatura(context, recibo),
      child: const Text("Deletar"),
    );
  }

  void showAssinatura(BuildContext context, Recibo recibo) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Image.file(File(recibo.assinatura!)),
        );
      }
    );
  }

  void deletarAssinatura(BuildContext context, Recibo recibo) async {
    final deletar = await showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Tem certeza?"),
          content: Text("Realmente deseja deletar o recibo número: ${recibo.numero}?"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Não")
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Sim")
            ),
          ],
        );
      }
    );

    if (deletar ?? false) {
      controller.deletarRecibo(recibo);
    }
  }

  Widget _spacer() {
    return const SizedBox(height: 5.0);
  }
}