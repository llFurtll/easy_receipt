import 'package:flutter/material.dart';
import 'package:screen_manager/screen_controller.dart';
import 'package:screen_manager/screen_injection.dart';
import 'package:screen_manager/screen_view.dart';

import '../controller/splash_controller.dart';
import '../injection/splash_injection.dart';

class SplashScreen extends Screen {
  static const route = "/splash";

  const SplashScreen({super.key});

  @override
  ScreenInjection<ScreenController> build(BuildContext context) {
    return SplashInjection(
      child: const ScreenBridge<SplashController, SplashInjection>(
        child: SplashView()
      )
    );
  }
}

class SplashView extends ScreenView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Image.asset(
          "lib/assets/logo.png",
          width: 250.0,
          height: 250.0,
        ),
      ),
    );
  }
}