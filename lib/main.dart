import 'package:flutter/material.dart';

import 'features/recibo/presentation/recibo_list/view/recibo_list_view.dart';
import 'features/splash/view/splash_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0XFFA8ADFF),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0XFFA28EE8)
        )
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashScreen(),
        "/recibos": (context) => const ReciboListScreen()
      },
    )
  );
}