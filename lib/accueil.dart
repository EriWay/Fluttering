import 'package:flutter/material.dart';
import 'package:helloworld/menuv2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserName(), // Appel de la fonction pour récupérer le prénom
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Afficher un indicateur de chargement tant que le prénom est en cours de récupération
          return CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Récupérer le prénom depuis le snapshot
            String userName = snapshot.data.toString();
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Accueil',
                  style: TextStyle(color: Colors.white),

                ),
                backgroundColor: Color(0xFFF755846),
                centerTitle: true,
              ),
              body: Container(
                color: Color(0xFFFCEBE2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Bonjour $userName!', // Afficher le prénom ici
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Citation du jour',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xFFFFFDCC7),
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '"Il ne savait pas que c\'était impossible, alors il l\'a fait"',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xFF6D4C41),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    Menu()
                  ],
                ),
              ),
            );
          }
        }
      },

    );
  }

  // Fonction pour récupérer le prénom depuis les préférences partagées
  Future<String> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('prenom') ?? ''; // Retourner une chaîne vide si le prénom n'est pas trouvé
  }
}

