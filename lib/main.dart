// main.dart
import 'package:flutter/material.dart';
import 'accueil.dart';
import 'calendrier.dart';

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
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Pour centrer les boutons verticalement
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccueilPage()),
                );
              },
              child: Text('Aller à la page Accueil'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendrierPage()),
                );
              },
              child: Text('Aller à la page Calendrier'),
            ),
          ],
        ),
      ),
    );
  }
}
