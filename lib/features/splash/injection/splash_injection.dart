import 'package:flutter/material.dart';
import 'package:screen_manager/screen_injection.dart';

import '../controller/splash_controller.dart';

class SplashInjection extends ScreenInjection<SplashController> {
  SplashInjection({
    super.key,
    required super.child
  }) : super(
    controller: SplashController()
  );
  
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}