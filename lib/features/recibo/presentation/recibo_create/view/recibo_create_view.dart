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
          child: Column(
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
          ),
        )
      ),
    );
  }

  Widget _primeiraSecao(BuildContext context) {
    return Row(
      children: [
        _input(name: "N°"),
        const SizedBox(width: 25.0),
        const Text(
          "RECIBO",
          style: TextStyle(
            fontSize: 25.0,
            color: Cores.title
          ),
        ),
        const SizedBox(width: 25.0),
        _input(name: "Valor", textInputType: TextInputType.number),
      ],
    );
  }

  Widget _segundaSecao() {
    return _container(
      child: Column(
        children: [
          _inputText(name: "Recebi(emos) de"),
          const SizedBox(height: 15.0),
          _inputText(name: "Endereço"),
          const SizedBox(height: 15.0),
          _inputText(name: "A importância de"),
          const SizedBox(height: 15.0),
          _inputText(name: "Referente"),
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
                    flex: 3
                  ),
                  const Text(","),
                  _inputUnderlineBorder(
                    flex: 1,
                    textInputType: TextInputType.number
                  ),
                  const SizedBox(width: 10.0),
                  const Text("de"),
                  _inputUnderlineBorder(
                    flex: 3,
                  ),
                  const Text("de"),
                  _inputUnderlineBorder(
                    flex: 3,
                    textInputType: TextInputType.number
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
                child: _inputText(name: "Emitente")
              ),
              Expanded(
                flex: 5,
                child:_inputText(name: "CPF/RG/CNPJ", textInputType: TextInputType.number)
              )
            ],
          ),
          const SizedBox(height: 15.0),
          _inputText(name: "Endereço"),
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
          ),
        )
      ],
    );
  }

  Widget _inputUnderlineBorder({
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
      ),
    );
  }

  Widget _input({
    required String name,
    TextInputType? textInputType
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
}