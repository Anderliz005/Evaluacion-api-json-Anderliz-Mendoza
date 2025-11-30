import 'package:flutter/material.dart';
import 'ui/user_home_page.dart';

void main() {
  runApp(const AppEvaluacion());
}

class AppEvaluacion extends StatelessWidget {
  const AppEvaluacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evaluación API JSON - Anderliz Mendoza',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        useMaterial3: true,
      ),
      home: const UserHomePage(),
    );
  }
}