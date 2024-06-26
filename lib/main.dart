import 'package:flutter/material.dart';
import 'connection.dart';
import 'calendrier.dart';
import 'connect_inscr.dart';
import 'splashscreen.dart';
import 'accueil.dart';
import 'bienetre.dart';
import 'jardin.dart';
import 'parametres.dart';
import 'profil.dart';
import 'package:flutter/services.dart';
import 'inscription.dart';
import 'majournee.dart';
import 'moodjournee.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,// Status bar color
    ));
    return MaterialApp(
      initialRoute: '/splash',
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash' : (BuildContext context) => const SplashScreen(),
        '/choose' : (BuildContext context) => const ConnInscr(),
        '/register' : (BuildContext context) => Inscription(),
        '/login' : (BuildContext context)=> const Connection(),
        '/' : (BuildContext context)=> AccueilPage(),
        '/wellness' : (BuildContext context)=>const Wellness(),
        '/calendar' : (BuildContext context)=> CalendrierPage(),
        '/jardin' : (BuildContext context)=> Jardin(),
        '/param' : (BuildContext context)=> ParametresPage(),
        '/profile' : (BuildContext context)=> const Profile(),
        '/majournee' : (BuildContext context)=> NotebookPage(),
        '/moodjournee' : (BuildContext context)=> DailyMoodPage(),
      },
    );
  }
}