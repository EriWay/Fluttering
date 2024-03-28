import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BDD.dart';
import 'pin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkIfLoggedIn(); // Vérifiez si l'utilisateur est déjà connecté lors de l'initialisation
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, checkIfLoggedIn);
  }



  Future<void> checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? prenom = prefs.getString('prenom');
    final String? numUtilisateur = prefs.getString('num_utilisateur');
    if (prenom != null && numUtilisateur != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => PinPage()),
      );
    } else {
       {
        Navigator.pushReplacementNamed(context, '/choose');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    BDD.initializeDatabase();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/Splashscreen.svg',
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img.png',
                  width: MediaQuery.of(context).size.width / 3,
                  alignment: Alignment.center,
                ),
                const Text("CalmLeaf Diary"),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  child: Transform.rotate(
                    angle: pi,
                    child: LoadingAnimationWidget.prograssiveDots(
                      color: const Color(0xffb9b9b9),
                      size: 75,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}