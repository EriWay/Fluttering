import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'accueil.dart';
import 'connection.dart'; // Import de la page de connexion
import 'connect_inscr.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PinPage extends StatefulWidget {
  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  final TextEditingController _pinController = TextEditingController();
  String _prenom = '';

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prenom = prefs.getString('prenom') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bonjour $_prenom'),
        backgroundColor: const Color(0xFF755846),
        centerTitle: true,
      ),
      body: Stack(
        children: [
      Positioned.fill(
      child: SvgPicture.asset(
        'assets/background.svg',
        fit: BoxFit.cover, // Assure que l'SVG couvre tout l'écran
      ),
    ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          const Spacer(),
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              const Padding(
              padding: EdgeInsets.only(left: 12.0, bottom: 8.0),
              child: Text(
                'Code PIN (4 chiffres)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF706F45),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _pinController,
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
            ElevatedButton(
              onPressed: () {
                _verifyPin(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF755846),
              ),
              child: const Text('Valider', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16), // Espacement avant le bouton Retour
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF755846), // Couleur rouge pour le bouton Retour
              ),
              child: const Text('Retour', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
            const Spacer(),
    ]
    )
    ]
      ),
    );
  }

  Future<void> _verifyPin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('num_utilisateur') ?? '-1';

    if (userId != '-1') {
      final Database database = await openDatabase('my_database.db');
      final List<Map<String, dynamic>> user = await database.rawQuery(
        'SELECT * FROM User WHERE num_utilisateur = ?',
        [userId],
      );

      if (user.isNotEmpty) {
        String storedPin = user[0]['PIN'].toString();
        if (_pinController.text == storedPin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (BuildContext context) => AccueilPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Code PIN incorrect'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Utilisateur non trouvé'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID utilisateur non valide'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Fonction pour se déconnecter et supprimer les SharedPreferences
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Supprimer toutes les données SharedPreferences
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const Connection()), // Rediriger vers la page de connexion
    );
  }
}