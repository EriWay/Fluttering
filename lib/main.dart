// main.dart
import 'package:flutter/material.dart';
import 'accueil.dart'; // Assurez-vous que ce fichier existe et est correctement placé dans votre répertoire de projet.

void main() => runApp(MonApp());

class MonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemple',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Principale'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccueilPage()),
            );
          },
          child: Text('Aller à la page Accueil'),
        ),
      ),
    );
  }
}
