import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import "dart:math";
import "package:vector_math/vector_math.dart" show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'accueil.dart';
import 'bienetre.dart';
import 'calendar.dart';
import 'jardin.dart';
import 'menu.dart';
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
        '/' : (BuildContext context)=> const Home(),
        '/wellness' : (BuildContext context)=>const Wellness(),
        '/calendar' : (BuildContext context)=> const Calendrier(),
        '/jardin' : (BuildContext context)=> const Jardin(),
        '/param' : (BuildContext context)=> const Parametres(),
        '/profile' : (BuildContext context)=> const Profile(),
      },
    );
  }
}

