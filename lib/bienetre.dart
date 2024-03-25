import 'package:flutter/material.dart';
import 'package:journal_intime/menu.dart';

class Wellness extends StatelessWidget{
  const Wellness({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Ceci est le bien etre"),
            RadialMenu()
          ],
        ),
        
      )
    );
  }
}