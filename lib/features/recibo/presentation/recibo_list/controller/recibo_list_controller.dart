import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';

import '../../../domain/entities/recibo.dart';
import '../../../domain/usecases/get_find_recibos.dart';
import '../injection/recibo_list_injection.dart';

class ReciboListController extends ScreenController {
  late final GetFindRecibos getFindRecibos;

  // NOTIFIERS
  final isLoading = ValueNotifier(true);

  // VARIÁVEIS
  final recibos = <Recibo>[];
  bool isError = false;
  String messageError = "";

  @override
  void onInit() {
    super.onInit();
    getFindRecibos = ScreenInjection.of<ReciboListInjection>(context).getFindRecibos;

    Future.value()
      .then((_) => getFindRecibos(const NoParamsFind()))
      .then((response) {
        final (error, result) = response;
        if (error != null) {
          isError = true;
          messageError = error.message;
          return;
        }

        recibos.addAll(result!);
      })
      .then((_) => _setLoading(false));
  }

  void _setLoading(bool isLoading) {
    this.isLoading.value = isLoading;
  }

  void newRecibo() {
    Navigator.of(context).pushNamed("/recibo").then((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp
      ]);
    });
  }

  void showRecibo(Recibo recibo) {
    Navigator.of(context).pushNamed("/recibo", arguments: recibo).then((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp
      ]);
    });
  }
}