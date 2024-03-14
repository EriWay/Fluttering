import 'package:flutter/material.dart';
import 'package:journal_intime/menu.dart';

class Parametres extends StatelessWidget{
  const Parametres({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Ceci sont les parametres"),
            RadialMenu()
          ],
        ),
        
      )
    );
  }
}