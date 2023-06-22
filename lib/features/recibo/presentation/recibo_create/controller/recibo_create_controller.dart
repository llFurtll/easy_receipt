import 'package:flutter/services.dart';
import 'package:screen_manager/screen_controller.dart';

class ReciboCreateController extends ScreenController {
  @override
  void onInit() {
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft
    ]);
  }
}