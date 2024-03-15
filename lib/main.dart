import 'package:flutter/material.dart';
import 'BDD.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BDD.initializeDatabase(); // Pas besoin d'utiliser 'await' ici
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}