import 'package:clinica_agil/pages/Splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(), // Define a página de login como a home
    );
  }
}
