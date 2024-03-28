import 'package:flutter/material.dart';
import 'menuv2.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Jardin extends StatelessWidget{
  const Jardin({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      appBar: AppBar(
        title: const Text(
          'Mon jardin secret',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF755846),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/background.svg',
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('Fleur'+1.toString()+".png"),
                  Image.asset(''),
                  Image.asset(''),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                ],
              ),
              Image.asset('assets/etagewe.png'),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                ],
              ),
              Image.asset('assets/etagewe.png'),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                ],
              ),
              Image.asset('assets/etagewe.png'),
              const Spacer(),
              const Menu(),
            ],
          )
        ],
      ),
    );
  }
}