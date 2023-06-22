import 'package:flutter/material.dart';
import 'package:screen_manager/screen_controller.dart';

class SplashController extends ScreenController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed("/recibos");
    });
  }
}