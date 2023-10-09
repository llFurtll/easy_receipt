import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screen_manager/screen_controller.dart';

class ReciboListController extends ScreenController {
  // NOTIFIERS
  final isLoading = ValueNotifier(true);

  // VARIÁVEIS
  final recibos = [];

  @override
  void onInit() {
    super.onInit();
    Future.value()
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
}