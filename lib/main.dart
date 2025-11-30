import 'package:flutter/material.dart';
import 'ui/user_home_page.dart';

void main() {
  runApp(const AppEvaluacionTurquesa());
}

class AppEvaluacionTurquesa extends StatelessWidget {
  const AppEvaluacionTurquesa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evaluación API JSON',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        useMaterial3: true,
      ),
      home: const UserHomePage(),
    );
  }
}