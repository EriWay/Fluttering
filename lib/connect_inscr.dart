import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConnInscr extends StatelessWidget {
  const ConnInscr({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        SvgPicture.asset(
          '/background.svg',
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'img.png',
                width: MediaQuery.of(context).size.width/3,
                alignment: Alignment.center,
              ),
              const Text("CalmLeaf Diary"),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF755846), // Couleur mocha (marron clair)
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/register');
                }, 
                child: const Text("Inscription"),
                
              ),
              TextButton(onPressed: (){
                Navigator.pushReplacementNamed(context, '/login');
              }, child: const Text("Connection")),
            ], 
          ),
        )
      ],
    ),
  );  }
  }
