import 'dart:math';
import 'BDD.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override                         
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }
  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/choose'); 
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
                width: MediaQuery.of(context).size.width/3,
                alignment: Alignment.center,
              ),
              const Text("CalmLeaf Diary"),
              AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                child: Transform.rotate(angle:pi,child: LoadingAnimationWidget.prograssiveDots(color: const Color(0xffb9b9b9), size: 75)),
              )
            ], 
          ),
        )
      ],
    ),
  );  }
}