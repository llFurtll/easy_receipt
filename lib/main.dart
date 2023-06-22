import 'package:device_preview/device_preview.dart';
import 'package:easy_receipt/features/recibo/presentation/recibo_create/view/recibo_create_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'features/recibo/presentation/recibo_list/view/recibo_list_view.dart';
import 'features/splash/view/splash_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return MaterialApp(
          // ignore: deprecated_member_use
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          initialRoute: "/splash",
          routes: {
            "/splash": (context) => const SplashScreen(),
            "/recibos": (context) => const ReciboListScreen(),
            "/recibo": (context) => const ReciboCreateScreen()
          },
        );
      },
    )
  );
}