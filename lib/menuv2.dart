import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Menu()));
}

bool toggle = true;

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Alignment alignment1 = const Alignment(0.0, 0.0);
  Alignment alignment2 = const Alignment(0.0, 0.0);
  Alignment alignment3 = const Alignment(0.0, 0.0);
  Alignment alignment4 = const Alignment(0.0, 0.0);
  Alignment alignment5 = const Alignment(0.0, 0.0);
  double size1 = 50.0;
  double size2 = 50.0; 
  double size3 = 50.0;
  double size4 = 50.0;
  double size5 = 50.0;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          height: 250.0,
          width: 250.0,
          child: Stack(
            children: [
              AnimatedAlign(
                duration: toggle ? const Duration(milliseconds: 100): const Duration(milliseconds: 800),
                alignment: alignment1,
                curve: toggle ? Curves.easeIn : Curves.elasticOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: toggle ? Curves.easeIn : Curves.elasticOut,
                  height: size1,
                  width: size1,
                  child: FloatingActionButton(
                    heroTag: 'Profile',
                    onPressed: (){
                      toggle = !toggle;
                      Navigator.pushReplacementNamed(context, '/profile');
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    child: const Icon(FontAwesomeIcons.user, color: Colors.white,),
                  ),
                ),
              ),

              AnimatedAlign(
                duration: toggle ? const Duration(milliseconds: 100): const Duration(milliseconds: 800),
                alignment: alignment2,
                curve: toggle ? Curves.easeIn : Curves.elasticOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: toggle ? Curves.easeIn : Curves.elasticOut,
                  height: size2,
                  width: size2,
                  child: FloatingActionButton(
                    heroTag: 'Wellness',
                    onPressed: (){
                      toggle = !toggle;
                      Navigator.pushReplacementNamed(context, '/wellness');
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    child: const Icon(FontAwesomeIcons.handsPraying, color: Colors.white,),
                  ),
                ),
              ),

              AnimatedAlign(
                duration: toggle ? const Duration(milliseconds: 100): const Duration(milliseconds: 800),
                alignment: alignment3,
                curve: toggle ? Curves.easeIn : Curves.elasticOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: toggle ? Curves.easeIn : Curves.elasticOut,
                  height: size3,
                  width: size3,
                  child: FloatingActionButton(
                    heroTag: 'Calendar',
                    onPressed: (){
                      toggle = !toggle;
                      Navigator.pushReplacementNamed(context, '/calendar');
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    child: const Icon(FontAwesomeIcons.calendar, color: Colors.white,),
                  ),
                ),
              ),

              AnimatedAlign(
                duration: toggle ? const Duration(milliseconds: 100): const Duration(milliseconds: 800),
                alignment: alignment4,
                curve: toggle ? Curves.easeIn : Curves.elasticOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: toggle ? Curves.easeIn : Curves.elasticOut,
                  height: size4,
                  width: size4,
                  child: FloatingActionButton(
                    heroTag: 'Jardin',
                    onPressed: (){
                      toggle = !toggle;
                      Navigator.pushReplacementNamed(context, '/jardin');
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    child: const Icon(FontAwesomeIcons.leaf, color: Colors.white,),
                  ),
                ),
              ),

              AnimatedAlign(
                duration: toggle ? const Duration(milliseconds: 100): const Duration(milliseconds: 800),
                alignment: alignment5,
                curve: toggle ? Curves.easeIn : Curves.elasticOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: toggle ? Curves.easeIn : Curves.elasticOut,
                  height: size5,
                  width: size5,
                  child: FloatingActionButton(
                    heroTag: 'Param',
                    onPressed: (){
                      toggle = !toggle;
                      Navigator.pushReplacementNamed(context, '/param');
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    child: const Icon(FontAwesomeIcons.gear, color: Colors.white,),
                  ),
                ),
              ),

              AnimatedAlign(
                duration: toggle ? const Duration(milliseconds: 100): const Duration(milliseconds: 800),
                alignment: const Alignment(0.0, 0.0),
                curve: Curves.easeOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  height: toggle ? 10.0 : 60.0,
                  width: toggle ? 10.0 : 60.0,
                  child: FloatingActionButton(
                    heroTag: 'Home',
                    onPressed: (){
                      setState(() {
                        toggle = !toggle;
                        _controller.reverse();
                      });
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    child: const Icon(FontAwesomeIcons.house, color: Colors.white,),
                  ),
                ),
              ),

              Align(
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: _animation.value * pi * (3 / 4),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      height: toggle ? 70.0 : 0.0,
                      width: toggle ? 70.0 : 0.0,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(60.0)),
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          splashColor: Colors.white,
                          splashRadius: 31.0,
                          onPressed: () {
                            setState(() {
                              if (toggle) {
                                toggle = !toggle;
                                _controller.forward();
                                Future.delayed(const Duration(milliseconds: 10), (){
                                  alignment1 = const Alignment(-1.0, 0.0);
                                });
                                Future.delayed(const Duration(milliseconds: 30), (){
                                  alignment2 = const Alignment(-0.7, -0.7);
                                });
                                Future.delayed(const Duration(milliseconds: 60), (){
                                  alignment3 = const Alignment(0.0, -1.0);
                                });
                                Future.delayed(const Duration(milliseconds: 90), (){
                                  alignment4 = const Alignment(0.7, -0.7);
                                });
                                Future.delayed(const Duration(milliseconds: 120), (){
                                  alignment5 = const Alignment(1.0, 0.0);
                                });
                                Future.delayed(const Duration(seconds: 8), (){
                                  toggle = !toggle;
                                  _controller.reverse();
                                  alignment1 = const Alignment(0.0, 0.0);
                                  alignment2 = const Alignment(0.0, 0.0);
                                  alignment3 = const Alignment(0.0, 0.0); 
                                  alignment4 = const Alignment(0.0, 0.0); 
                                  alignment5 = const Alignment(0.0, 0.0); 
                                });
                              }else{
                                toggle = !toggle;
                                _controller.reverse();
                                alignment1 = const Alignment(0.0, 0.0);
                                alignment2 = const Alignment(0.0, 0.0);
                                alignment3 = const Alignment(0.0, 0.0); 
                                alignment4 = const Alignment(0.0, 0.0); 
                                alignment5 = const Alignment(0.0, 0.0); 
                              }
                            });
                          },
                          icon: Image.asset(
                            'bars.png',
                            height: 27.0,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
