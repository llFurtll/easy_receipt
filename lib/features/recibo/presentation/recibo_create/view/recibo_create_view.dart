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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _primeiraSecao(context),
              const SizedBox(height: 5.0),
              _segundaSecao()
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
          _inputText("Endereço"),
          _inputText("A importância de"),
          _inputText("Referente"),
        ],
      )
    );
  }

  Widget _inputText(String name) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder()
            ),
          ),
        )
      ],
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