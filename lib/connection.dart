import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'accueil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'connect_inscr.dart';

class Connection extends StatelessWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/img.png',
                  width: MediaQuery.of(context).size.width / 3,
                  alignment: Alignment.center,
                ),
                const Text("CalmLeaf Diary"),
                const Spacer(flex: 3),
                const LoginForm(),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _mdpController = TextEditingController();

  late Database _database;

  @override
  void initState() {
    super.initState();
    _openDatabase();
  }

  Future<void> _openDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_database.db');
    print('Chemin de la base de données : $path'); // Ajout de cette ligne pour afficher le chemin dans la console
    _database = await openDatabase(path);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFieldWithTitle('identifiant', _nomController),
            _buildTextFieldWithTitle('Mot de passe', _mdpController,
                obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _openDatabase();
                  _signInWithEmailAndPassword(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF755846),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              child: const Text('Se connecter',
                  style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => ConnInscr()), // Rediriger vers la page de connexion
                );              },
              child: const Text('Retour',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF755846), // Couleur rouge pour le bouton Retour
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    final String identifiant = _nomController.text;
    final String motDePasse = _mdpController.text;

    final List<Map<String, dynamic>> users = await _database.rawQuery(
        'SELECT * FROM User WHERE Identifiant = ? AND mdp = ?',
        [identifiant, motDePasse]);

    if (users.isNotEmpty) {
      // Récupérer les données de l'utilisateur
      final user = users.first;
      final String prenom = user['prenom'];
      final int numUtilisateur = user['num_utilisateur'] as int; // Modifier le type de la variable

      // Stocker les informations localement
      await saveUserData(prenom, numUtilisateur.toString()); // Convertir en String si nécessaire

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Connection réussie'),
            content: Text('Vous êtes maintenant connecté !'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme le pop-up
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => AccueilPage()), // Remplace la page actuelle par une autre page
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // L'utilisateur n'est pas trouvé ou les identifiants sont incorrects
      print('Identifiants incorrects');
    }
  }

// Fonction pour stocker les données de l'utilisateur localement
  Future<void> saveUserData(String prenom, String nomUtilisateur) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('prenom', prenom);
    await prefs.setString('num_utilisateur', nomUtilisateur);

  }


  Widget _buildTextFieldWithTitle(String title, TextEditingController controller,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF706F45)),
        ),
        const SizedBox(height: 8),
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
            fillColor: const Color(0xFF755846),
            hintText: 'Entrez votre $title',
            hintStyle: const TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}