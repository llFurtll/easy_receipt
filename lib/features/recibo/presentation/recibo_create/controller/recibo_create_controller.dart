import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../../core/ui/cores.dart';
import '../../../domain/usecases/get_insert_recibo.dart';
import '../injection/recibo_create_injection.dart';

class ReciboCreateController extends ScreenController {
  // CONSTRUTOR
  late final GetInsertRecibo getInsertRecibo;

  // KEYS
  final keyPad = GlobalKey<SfSignaturePadState>();

  // NOTIFIERS
  final assinatura = ValueNotifier<Uint8List?>(null);

  // CONTROLLERS
  final controllersTextField = <String, List<TextEditingController>>{
    "secao1": [ TextEditingController(), TextEditingController() ],
    "secao2": [ TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController() ],
    "secao3": [ TextEditingController(), TextEditingController(), TextEditingController(), TextEditingController() ],
    "secao4": [ TextEditingController(), TextEditingController(), TextEditingController() ]
  };

  // VARIAVEIS
  bool assinado = false;

  @override
  void onInit() {
    super.onInit();
    getInsertRecibo = ScreenInjection.of<ReciboCreateInjection>(context).getInsertRecibo;

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

  void salvar() {
    final message = validForm();
    if (message.isNotEmpty) {
      showDialog(
        context: context,
        useSafeArea: true,
        builder: (_) {
          return AlertDialog(
            title: const Text("Atenção", textAlign: TextAlign.center),
            content: Text(
              message,
              textAlign: TextAlign.justify,
            ),
            contentTextStyle: const TextStyle(
              fontSize: 18.0,
              color: Colors.black
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              )
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        }
      );

      return;
    }
  }

  String validForm() {
    for (String secao in ["secao1", "secao2", "secao3", "secao4"]) {
      for (TextEditingController edit in controllersTextField[secao] ?? []) {
        if (edit.text.isEmpty) {
          return "Preencha todos os campos do recibo!";
        }
      }
    }

    final assinaturaOk = validAssinatura();
    if (assinaturaOk.isNotEmpty) {
      return assinaturaOk;
    }

    return "";
  }

  String validAssinatura() {
    if (!assinado) {
      return "Realize a assinatura antes de salvar o recibo!";
    }

    return "";
  }
}