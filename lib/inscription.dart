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
      title: 'Page d\'Inscription',
      theme: ThemeData(
        primaryColor: Color(0xFF755846), // Couleur mocha (marron clair)
        scaffoldBackgroundColor: Color(0xFFFCEBE2), // Fond beige
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Inscription', style: TextStyle(color: Colors.white)), // Texte en blanc
          ),
          backgroundColor: Color(0xFF755846), // Couleur mocha (marron clair)
        ),
        body: SingleChildScrollView( // Utiliser SingleChildScrollView pour permettre le défilement
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Image.network(
                  'https://cdn.discordapp.com/attachments/1218184284855210064/1218185554936598568/logo2.0.png?ex=6606beb5&is=65f449b5&hm=d3345b2b8eb12e7c673755c7a434492c92e264ce514a05a5e3ac6ddc90a65963&', // Chemin d'accès à votre image
                  height: 300, // Hauteur de l'image
                  width: 300, // Largeur de l'image
                ),
              ),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _mdpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFieldWithTitle('Nom', _nomController),
            _buildTextFieldWithTitle('Prénom', _prenomController),
            _buildTextFieldWithTitle('ID', _idController),
            _buildTextFieldWithTitle('Mail', _mailController),
            _buildTextFieldWithTitle('Mot de passe', _mdpController, obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _saveUser();
                }
              },
              child: Text('S\'inscrire', style: TextStyle(color: Colors.white)), // Texte en blanc
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF755846), // Couleur mocha (marron clair)
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithTitle(String title, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF706F45)), // Texte en blanc
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Ce champ est obligatoire';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFF755846),
            hintText: 'Entrez votre $title',
            hintStyle: TextStyle(color: Colors.white), // Texte en blanc
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _saveUser() {
    String nom = _nomController.text;
    String prenom = _prenomController.text;
    String id = _idController.text;
    String mail = _mailController.text;
    String mdp = _mdpController.text;

    // Appel de la fonction pour ajouter l'utilisateur à la base de données
    addUserToDatabase(nom, prenom, id, mail, mdp);

    // Sauvegarde des informations dans la base de données
    print('Nom: $nom, Prénom: $prenom, ID: $id, Mail: $mail, Mot de passe: $mdp');
  }

  Future<void> addUserToDatabase(String nom, String prenom, String id, String mail, String mdp) async {
    // Ouvrir la base de données
    final Future<Database> database = openDatabase(
      // Chemin de la base de données
      join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );

    // Attendre l'ouverture de la base de données
    final Database db = await database;

    // Insérer l'utilisateur dans la table
    await db.insert(
      'User',
      {
        'nom': nom,
        'prenom': prenom,
        'id': id,
        'mail': mail,
        'mdp': mdp,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
