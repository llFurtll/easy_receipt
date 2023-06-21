import 'package:flutter/material.dart';

import 'features/splash/view/splash_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0XFFA8ADFF)
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashScreen()
      },
    )
  );
}