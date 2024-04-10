import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'menuv2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

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
            const Column(
              children: <Widget>[
                SizedBox(height: 100),
                  UserNameDisplay(),
                AverageSleepTime(),
                AverageHydrationDisplay(),
                AverageProductivityDisplay(),
                  Spacer(),
                  Menu(),
                      ],
                    ),
            const Align(
                alignment: Alignment.topCenter,
                child:Title(),
            )
          ],
      ),
    );
  }
}

class Title extends StatelessWidget {

  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF755846),
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: const Text(
        'Profil',
        style: TextStyle(color: Colors.white, fontSize: 24),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class UserNameDisplay extends StatelessWidget {
  const UserNameDisplay({Key? key}) : super(key: key);

  Future<String> _getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('prenom') ?? 'Utilisateur'; // Utilisez un nom par défaut si non trouvé
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getUserName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // ...
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          return Center(
            child: Text(
              'Bonjour ${snapshot.data}!', // Affiche le prénom récupéré
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                backgroundColor: Colors.transparent,
              ),
              textAlign: TextAlign.center,
            ),
            );
        }
      },
    );
  }
}

Future<double> getAverageSleepTime() async {
  var dbPath = await getDatabasesPath();
  String path = join(dbPath, 'my_database.db');
  Database database = await openDatabase(path);

  // Calcul de la date il y a 7 jours.
  var sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));

  // Formatage de la date pour correspondre au format stocké dans la base de données.
  var formattedDate = DateFormat('yyyy-MM-dd').format(sevenDaysAgo);

  // Requête pour récupérer les données de sommeil des 7 derniers jours.
  List<Map> list = await database.rawQuery(
    'SELECT dodo FROM BienEtre WHERE date >= ?',
    [formattedDate],
  );

  // Fermeture de la base de données.
  await database.close();

  // Calcul de la moyenne.
  double sum = list.fold(0, (previousValue, element) => previousValue + (element['dodo'] as int));
  return list.isNotEmpty ? sum / list.length : 0.0;
}

class AverageSleepTime extends StatelessWidget {
  const AverageSleepTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: getAverageSleepTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          // Formatage de la valeur moyenne pour l'afficher avec 1 chiffre après la virgule.
          var averageSleepTime = snapshot.data?.toStringAsFixed(1) ?? '0.0';
          return Text('Temps moyen de sommeil : $averageSleepTime heures');
        }
      },
    );
  }
}

Future<double> getAverageHydration() async {
  var dbPath = await getDatabasesPath();
  String path = join(dbPath, 'my_database.db');
  Database database = await openDatabase(path);

  var sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
  var formattedDate = DateFormat('yyyy-MM-dd').format(sevenDaysAgo);

  List<Map> list = await database.rawQuery(
    'SELECT eau FROM BienEtre WHERE date >= ?',
    [formattedDate],
  );

  await database.close();

  double sum = list.fold(0, (previousValue, element) => previousValue + (element['eau'] as int));
  return list.isNotEmpty ? sum / list.length : 0.0;
}

class AverageHydrationDisplay extends StatelessWidget {
  const AverageHydrationDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: getAverageHydration(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          var averageHydration = snapshot.data?.toStringAsFixed(1) ?? '0.0';
          return Text('Moyenne de verres d\'eau bus : $averageHydration par jour');
        }
      },
    );
  }
}


Future<double> getAverageProductivity() async {
  var dbPath = await getDatabasesPath();
  String path = join(dbPath, 'my_database.db');
  Database database = await openDatabase(path);

  var sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
  var formattedDate = DateFormat('yyyy-MM-dd').format(sevenDaysAgo);

  List<Map> list = await database.rawQuery(
    'SELECT productivite FROM BienEtre WHERE date >= ?',
    [formattedDate],
  );

  await database.close();

  double sum = list.fold(0, (previousValue, element) => previousValue + (element['productivite'] as int));
  return list.isNotEmpty ? sum / list.length : 0.0;
}

class AverageProductivityDisplay extends StatelessWidget {
  const AverageProductivityDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: getAverageProductivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          var averageProductivity = snapshot.data?.toStringAsFixed(1) ?? '0.0';
          return Text('Moyenne de productivité : $averageProductivity étoiles par jour');
        }
      },
    );
  }
}