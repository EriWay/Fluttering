import 'package:flutter/material.dart';
import 'menuv2.dart';

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
            Menu()
          ],
        ),
        
      )
    );
  }
}