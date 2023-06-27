import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

import '../../../../core/ui/cores.dart';

class ReciboCreateController extends ScreenController {
  // KEYS
  final keyPad = GlobalKey<SfSignaturePadState>();

  // NOTIFIERS
  final assinatura = ValueNotifier<Uint8List?>(null);
  bool assinado = false;

  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft
    ]);
  }

  Future<void> _generateAssinatura() async {
    try {
      final ui.Image image = await keyPad.currentState!.toImage();
      final ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      if (bytes != null) {
        assinatura.value = bytes.buffer.asUint8List();
      }
    } catch (_) {
      
    }
  }

  void gerarAssinatura(BuildContext innerContext) {
    assinado = false;

    showDialog(
      barrierDismissible: false,
      context: innerContext,
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0)
            ),
            width: MediaQuery.of(innerContext).size.width * 0.5,
            height: MediaQuery.of(innerContext).size.height * 0.5,
            child: SfSignaturePad(
              key: keyPad,
              onDrawStart: () {
                assinado = true;
                return false;
              },
              backgroundColor: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Cores.primary
                ),
                onPressed: () {
                  _generateAssinatura()
                    .then((_) => Navigator.of(innerContext).pop());
                },
                child: const Text("Salvar assinatura"),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Cores.primary
                ),
                onPressed: () {
                  keyPad.currentState!.clear();
                  assinado = false;
                },
                child: const Text("Limpar"),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                onPressed: () {
                  Navigator.of(innerContext).pop();
                },
                child: const Text("Fechar"),
              ),
            ],
          )
        ],
      )
    );
  }
}