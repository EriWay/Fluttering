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
              'CREATE TABLE User (num_utilisateur INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, prenom TEXT, id INTEGER, mail TEXT, num_telephone TEXT, mdp TEXT)');
          await db.execute(
              'CREATE TABLE Notes (num_utilisateur INTEGER, date TEXT PRIMARY KEY, humeur TEXT, image TEXT, vocal TEXT, texte TEXT)');
          await db.execute(
              'CREATE TABLE BienEtre (id INTEGER PRIMARY KEY, num_utilisateur INTEGER, date TEXT, eau INTEGER, dodo INTEGER, activite INTEGER, productivite INTEGER)');
        });

    // Fermer la connexion à la base de données
    await database.close();

    // Afficher un message de confirmation
    print('Votre base de données a bien été créée à l\'adresse : $path');
  }
}
