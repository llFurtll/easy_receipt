import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';

import '../../../domain/entities/recibo.dart';
import '../../../domain/usecases/get_delete.dart';
import '../../../domain/usecases/get_find_recibos.dart';
import '../injection/recibo_list_injection.dart';

class ReciboListController extends ScreenController {
  late final GetFindRecibos getFindRecibos;
  late final GetDeletar getDeletar;

  // NOTIFIERS
  final isLoading = ValueNotifier(true);

  // VARIÁVEIS
  final recibos = <Recibo>[];
  bool isError = false;
  String messageError = "";
  Timer? debounce;

  @override
  void onInit() {
    super.onInit();
    getFindRecibos = ScreenInjection.of<ReciboListInjection>(context).getFindRecibos;
    getDeletar = ScreenInjection.of<ReciboListInjection>(context).getDeletar;

    _loadLista();
  }

  @override
  void onClose() {
    debounce?.cancel();
    super.onClose();
  }

  void _setLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }

  void _loadLista({String text = ""}) async {
    recibos.clear();

    _setLoading(true);

    final response =  await getFindRecibos(FindRecibosParams(text: text));
    final (error, result) = response;
    if (error != null) {
      isError = true;
      messageError = error.message;
      _setLoading(false);
      return;
    }

    recibos.addAll(result!);

    _setLoading(false);
  }

  void newRecibo() {
    Navigator.of(context).pushNamed("/recibo").then((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp
      ]);
      _loadLista();
    });
  }

  void showRecibo(Recibo recibo) {
    Navigator.of(context).pushNamed("/recibo", arguments: recibo).then((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp
      ]);
    });
  }

  void deletarRecibo(Recibo recibo) async {
    _setLoading(true);

    final response = await getDeletar(DeletarParams(recibo: recibo));
    final (error, _) = response;

    if (error != null) {
      _setLoading(false);
      showMessage(error.message);
    }

    _loadLista();
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

  void onSearch(String text) async {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      _loadLista(text: text);
    });
  }
}