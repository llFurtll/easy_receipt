import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/ui/cores.dart';
import '../../../domain/entities/recibo.dart';
import '../../../domain/usecases/get_insert_recibo.dart';
import '../injection/recibo_create_injection.dart';

class ReciboCreateController extends ScreenController {
  // CONSTRUTOR
  late final GetInsertRecibo getInsertRecibo;

  // KEYS
  final keyPad = GlobalKey<SfSignaturePadState>();
  final keyForm = GlobalKey<FormState>();
  final keyBoundary = GlobalKey();

  // NOTIFIERS
  final assinatura = ValueNotifier<Uint8List?>(null);
  final isEdit = ValueNotifier<bool>(false);

  // VARIAVEIS
  bool assinado = false;
  FormRecibo formRecibo = FormRecibo();

  @override
  void onInit() {
    super.onInit();
    getInsertRecibo = ScreenInjection.of<ReciboCreateInjection>(context).getInsertRecibo;

    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      isEdit.value = true;
      formRecibo = FormRecibo.fromEntity(arguments as Recibo);
      assinado = true;
      assinatura.value = File(formRecibo.assinatura!).readAsBytesSync();
    }

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
    if (isEdit.value) {
      return;
    }

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
                  backgroundColor: Cores.primary,
                  foregroundColor: Colors.white
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
                  backgroundColor: Cores.primary,
                  foregroundColor: Colors.white
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
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white
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

  void salvar() async {
    final message = validForm();
    if (message.isNotEmpty) {
      showMessage(message);
      return;
    }

    final image = await saveAssinaturaAndImage();
    final (success, paths) = image;

    if (!success) {
      showMessage("Não foi possível salvar a imagem da assinatura, por favor tente novamente!");
      return;
    }

    final (pathAssinatura, pathShare) = paths;
    formRecibo.assinatura = pathAssinatura;
    formRecibo.compartilhar = pathShare;

    final result = await getInsertRecibo(InsertReciboParams(recibo: formRecibo.toRecibo()));
    final (error, _) = result;
    if (error != null) {
      showMessage(error.message);
      return;
    }

    showMessage("Recibo cadastrado com sucesso!");
    isEdit.value = true;
  }

  String validForm()  {
    keyForm.currentState?.save();

    if (!formRecibo.isValid()) {
      return "Preencha todos os campos do recibo!";
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

  Future<(bool, (String, String))> saveAssinaturaAndImage() async {
    try {
      const nameFile = "assinatura.png";
      final pathDocuments = await getApplicationDocumentsDirectory();
      final nameFolder = const Uuid().v1();

      File file = File("${pathDocuments.path}/$nameFolder/$nameFile");
      file.createSync(recursive: true);
      if (assinatura.value != null) {
        file.writeAsBytesSync(assinatura.value!);
      }

      const nameShare = "image.png";
      File shareFile = File("${pathDocuments.path}/$nameFolder/$nameShare");
      file.createSync();
      final boundary = keyBoundary.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final imageBytes = byteData?.buffer.asUint8List();

      if (imageBytes == null) {
        throw Exception();
      }

      shareFile.writeAsBytesSync(imageBytes);

      return (true, (file.path, shareFile.path));
    } catch (e) {
      return (false, ("", ""));
    }
  }

  void showMessage(String message) {
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
  }
}

class FormRecibo {
  int? numero;
  String? valor;
  String? nomePagador;
  String? enderecoPagador;
  String? valorPagador;
  String? referente;
  String? cidadeUf;
  String? dia;
  String? mes;
  String? ano;
  String? nomeEmitente;
  String? cpfRgCnpjEmitente;
  String? enderecoEmitente;
  String? assinatura;
  String? compartilhar;

  FormRecibo({
    this.numero,
    this.valor,
    this.nomePagador,
    this.enderecoPagador,
    this.valorPagador,
    this.referente,
    this.cidadeUf,
    this.dia,
    this.mes,
    this.ano,
    this.nomeEmitente,
    this.cpfRgCnpjEmitente,
    this.enderecoEmitente,
    this.assinatura,
    this.compartilhar
  });

  factory FormRecibo.fromEntity(Recibo recibo) {
    return FormRecibo(
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
      assinatura: recibo.assinatura,
      compartilhar: recibo.compartilhar
    );
  }

  bool isValid() {
    return (
      numero != null &&
      valor != null &&
      nomePagador != null &&
      enderecoPagador != null &&
      valorPagador != null &&
      referente != null &&
      cidadeUf != null &&
      dia != null &&
      mes != null &&
      ano != null &&
      nomeEmitente != null &&
      cpfRgCnpjEmitente != null &&
      enderecoEmitente != null
    );
  }

  Recibo toRecibo() {
    return Recibo(
      id: 0,
      numero: numero,
      valor: valor,
      nomePagador: nomePagador,
      enderecoPagador: enderecoPagador,
      valorPagador: valorPagador,
      referente: referente,
      cidadeUf: cidadeUf,
      dia: dia,
      mes: mes,
      ano: ano,
      nomeEmitente: nomeEmitente,
      cpfRgCnpjEmitente: cpfRgCnpjEmitente,
      enderecoEmitente: enderecoEmitente,
      assinatura: assinatura,
      compartilhar: compartilhar
    );
  }
}