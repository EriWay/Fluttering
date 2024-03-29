import 'package:flutter/material.dart';
import 'menuv2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';


/*TODO : mettre une variable sur le nombre de verre, sommeil, productivité et
        activité (string), + back date
        visuel ok
*/

class Wellness extends StatelessWidget {
  const Wellness({super.key});

  final String date = '16.07.2024';

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page de bien être',
      theme: ThemeData(
        primaryColor: const Color(0xFF755846), // Couleur mocha (marron clair) // Fond beige
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            // Cela va retirer le focus du TextField actuel si l'utilisateur tapote en dehors du TextField
            // et ainsi fermer le clavier
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/background.svg',
                  fit: BoxFit.cover, // Assure que l'SVG couvre tout l'écran
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 80.0), // Ajustez cette valeur en fonction de la hauteur de votre header
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: DayDate(),
                    ),
                    Column(
                      children: [
                        SommeilText(),
                        ButtonRow(),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    Column(
                      children: [
                        HydratationText(),
                        HydratationSwitcher(),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                    ),

                    Column(
                      children: [
                      ActivityText(),
                      const ActivityTextField(),
                  ]
                ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                    ),

                    Column(
                        children: [
                          ProductiviteText(),
                          StarSwitcher(),
                        ]
                    ),
                    const Menu(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF755846),
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: const Text(
                    'Bien-être',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonTimeContainer extends StatefulWidget {
  const ButtonTimeContainer({super.key});
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
                color: const Color (0xFFFFDCC7),
                borderRadius: BorderRadius.circular(10.0), // Bords arrondis du conteneur
              ),
              padding: const EdgeInsets.all(10.0), // Espacement intérieur du conteneur
              child: ButtonRow(), // Inclure ButtonRow à l'intérieur du conteneur
            )
        )
    );
  }
}

class DayDate extends StatelessWidget {
  final date = "16.07.2024";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Journée du ",
              style: TextStyle(
                  color: Color(0xFF606134),
                  fontSize: 17,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300),
            ),
            TextSpan(
              text: date,
              style: const TextStyle(
                  color: Color(0xFF606134),
                  fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500),
            )
          ],
        ),
      )
    );
  }
}

class SommeilText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
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
    ButtonInfo(text: " moins de 2h", color: const Color(0xFFFFDCC7) ),
    ButtonInfo(text: "2h à 4h", color: const Color(0xFFFFDCC7)),
    ButtonInfo(text: "4h à 6h", color: const Color(0xFFFFDCC7)),
    ButtonInfo(text: "6h à 8h", color: const Color(0xFFFFDCC7)),
    ButtonInfo(text: "8h à 10h", color: const Color(0xFFFFDCC7)),
    ButtonInfo(text: "plus de 10h", color: const Color(0xFFFFDCC7)),
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
            onPressed: () {
              setState(() {
                // Vérifie si le bouton actif est le même que celui sur lequel on vient d'appuyer
                if (_activeButtonIndex == index) {
                  // Restaure la couleur d'origine
                  buttons[index].color = const Color(0xFFFFDCC7);
                  _activeButtonIndex = -1; // Aucun bouton actif
                } else {
                  // Met à jour la couleur du bouton actif en VERT
                  for (var i = 0; i < buttons.length; i++) {
                    buttons[i].color = const Color(0xFFFFDCC7);
                  }
                  buttons[index].color = const Color(0xFF606134);
                  _activeButtonIndex = index;
                }
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: buttons[index].color,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400, // Gras pour le texte du bouton
            )),
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
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
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
void saveHydration(int verresPleins) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'my_database.db');
  final database = await openDatabase(path);

  // Ajustez ce code pour qu'il utilise l'ID de l'utilisateur connecté si nécessaire
  const userId = 1; // Par exemple, pour un utilisateur avec un ID fixe

  // Insérez ou mettez à jour le nombre de verres pleins pour la date du jour
  await database.insert(
    'BienEtre',
    {
      'num_utilisateur': userId,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'eau': verresPleins,
    },
    conflictAlgorithm: ConflictAlgorithm.replace, // Remplacez si déjà présent
  );

  await database.close();
}

class _HydratationSwitcherState extends State<HydratationSwitcher> {
  List<VerreInfo> verres = [
    VerreInfo(imagePlein: 'assets/verre_plein.png', imageVide: 'assets/verre_vide.png'),
    VerreInfo(imagePlein: 'assets/verre_plein.png', imageVide: 'assets/verre_vide.png'),
    VerreInfo(imagePlein: 'assets/verre_plein.png', imageVide: 'assets/verre_vide.png'),
    VerreInfo(imagePlein: 'assets/verre_plein.png', imageVide: 'assets/verre_vide.png'),
    VerreInfo(imagePlein: 'assets/verre_plein.png', imageVide: 'assets/verre_vide.png'),
    VerreInfo(imagePlein: 'assets/verre_plein.png', imageVide: 'assets/verre_vide.png'),
    VerreInfo(imagePlein: 'assets/verre_plein.png', imageVide: 'assets/verre_vide.png'),
    VerreInfo(imagePlein: 'assets/verre_plein.png', imageVide: 'assets/verre_vide.png'),
    // Ajoutez autant de verres que nécessaire
  ];

  void _handleTap(int tappedIndex) {
    setState(() {
      for (int i = 0; i < verres.length; i++) {
        // Si l'index de l'étoile est inférieur ou égal à l'index tapé, marquez-le comme plein
        if (i <= tappedIndex) {
          saveHydration(tappedIndex + 1);

          verres[i].estPlein = true;
        } else {
          // Sinon, marquez-le comme vide
          verres[i].estPlein = false;
        }
      }
    });
  }
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
              backgroundColor: const Color(0xffFFDCC7), // Vert si plein, sinon couleur d'origine
              minimumSize: const Size(20, 40), // Taille minimum du bouton
            ),
            onPressed: () => _handleTap(index),
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

class ButtonHydratationContainer extends StatefulWidget {
  @override
  _ButtonHydratationContainerState createState() => _ButtonHydratationContainerState();
}

class _ButtonHydratationContainerState extends State<ButtonHydratationContainer> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Décalage des bords gauche et droit
            child: Container(
              decoration: BoxDecoration(
                color: const Color (0xFFFFDCC7),
                borderRadius: BorderRadius.circular(10.0), // Bords arrondis du conteneur
              ),
              padding: const EdgeInsets.all(10.0), // Espacement intérieur du conteneur
              child: HydratationSwitcher(), // Inclure ButtonRow à l'intérieur du conteneur
            )
        )
    );
  }
}

class ActivityText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Activité',
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

class ActivityTextField extends StatelessWidget {
  const ActivityTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Utilisation d'un GestureDetector pour détecter les touchers en dehors du TextField
    return GestureDetector(
      onTap: () {
        // Enlève le focus du TextField actuellement en focus et ferme le clavier
        FocusScope.of(context).requestFocus(FocusNode());
      },
      // Utilisation d'un comportement opaque pour s'assurer que le GestureDetector capture le toucher
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(left :20.0, right : 20),
        child: SingleChildScrollView(
          reverse: true,
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null, // Permet au TextField de prendre plusieurs lignes
            decoration: InputDecoration(
              hintText: 'Quelle activité faite aujourd\'hui vous rend fier?',
              hintStyle: const TextStyle( // Personnaliser le style du label/hint
                color: Color(0x7F606134), // Couleur du texte du label
                fontSize: 14.0, // Taille de la police
                fontStyle: FontStyle.italic, // Style de la police
              ),
              fillColor: const Color(0xFFFFDCC7),
              filled: true,

              border: OutlineInputBorder( // Bordure appliquée en tous temps
                borderRadius: BorderRadius.circular(8.0), // Bords arrondis
                borderSide: BorderSide.none, // Aucune ligne/bordure
              ),
              enabledBorder: OutlineInputBorder( // Bordure en état normal
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder( // Bordure quand le TextField est en focus
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder( // Bordure en cas d'erreur
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder( // Bordure en focus lorsqu'il y a une erreur
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),// Active le remplissage
            ),
          ),
        ),
      ),
    );
  }
}

class StarSwitcher extends StatefulWidget {
  @override
  _StarSwitcherState createState() => _StarSwitcherState();
}

void saveProductivity(int stars) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'my_database.db');
  final database = await openDatabase(path);

  // Utilisez l'ID réel de l'utilisateur connecté
  final userId = 1; // Exemple pour un utilisateur avec un ID fixe

  // Insérez ou mettez à jour le nombre d'étoiles pour la date du jour
  await database.insert(
    'BienEtre',
    {
      'num_utilisateur': userId,
      'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'productivite': stars,
      // Assurez-vous de mettre à jour ou d'insérer d'autres champs pertinents si nécessaire
    },
    conflictAlgorithm: ConflictAlgorithm.replace, // Remplacez si une entrée existe déjà
  );

  await database.close();
}
class ProductiviteText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Productivité',
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


class StarInfo {
  String imagePlein;
  String imageVide;
  bool estPlein;

  StarInfo({
    required this.imagePlein,
    required this.imageVide,
    this.estPlein = false,
  });
}


class _StarSwitcherState extends State<StarSwitcher> {
  List<StarInfo> stars = [
    StarInfo(imagePlein: 'assets/Filled_star.png', imageVide: 'assets/empty_star.png'),
    StarInfo(imagePlein: 'assets/Filled_star.png', imageVide: 'assets/empty_star.png'),
    StarInfo(imagePlein: 'assets/Filled_star.png', imageVide: 'assets/empty_star.png'),
    StarInfo(imagePlein: 'assets/Filled_star.png', imageVide: 'assets/empty_star.png'),
    StarInfo(imagePlein: 'assets/Filled_star.png', imageVide: 'assets/empty_star.png'),
  ];

  void _handleTap(int tappedIndex) {
    setState(() {
      for (int i = 0; i < stars.length; i++) {
        saveProductivity(tappedIndex + 1);
        // Si l'index de l'étoile est inférieur ou égal à l'index tapé, marquez-le comme plein
        if (i <= tappedIndex) {
          stars[i].estPlein = true;
        } else {
          // Sinon, marquez-le comme vide
          stars[i].estPlein = false;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 5.0, // Espacement horizontal entre les verres
        runSpacing: 10.0, // Espacement vertical entre les lignes de verres
        alignment: WrapAlignment.center, // Alignement des verres au centre
        children: List.generate(stars.length, (index) {
          StarInfo star = stars[index];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFFDCC7), // Vert si plein, sinon couleur d'origine
              minimumSize: const Size(10, 40), // Taille minimum du bouton
            ),
            onPressed: () => _handleTap(index),
            child: Image.asset(
              star.estPlein ? star.imagePlein : star.imageVide,
              fit: BoxFit.cover, // Pour que l'image prenne toute la place du bouton
            ),
          );
        }),
      ),
    );
  }
}
