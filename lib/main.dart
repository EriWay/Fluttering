import 'package:flutter/material.dart';
import 'package:helloworld/calendrier.dart';
import 'accueil.dart';
import 'bienetre.dart';
import 'jardin.dart';
import 'parametres.dart';
import 'profil.dart';
void main() {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
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