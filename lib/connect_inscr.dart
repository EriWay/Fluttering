import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'connection.dart';
import 'inscription.dart';

class ConnInscr extends StatelessWidget {
  const ConnInscr({super.key});

  @override
  Widget build(BuildContext context) {

  return Scaffold(
    body: Stack(
      children: <Widget>[
        SvgPicture.asset(
          'assets/background.svg',
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/img.png',
                width: MediaQuery.of(context).size.width/3,
                alignment: Alignment.center,
              ),
              const Text("CalmLeaf Diary"),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF755846), // Couleur mocha (marron clair)
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => Inscription()), // Remplace la page actuelle par une autre page
                  );                },
                child: const Text("Inscription", style: TextStyle(color: Colors.white)),
                
              ),
              const Spacer(flex: 1,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF755846), // Couleur mocha (marron clair)
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => Connection()), // Remplace la page actuelle par une autre page
                  );                       }, child: const Text("Connection", style: TextStyle(color: Colors.white))
              ),
              const Spacer(flex: 5)
            ], 
          ),
        )
      ],
    ),
  );  }
  }
