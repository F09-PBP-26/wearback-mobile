import 'package:flutter/material.dart';
import 'package:wearback_mobile/navigation/module_shell.dart';

void main() {
  runApp(const WearBackApp());
}

class WearBackApp extends StatelessWidget {
  const WearBackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WearBack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF294439),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F5F0),
        useMaterial3: true,
      ),
      home: const ModuleShell(),
    );
  }
}
