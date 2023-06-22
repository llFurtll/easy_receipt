import 'package:easy_receipt/features/core/ui/cores.dart';
import 'package:flutter/material.dart';
import 'package:screen_manager/screen_view.dart';

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
        child: Column(
          children: [
            _topo(context)
          ],
        )
      ),
    );
  }

  Widget _topo(BuildContext context) {
    return Row(
      children: [
        _container("N°"),
        const SizedBox(width: 25.0),
        const Text(
          "RECIBO",
          style: TextStyle(
            fontSize: 25.0,
            color: Cores.title
          ),
        )
      ],
    );
  }

  Widget _container(String name) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: TextFormField()
      )
    );
  }
}