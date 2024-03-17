import 'package:flutter/material.dart';
import 'package:journal_intime/menu.dart';

class Profile extends StatelessWidget{
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Back !")),
            const Text("Ceci est le profil"),
            RadialMenu()
          ],
        ),
        
      )
    );
  }
}