import 'package:flutter/material.dart';
import 'package:screen_manager/screen_view.dart';

import '../../../../core/ui/cores.dart';
import '../controller/recibo_create_controller.dart';
import '../injection/recibo_create_injection.dart';

class ReciboCreateScreen extends Screen {
  const ReciboCreateScreen({super.key});

  @override
  ReciboCreateInjection build(BuildContext context) {
    return ReciboCreateInjection(
      context: context,
      child: const ScreenBridge<ReciboCreateController, ReciboCreateInjection>(
        child: ReciboCreateView(),
      ),
    );
  }
}

class ReciboCreateView extends ScreenView<ReciboCreateController> {
  const ReciboCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.scaffold,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: controller.keyForm,
              child: ValueListenableBuilder(
                valueListenable: controller.isEdit,
                builder: (_, __, ___) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _primeiraSecao(context),
                      const SizedBox(height: 5.0),
                      _segundaSecao(),
                      const SizedBox(height: 10.0),
                      _terceiraSecao(),
                      const SizedBox(height: 5.0),
                      _quartaSecao(),
                      const SizedBox(height: 10.0),
                      _quintaSecao(context)
                    ],
                  );
                },
              )
          )
        )
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _primeiraSecao(BuildContext context) {
    return Row(
      children: [
        _input(
          name: "N°",
          onSaved: (value) => controller.formRecibo.numero = int.tryParse(value ?? "")
        ),
        const SizedBox(width: 25.0),
        const Text(
          "RECIBO",
          style: TextStyle(
            fontSize: 25.0,
            color: Cores.title
          ),
        ),
        const SizedBox(width: 25.0),
        _input(
          name: "Valor",
          onSaved: (value) => controller.formRecibo.valor = value,
          textInputType: TextInputType.number
        ),
      ],
    );
  }

  Widget _segundaSecao() {
    return _container(
      child: Column(
        children: [
          _inputText(
            name: "Recebi(emos) de",
            onSaved: (value) => controller.formRecibo.nomePagador = value
          ),
          const SizedBox(height: 15.0),
          _inputText(
            name: "Endereço",
            onSaved: (value) => controller.formRecibo.enderecoPagador = value
          ),
          const SizedBox(height: 15.0),
          _inputText(
            name: "A importância de",
            onSaved: (value) => controller.formRecibo.valorPagador = value
          ),
          const SizedBox(height: 15.0),
          _inputText(
            name: "Referente",
            onSaved: (value) => controller.formRecibo.referente = value
          ),
        ],
      )
    );
  }

  Widget _terceiraSecao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "E para maior clareza firmo(amos) o presente.",
          style: TextStyle(
            color: Cores.title,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 5.0),
        _container(
          child: Column(
            children: [
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _inputUnderlineBorder(
                    flex: 3,
                    onSaved: (value) => controller.formRecibo.cidadeUf = value
                  ),
                  const Text(","),
                  _inputUnderlineBorder(
                    flex: 1,
                    textInputType: TextInputType.number,
                    onSaved: (value) => controller.formRecibo.dia = value
                  ),
                  const SizedBox(width: 10.0),
                  const Text("de"),
                  _inputUnderlineBorder(
                    flex: 3,
                    onSaved: (value) => controller.formRecibo.mes = value
                  ),
                  const Text("de"),
                  _inputUnderlineBorder(
                    flex: 3,
                    textInputType: TextInputType.number,
                    onSaved: (value) => controller.formRecibo.ano = value
                  ),
                ],
              ),
              const SizedBox(height: 15.0)
            ],
          )
        ),
      ],
    );
  }

  Widget _quartaSecao() {
    return _container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 7,
                child: _inputText(
                  name: "Emitente",
                  onSaved: (value) => controller.formRecibo.nomeEmitente = value
                )
              ),
              Expanded(
                flex: 5,
                child: _inputText(
                  name: "CPF/RG/CNPJ",
                  textInputType: TextInputType.number,
                  onSaved: (value) => controller.formRecibo.cpfRgCnpjEmitente = value
                )
              )
            ],
          ),
          const SizedBox(height: 15.0),
          _inputText(
            name: "Endereço",
            onSaved: (value) => controller.formRecibo.enderecoEmitente = value
          ),
        ]
      )
    );
  }

  Widget _quintaSecao(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Assinatura",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          )
        ),
        const SizedBox(height: 5.0),
        _container(
          isPading: false,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            child: InkWell(
              onTap: () => controller.gerarAssinatura(context),
              child: ValueListenableBuilder(
                valueListenable: controller.assinatura,
                builder: (_ ,value, ___) {
                  if (!controller.assinado) {
                    return Ink(
                      width: double.infinity,
                      height: double.infinity,
                      child: const Center(
                        child: Text(
                          "Realizar assinatura",
                          style: TextStyle(
                            color: Cores.text,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ),
                    );
                  }

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    clipBehavior: Clip.antiAlias,
                    child: Image.memory(value!),
                  );
                },
              ),
            ),
          )
        )
      ],
    );
  }

  Widget _inputText({
    required String name,
    required Function(String? value) onSaved,
    TextInputType? textInputType
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: TextFormField(
            maxLines: null,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: UnderlineInputBorder()
            ),
            keyboardType: textInputType,
            onSaved: onSaved,
          ),
        )
      ],
    );
  }

  Widget _inputUnderlineBorder({
    required Function(String? value) onSaved,
    int flex = 1,
    TextInputType? textInputType
  }) {
    return Expanded(
      flex: flex,
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: UnderlineInputBorder(),
        ),
        keyboardType: textInputType,
        onSaved: onSaved,
      ),
    );
  }

  Widget _input({
    required Function(String? value) onSaved,
    required String name,
    TextInputType? textInputType,
  }) {
    return Expanded(
      child: _container(
        child: Row(
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 25.0),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none
                ),
                keyboardType: textInputType,
                onSaved: onSaved,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _container({required Widget child, bool isPading = true}) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: isPading ? const EdgeInsets.all(5.0) : null,
      decoration: BoxDecoration(
        border: Border.all(),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: child
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      backgroundColor: Cores.fab,
      onPressed: controller.salvar,
      child: const Icon(Icons.save),
    );
  }
}