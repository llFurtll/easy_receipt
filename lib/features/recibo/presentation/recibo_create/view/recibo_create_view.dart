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
              _quartaSecao()
            ],
          ),
        )
      ),
    );
  }

  Widget _primeiraSecao(BuildContext context) {
    return Row(
      children: [
        _input("N°"),
        const SizedBox(width: 25.0),
        const Text(
          "RECIBO",
          style: TextStyle(
            fontSize: 25.0,
            color: Cores.title
          ),
        ),
        const SizedBox(width: 25.0),
        _input("Valor"),
      ],
    );
  }

  Widget _segundaSecao() {
    return _container(
      child: Column(
        children: [
          _inputText("Recebi(emos) de"),
          const SizedBox(height: 15.0),
          _inputText("Endereço"),
          const SizedBox(height: 15.0),
          _inputText("A importância de"),
          const SizedBox(height: 15.0),
          _inputText("Referente"),
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
                  _inputUnderlineBorder(width: 10.0, flex: 1),
                  const SizedBox(width: 10.0),
                  const Text("de"),
                  _inputUnderlineBorder(
                    flex: 3,
                  ),
                  const Text("de"),
                  _inputUnderlineBorder(
                    flex: 3,
                    width: 10.0
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
                child: _inputText("Emitente")
              ),
              Expanded(
                flex: 5,
                child:_inputText("CPF/RG/CNPJ")
              )
            ],
          ),
          const SizedBox(height: 15.0),
          _inputText("Endereço"),
        ]
      )
    );
  }

  Widget _inputText(String name) {
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
          ),
        )
      ],
    );
  }

  Widget _inputUnderlineBorder({double? width, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }

  Widget _input(String name) {
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _container({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: child
    );
  }
}