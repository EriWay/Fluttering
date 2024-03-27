import 'package:flutter/material.dart';
import 'menuv2.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Wellness extends StatelessWidget {

  const Wellness({super.key});
  @override

  final String date = '16.07.2024';
  Widget build(BuildContext context) {
    return MaterialApp(

        title: 'Page de bien être',
        theme: ThemeData(
          primaryColor: Color(
              0xFF755846), // Couleur mocha (marron clair)// Fond beige
        ),
        home: Scaffold(
            body: Stack(

                children: [
                  Positioned.fill(
                      child: SvgPicture.asset(
                        'background.svg',
                        fit: BoxFit
                            .cover, // Assure que l'SVG couvre tout l'écran
                      )
                  ),
                  Column(

                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Color(0xFF755846),
                          padding: EdgeInsets.all(20.0),
                          child: Text('Bien-être',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24),
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: DayDate(),
                        ),
                        Container(
                          child: Column(
                            children: [
                              SommeilText(),
                              ButtonTimeContainer(),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              HydratationText(),
                              HydratationSwitcher(),
                            ],
                          ),
                        ),
                        Menu(),
                      ]
                  )
                ]
            )
        )
    );
  }
}

class ButtonTimeContainer extends StatefulWidget {
  @override
  _ButtonTimeContainerState createState() => _ButtonTimeContainerState();
}

class _ButtonTimeContainerState extends State<ButtonTimeContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Décalage des bords gauche et droit
            child: Container(
              decoration: BoxDecoration(
                color: Color (0xFFFFDCC7),
                borderRadius: BorderRadius.circular(10.0), // Bords arrondis du conteneur
              ),
              padding: EdgeInsets.all(10.0), // Espacement intérieur du conteneur
              child: ButtonRow(), // Inclure ButtonRow à l'intérieur du conteneur
            )
        )
    );
  }
}

class DayDate extends StatelessWidget {
  @override
  String date = '16.07.2024';
  Widget build(BuildContext context) {
    return Center(
      child: Text('journée du $date',
          style : TextStyle (
              fontSize: 16.0,
              color : Color (0xFF606134)
          )
      ),
    );
  }
}

class SommeilText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Sommeil',
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF606134),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}



class ButtonInfo {
  String text;
  Color color;
  ButtonInfo({required this.text, required this.color});
}

class ButtonRow extends StatefulWidget {
  @override
  _ButtonRowState createState() => _ButtonRowState();
}

class _ButtonRowState extends State<ButtonRow> {
  int _activeButtonIndex = -1;
  List<ButtonInfo> buttons = [
    ButtonInfo(text: " moins de 2h", color: Color(0xFFFFDCC7)),
    ButtonInfo(text: "2h à 4h", color: Color(0xFFFFDCC7)),
    ButtonInfo(text: "4h à 6h", color: Color(0xFFFFDCC7)),
    ButtonInfo(text: "6h à 8h", color: Color(0xFFFFDCC7)),
    ButtonInfo(text: "8h à 10h", color: Color(0xFFFFDCC7)),
    ButtonInfo(text: "plus de 10h", color: Color(0xFFFFDCC7)),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10.0, // Espacement horizontal entre les boutons
        runSpacing: 10.0, // Espacement vertical entre les lignes de boutons
        alignment: WrapAlignment.center, // Alignement des boutons au centre
        children: List.generate(buttons.length, (index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: buttons[index].color),
            onPressed: () {
              setState(() {
                // Vérifie si le bouton actif est le même que celui sur lequel on vient d'appuyer
                if (_activeButtonIndex == index) {
                  // Restaure la couleur d'origine
                  buttons[index].color = Color(0xFFFFDCC7);
                  _activeButtonIndex = -1; // Aucun bouton actif
                } else {
                  // Met à jour la couleur du bouton actif en VERT
                  for (var i = 0; i < buttons.length; i++) {
                    buttons[i].color = Color(0xFFFFDCC7);
                  }
                  buttons[index].color = Color(0xFF606134);
                  _activeButtonIndex = index;
                }
              });
            },
            child: Text(
              buttons[index].text,
              style: TextStyle(
                color: _activeButtonIndex == index ? Colors.white : Colors.black,
              ),
            ),
          );
        }),
      ),
    );
  }
}



class HydratationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Hydratation',
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF606134),
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

class HydratationSwitcher extends StatefulWidget {
  @override
  _HydratationSwitcherState createState() => _HydratationSwitcherState();
}

class VerreInfo {
  String imagePlein;
  String imageVide;
  bool estPlein;

  VerreInfo({
    required this.imagePlein,
    required this.imageVide,
    this.estPlein = false,
  });
}


class _HydratationSwitcherState extends State<HydratationSwitcher> {
  List<VerreInfo> verres = [
    VerreInfo(imagePlein: 'verre_plein.svg', imageVide: 'verre_vide.svg'),
    VerreInfo(imagePlein: 'verre_plein.png', imageVide: 'verre_vide.png', estPlein: true),
    VerreInfo(imagePlein: 'verre_plein.png', imageVide: 'verre_vide.png'),
    // Ajoutez autant de verres que nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10.0, // Espacement horizontal entre les verres
        runSpacing: 10.0, // Espacement vertical entre les lignes de verres
        alignment: WrapAlignment.center, // Alignement des verres au centre
        children: List.generate(verres.length, (index) {
          VerreInfo verre = verres[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: verre.estPlein ? Colors.green : Color(0xFFFFDCC7), // Vert si plein, sinon couleur d'origine
              minimumSize: Size(100, 100), // Taille minimum du bouton
            ),
            onPressed: () {
              setState(() {
                verres[index].estPlein = !verres[index].estPlein;
              });
            },
            child: Image.asset(
              verre.estPlein ? verre.imagePlein : verre.imageVide,
              fit: BoxFit.cover, // Pour que l'image prenne toute la place du bouton
            ),
          );
        }),
      ),
    );
  }
}