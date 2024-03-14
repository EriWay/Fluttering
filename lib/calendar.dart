import 'package:flutter/material.dart';
import 'package:journal_intime/menu.dart';

class Calendrier extends StatelessWidget{
  const Calendrier({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Ceci est le calendrier"),
            RadialMenu()
          ],
        ),
        
      )
    );
  }
}