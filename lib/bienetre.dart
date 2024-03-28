import 'package:flutter/material.dart';
import 'menuv2.dart';

class Wellness extends StatelessWidget{
  const Wellness({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold (
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Ceci est le bien etre"),
            Menu()
          ],
        ),
        
      )
    );
  }
}