import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BDD {
  static Future<void> initializeDatabase() async {
    // Code pour initialiser la base de données
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // Créer les tables
          await db.execute(
              'CREATE TABLE User (id INTEGER PRIMARY KEY, nom TEXT, prenom TEXT, mail TEXT, num_telephone TEXT, mdp TEXT)');
          await db.execute(
              'CREATE TABLE Notes (id INTEGER PRIMARY KEY, date TEXT, humeur TEXT, image TEXT, vocal TEXT, texte TEXT)');
          await db.execute(
              'CREATE TABLE BienEtre (id INTEGER PRIMARY KEY, eau INTEGER, dodo INTEGER, activite INTEGER, productivite INTEGER)');
        });

    // Fermer la connexion à la base de données
    await database.close();

    // Afficher un message de confirmation
    print('Votre base de données a bien été créée à l\'adresse : $path');
  }
}
