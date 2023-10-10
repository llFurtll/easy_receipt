import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/core/injection/global_injection.dart';
import 'features/recibo/presentation/recibo_create/view/recibo_create_view.dart';
import 'features/recibo/presentation/recibo_list/view/recibo_list_view.dart';
import 'features/splash/view/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  runApp(
    GlobalInjection(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/splash",
        routes: {
          "/splash": (context) => const SplashScreen(),
          "/recibos": (context) => const ReciboListScreen(),
          "/recibo": (context) => const ReciboCreateScreen()
        },
      ),
    )
  );
}