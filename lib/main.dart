import 'package:flutter/material.dart';
import 'package:translator_app_polyglot/features/presentation/screens/homescreen.dart';
import 'package:translator_app_polyglot/features/presentation/widgets/feature_card.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
