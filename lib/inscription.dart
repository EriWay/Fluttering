import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'accueil.dart';
import 'BDD.dart';
import 'connect_inscr.dart';

class Inscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Inscription', style: TextStyle(color: Colors.white)), // Texte en blanc
          ),
          backgroundColor: const Color(0xFF755846), // Couleur mocha (marron clair)
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/background.svg',
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/icon.png',
                      height: 300,
                      width: 300,
                    ),
                  ),
                  SignUpForm(),
                ],
              ),
            ),
          ],
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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    removeUserId();
    BDD.initializeDatabase();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFieldWithTitle(
              'Nom',
              _nomController,
              keyboardType: TextInputType.text,

            ),

            _buildTextFieldWithTitle(
              'Prénom',
              _prenomController,
              keyboardType: TextInputType.text,

            ),

            _buildTextFieldWithTitle(
              'Identifiant',
              _idController,
              keyboardType: TextInputType.text,

            ),

            _buildTextFieldWithTitle(
              'Mail',
              _mailController,
              keyboardType: TextInputType.emailAddress,

            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, bottom: 8.0), // Ajustement du padding
                  child: Text(
                    'N° de téléphone', // Ajout du titre ici
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF706F45),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0), // Ajustement du padding
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneController, // Lier à la variable _pinController
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF755846),
                      hintText: 'N° de téléphone',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),

            _buildTextFieldWithTitle(
                'Mot de passe',
                _mdpController,
                obscureText: true,
                keyboardType: TextInputType.text,

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, bottom: 8.0), // Ajustement du padding
                  child: Text(
                    'Code PIN (4 chiffres)', // Ajout du titre ici
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF706F45),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0), // Ajustement du padding
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _pinController, // Lier à la variable _pinController
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF755846),
                      hintText: 'Entrez votre PIN',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _saveUser(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF755846),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
              ),
              child: const Text('S\'inscrire', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => const ConnInscr()), // Rediriger vers la page de connexion
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF755846), // Couleur rouge pour le bouton Retour
              ),
              child: const Text('Retour', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  String? _validatePIN(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un code PIN';
    }
    if (value.length != 4 || !RegExp(r'^[0-9]{4}$').hasMatch(value)) {
      return 'Le code PIN doit être composé de 4 chiffres';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final RegExp phoneExp = RegExp(r'^[0-9]{10}$');
    if (!phoneExp.hasMatch(value)) {
      return 'Veuillez entrer un numéro de téléphone valide';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer une adresse e-mail';
    }
    final RegExp emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailExp.hasMatch(value)) {
      return 'Veuillez entrer une adresse e-mail valide';
    }
    return null;
  }

  Future<void> _saveUser(BuildContext context) async {
    String nom = _nomController.text;
    String prenom = _prenomController.text;
    String id = _idController.text;
    String mail = _mailController.text;
    String mdp = _mdpController.text;
    String phone = _phoneController.text;

    if (_validateEmail(mail) != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Veuillez entrer une adresse e-mail valide'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (_validatePhoneNumber(phone) != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Veuillez entrer un numéro de téléphone valide'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    await addUserToDatabase(nom, prenom, id, mail, mdp, phone);
    await findID(id,mdp);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inscription réussie'),
          content: const Text('Vous êtes bien inscrit !'),
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
  }

  Widget _buildTextFieldWithTitle(String title,
      TextEditingController controller,
      {bool obscureText = false, String? Function(String?)? validator, required TextInputType keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF706F45)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
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

  Future<void> addUserToDatabase(String nom, String prenom, String id,
      String mail, String mdp, String phone) async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );

    final Database db = await database;

    await db.insert(
      'User',
      {
        'nom': nom,
        'prenom': prenom,
        'Identifiant': id, // Correction du nom de la clé
        'mail': mail,
        'num_telephone': phone, // Correction du nom de la clé
        'mdp': mdp,
        'pin': _pinController.text, // Enregistrement du PIN dans la base de données
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> saveUserData(String prenom, String nomUtilisateur) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('prenom', prenom);
    await prefs.setString('nomUtilisateur', nomUtilisateur);

  }

  Future<void> findID(identifiant,motDePasse) async {


      final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'my_database.db'),
        version: 1,
      );

      final Database db = await database;

    final List<Map<String, dynamic>> users = await db.rawQuery(
        'SELECT * FROM User WHERE Identifiant = ? AND mdp = ?',
        [identifiant, motDePasse]);

    if (users.isNotEmpty) {
      // Récupérer les données de l'utilisateur
      final user = users.first;
      final String prenom = user['prenom'];
      final int numUtilisateur = user['num_utilisateur'] as int; // Modifier le type de la variable

      // Stocker les informations localement
      await saveUserData(prenom, numUtilisateur.toString()); // Convertir en String si nécessaire


    } else {
      // L'utilisateur n'est pas trouvé ou les identifiants sont incorrects
      print('Identifiants incorrects');
    }
  }

  Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('prenom');
    await prefs.remove('num_utilisateur');

  }
}