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
              'CREATE TABLE User (num_utilisateur INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, prenom TEXT, Identifiant INTEGER, mail TEXT, num_telephone TEXT, mdp TEXT, PIN INTEGER )');
          await db.execute(
              'CREATE TABLE Notes (num_utilisateur INTEGER, date TEXT PRIMARY KEY, humeur TEXT, image TEXT, vocal TEXT, texte TEXT)');
          await db.execute(
              'CREATE TABLE BienEtre (id INTEGER PRIMARY KEY, num_utilisateur INTEGER, date TEXT, eau INTEGER, dodo INTEGER, activite INTEGER, productivite INTEGER)');
          await db.execute(
              'CREATE TABLE Plantes (num_utilisateur INTEGER, num_pot INTEGER, type_fleur INTEGER, pousse INTEGER)');
          await db.execute(
              'CREATE TABLE TotalPlantes (num_utilisateur INTEGER, fleur0 INTEGER, fleur1 INTEGER, fleur2 INTEGER)');
        
          await db.rawInsert(
                'INSERT INTO User(nom, prenom, Identifiant, mail, num_telephone, mdp, PIN) VALUES(?, ?, ?, ?, ?, ?, ?)',
                ['Pain', 'Anthonin', 'Antho', 'anthoninpain@hotmail.fr', '0623908480', 'Antho', 1234]);
        });

    // Fermer la connexion à la base de données
    await database.close();

    // Afficher un message de confirmation
    print('Votre base de données a bien été créée à l\'adresse : $path');
  }
}
