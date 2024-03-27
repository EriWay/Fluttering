import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:helloworld/calendrier.dart';

import 'accueil.dart';
import 'bienetre.dart';
import 'jardin.dart';
import 'parametres.dart';
import 'profil.dart';

import "dart:math";
import "package:vector_math/vector_math.dart" show radians;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadialMenu extends StatefulWidget {
  @override
  createState() => _RadialMenuState();
}

class _RadialMenuState extends State<RadialMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return RadialAnimation(controller: controller);
  }
}

class RadialAnimation extends StatelessWidget {
  RadialAnimation({Key? key, required this.controller})
      : scale = Tween<double>(
          begin: 1.5,
          end: 0.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
        ),
        translation = Tween<double>(
          begin: 0.0,
          end: 100.0,
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.easeInOut),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;

  @override
  build(context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, builder) {
          return Stack(alignment: Alignment.center, children: [
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  (translation.value) * cos(radians(90)),
                  (translation.value) * sin(radians(90)),
                ),
              child: FloatingActionButton(
                heroTag: 'Bnb',
                hoverColor: Colors.orange,
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccueilPage()));
                },
                child: const Icon(FontAwesomeIcons.airbnb, color: Colors.white),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  (translation.value) * cos(radians(180)),
                  (translation.value) * sin(radians(180)),
                ),
              child: FloatingActionButton(
                heroTag: 'Profile',
                hoverColor: Colors.orange,
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                child: const Icon(FontAwesomeIcons.user, color: Colors.white),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  (translation.value) * cos(radians(225)),
                  (translation.value) * sin(radians(225)),
                ),
              child: FloatingActionButton(
                heroTag: 'Wellness',
                hoverColor: Colors.orange,
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Wellness()));
                },
                child: const Icon(FontAwesomeIcons.handsPraying,
                    color: Colors.white),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  (translation.value) * cos(radians(270)),
                  (translation.value) * sin(radians(270)),
                ),
              child: FloatingActionButton(
                heroTag: 'Calendar',
                hoverColor: Colors.orange,
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  CalendrierPage()));
                },
                child:
                    const Icon(FontAwesomeIcons.calendar, color: Colors.white),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  (translation.value) * cos(radians(315)),
                  (translation.value) * sin(radians(315)),
                ),
              child: FloatingActionButton(
                heroTag: 'Jardin',
                hoverColor: Colors.orange,
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Jardin()));
                },
                child: const Icon(FontAwesomeIcons.leaf, color: Colors.white),
              ),
            ),
            Transform(
              transform: Matrix4.identity()
                ..translate(
                  (translation.value) * cos(radians(0)),
                  (translation.value) * sin(radians(0)),
                ),
              child: FloatingActionButton(
                heroTag: 'param',
                hoverColor: Colors.orange,
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParametresPage()));
                },
                child: const Icon(FontAwesomeIcons.gear, color: Colors.white),
              ),
            ),
            //_buildButton(180, bgcolor: Colors.green, color: Colors.white, icon: FontAwesomeIcons.user, context: context, route: "/profile"),
            //_buildButton(225, bgcolor: Colors.green, color: Colors.white, icon: FontAwesomeIcons.handsPraying, context: context, route: "/wellness"),
            //_buildButton(270, bgcolor: Colors.green, color: Colors.white, icon: FontAwesomeIcons.calendar, context: context, route: "/calendar"),
            //_buildButton(315, bgcolor: Colors.green, color: Colors.white, icon: FontAwesomeIcons.leaf, context: context, route: "/jardin"),
            //_buildButton(0, bgcolor: Colors.green, color: Colors.white, icon: FontAwesomeIcons.gear, context: context, route: "/param"),
            Transform.scale(
              scale: scale.value - 1.5,
              child: FloatingActionButton(
                heroTag: 'Home',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccueilPage()));
                },
                backgroundColor: Colors.green,
                child: Transform.flip(
                  flipY: true,
                  child: const Icon(
                    FontAwesomeIcons.house,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Transform.scale(
              scale: scale.value,
              child: FloatingActionButton(
                heroTag: 'Menu',
                hoverColor: Colors.orange,
                onPressed: _open,
                backgroundColor: Colors.blue,
                child: const Icon(
                  FontAwesomeIcons.tree,
                  color: Colors.white,
                ),
              ),
            )
          ]);
        });
  }

  _buildButton(double angle,
      {required Color bgcolor,
      required Color color,
      required IconData icon,
      required BuildContext context,
      required String route}) {
    final double rad = radians(angle);
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (translation.value) * cos(rad),
          (translation.value) * sin(rad),
        ),
      child: FloatingActionButton(
        heroTag: 'A',
        backgroundColor: bgcolor,
        onPressed: () {
          _close;
          Navigator.pushReplacementNamed(context, route);
        },
        child: Icon(icon, color: color),
      ),
    );
  }

  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
}
