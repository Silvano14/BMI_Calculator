import 'package:flutter/material.dart';
import 'package:globo_fitness/screens/intro_screen.dart';

void main() {
  runApp(GlobeApp());
}

class GlobeApp extends StatelessWidget {
  const GlobeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}
