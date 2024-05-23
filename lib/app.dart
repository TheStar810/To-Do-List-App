import 'package:flutter/material.dart';
import 'login.dart';

class PlannerApp extends StatelessWidget {
  const PlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project UAS William Susilo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 183, 0)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
