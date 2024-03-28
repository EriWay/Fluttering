import 'package:flutter/material.dart';
import 'package:helloworld/calendrier.dart';
import 'accueil.dart';
import 'bienetre.dart';
import 'jardin.dart';
import 'parametres.dart';
import 'profil.dart';
import 'package:flutter/services.dart';
void main() {

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
      initialRoute: '/wellness',
      routes: {
        '/' : (BuildContext context)=> AccueilPage(),
        '/wellness' : (BuildContext context)=>const Wellness(),
        '/calendar' : (BuildContext context)=> CalendrierPage(),
        '/jardin' : (BuildContext context)=> const Jardin(),
        '/param' : (BuildContext context)=> const Parametres(),
        '/profile' : (BuildContext context)=> const Profile(),
      },
    );
  }
}