import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class BDD {
  static Future<void> initializeDatabase() async {
    try {
      // Vérifier si la base de données existe déjà
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'my_database.db');
      File file = File(path); // Utiliser File pour vérifier l'existence du fichier
      bool exists = await file.exists();

      if (!exists) {
        // Code pour initialiser la base de données
        Database database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
              // Créer les tables
              await db.execute(
                  'CREATE TABLE User (num_utilisateur INTEGER PRIMARY KEY AUTOINCREMENT, nom TEXT, prenom TEXT, Identifiant INTEGER, mail TEXT, num_telephone TEXT, mdp TEXT, PIN INTEGER )');
              await db.execute(
                  'CREATE TABLE Notes (num_utilisateur INTEGER, date TEXT PRIMARY KEY, humeur TEXT, image TEXT, vocal TEXT, texte TEXT)');
              await db.execute(
                  'CREATE TABLE BienEtre (num_utilisateur INTEGER, date TEXT, eau INTEGER, dodo INTEGER, activite INTEGER, productivite INTEGER)');
              await db.execute(
                  'CREATE TABLE Plantes (num_utilisateur INTEGER, num_pot INTEGER, type_fleur INTEGER, pousse INTEGER)');
              await db.execute(
                  'CREATE TABLE TotalPlantes (num_utilisateur INTEGER, fleur0 INTEGER, fleur1 INTEGER, fleur2 INTEGER)');
            });

        // Insérer une note pour aujourd'hui comme test (remarque : date en format de chaîne)
        String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
        await database.rawInsert(
            'INSERT OR REPLACE INTO Notes(num_utilisateur, date, humeur, image, vocal, texte) VALUES(?, ?, ?, ?, ?, ?)',
            [1, formattedDate, '3', 'image.jpg', 'audio.mp3', 'Aujourd hui je suis allé en cours et j ai eu une interro de graphes']);

        await database.rawInsert(
            'INSERT INTO User(nom, prenom, Identifiant, mail, num_telephone, mdp, PIN) VALUES(?, ?, ?, ?, ?, ?, ?)',
            ['Pain', 'Anthonin', 'Antho', 'anthoninpain@hotmail.fr', '0623908480', 'Antho', 1234]);

        // Fermer la connexion à la base de données
        await database.close();

        // Afficher un message de confirmation
        print('Votre base de données a bien été créée à l\'adresse : $path');
      } else {
        print('La base de données existe déjà à l\'adresse : $path');
      }
    } catch (e) {
      print('Erreur lors de l\'initialisation de la base de données : $e');
    }
  }
}
