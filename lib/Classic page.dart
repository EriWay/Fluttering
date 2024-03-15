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
              ElevatedButton(
                onPressed: () {
                  _executeCode();
                },
                child: Text('Exécuter le code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _executeCode() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE my_table(id INTEGER PRIMARY KEY, name TEXT, value INTEGER)',
        );
      },
      version: 1,
    );

    final db = await database;
    await db.insert(
      'my_table',
      {'name': 'Product', 'value': 42},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print('Données insérées avec succès.');
  }
}
