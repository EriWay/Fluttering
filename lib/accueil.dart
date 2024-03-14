import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:journal_intime/menu.dart';

class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Ceci est l'accueil"),
            SizedBox(child: RadialMenu())
          ],
        ),
        
      )
    );
  }
}