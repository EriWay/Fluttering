import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Vierge',
      theme: ThemeData(
        primaryColor: Color(0xFF755846), // Couleur mocha (marron clair)
        scaffoldBackgroundColor: Color(0xFFFCEBE2), // Fond beige
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Header'),
          ),
          backgroundColor: Color(0xFF755846), // Couleur mocha (marron clair)
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contenu principal de la page'),
            ],
          ),
        ),
      ),
    );
  }
}
