import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'majournee.dart';
import 'package:intl/intl.dart';
// Importez la classe BDD

class PageHumeur extends StatefulWidget {
  @override
  _PageHumeur createState() => _PageHumeur();
}

class _PageHumeur extends State<PageHumeur> {
  XFile? _image;
  int selectedSmileyIndex = -1;
  String? _noteText;
  SharedPreferences? prefs;
  Color? selectedColor; // Nouvelle variable pour stocker la couleur sélectionnée


  @override
  void initState() {
    super.initState();
    requestPermission();
    _loadPrefs(); // Charger les préférences partagées au démarrage
    _getNoteText();

  }
  List<Widget> _splitTextIntoLines(String text) {
    List<Widget> textWidgets = [];

    List<String> words = text.split(' ');
    for (int i = 0; i < words.length; i += 7) {
      int end = (i + 7 < words.length) ? i + 7 : words.length;
      String line = words.sublist(i, end).join(' ');
      textWidgets.add(
        Text(
          line,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    return textWidgets;
  }


  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {}); // Mettre à jour l'état pour reconstruire le widget
  }

  Future<void> requestPermission() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      await Permission.photos.request();
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void selectSmiley(int index) {
    setState(() {
      selectedSmileyIndex = index;
      selectedColor = _getSelectedColor(index); // Mettre à jour la couleur sélectionnée
    });
    // Ajoutez ici votre logique en fonction du smiley sélectionné
  }

  Future<void> _getNoteText() async {
    prefs = await SharedPreferences.getInstance();
    String? formattedDate = prefs!.getString('selectedDate');

    if (formattedDate != null) {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'my_database.db');
      Database database = await openDatabase(path);

      List<Map<String, dynamic>> result = await database.rawQuery(
        'SELECT * FROM Notes WHERE date = ?',
        [formattedDate],
      );

      await database.close();
      if (result.isNotEmpty) {
        setState(() {
          _noteText = result[0]['texte'];
          // Récupérer la valeur de l'humeur depuis la base de données
          String humeur = result[0]['humeur'];
          // Convertir la valeur de l'humeur en index de smiley

          selectedSmileyIndex = _getSmileyIndexFromHumeur(humeur);
        });
      }
    }
  }

  int _getSmileyIndexFromHumeur(String humeur) {
    switch (humeur) {
      case "0":
        return 0; // Vert
      case "1":
        return 1; // Orange
      case "2":
        return 2; // Jaune
      case "3":
        return 3; // Orange
      case "4":
        return 4; // Rouge
      default:
        return -1; // Retourne -1 si la valeur de l'humeur n'est pas reconnue
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ma journée',
          textAlign: TextAlign.center, // Alignement du texte au centre
        ),
        backgroundColor: const Color(0xFF755846),
        centerTitle: true, // Centrer le titre
      ),
      body: prefs != null ? Stack(
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.parse(prefs!.getString('selectedDate')!)), // Utilisation de DateFormat
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    if (_image != null)
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.7,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.file(File(_image!.path)),
                        ),
                      ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.010,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                5,
                                    (index) {
                                  return SmileyButton(
                                    icon: _getSmileyIcon(index),
                                    isSelected: selectedSmileyIndex == index,
                                    onTap: () => selectSmiley(index),
                                    position: index,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/cahier.png',
                  ),
                  if (_noteText != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _splitTextIntoLines(_noteText!),
                    ),
                ],
              ),
              const Spacer(flex: 2,),
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotebookPage()));
                },
                child: const Text('Editer'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Vérifier si une note existe déjà pour la date sélectionnée
                  String? formattedDate = prefs!.getString('selectedDate');
                  String? userId = prefs!.getString('num_utilisateur'); // Récupérer l'identifiant de l'utilisateur connecté

                  if (formattedDate != null && userId != null) {
                    // Récupérer le chemin de la base de données
                    String databasesPath = await getDatabasesPath();
                    String path = join(databasesPath, 'my_database.db');
                    Database database = await openDatabase(path);

                    // Vérifier si une note existe déjà pour la date sélectionnée
                    List<Map<String, dynamic>> result = await database.rawQuery(
                      'SELECT * FROM Notes WHERE date = ? AND num_utilisateur = ?',
                      [formattedDate, userId.toString()],
                    );

                    // Si aucune note n'existe pour cette date, insérer une nouvelle note
                    if (result.isEmpty) {
                      await database.rawInsert(
                        'INSERT INTO Notes(num_utilisateur, date, humeur, image, vocal, texte) VALUES(?, ?, ?, ?, ?, ?)',
                        [userId.toString(), formattedDate, selectedSmileyIndex, '', '', ''],
                      );
                      print('Nouvelle note insérée pour la date : $formattedDate');
                    } else {
                      print('Une note existe déjà pour la date : $formattedDate');
                      await database.rawUpdate(
                        'UPDATE Notes SET humeur = ? WHERE date = ? AND num_utilisateur = ?',
                        [selectedSmileyIndex, formattedDate, userId.toString()],
                      );
                      print('Note mise à jour pour la date : $formattedDate');
                    }

                    // Fermer la connexion à la base de données
                    await database.close();
                  } else {
                    print('Date ou utilisateur non sélectionné');
                  }
                },

                child: const Text('Sauvegarder'),
              )

            ],
          ),
        ],
      ) : const Center(child: CircularProgressIndicator()), // Afficher une indication de chargement si prefs est null
    );
  }

  IconData _getSmileyIcon(int index) {
    switch (index) {
      case 0:
        return FontAwesomeIcons.solidGrin; // Sourire large
      case 1:
        return FontAwesomeIcons.solidLaugh; // Rire
      case 2:
        return FontAwesomeIcons.solidMeh; // Indifférent
      case 3:
        return FontAwesomeIcons.solidSadTear; // Triste avec larme
      case 4:
        return FontAwesomeIcons.solidTired; // Fatigué
      default:
        return FontAwesomeIcons.solidSmile;
    }
  }

  Color _getSelectedColor(int index) {
    double hue = 0.0; // Noir
    switch (index) {
      case 0:
        hue = 180; // Vert
        break;
      case 1:
        hue = 90; // Orange
        break;
      case 2:
        hue = 60.0; // Jaune
        break;
      case 3:
        hue = 30.0; // Orange
        break;
      case 4:
        hue = 0.0; // Rouge
        break;
      default:
        hue = 0.0;
    }
    return HSLColor.fromAHSL(1.0, hue, 1.0, 0.5).toColor();
  }
}

class SmileyButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final Function onTap;
  final int position;

  SmileyButton({
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    Color color = isSelected ? _getSelectedColor() : Colors.black;
    return GestureDetector(
      onTap: () => onTap(),
      child: Icon(
        icon,
        size: 24,
        color: color,
      ),
    );
  }

  Color _getSelectedColor() {
    double hue = 0.0; // Noir
    switch (position) {
      case 0:
        hue = 180; // Vert
        break;
      case 1:
        hue = 90; // Orange
        break;
      case 2:
        hue = 60.0; // Jaune
        break;
      case 3:
        hue = 30.0; // Orange
        break;
      case 4:
        hue = 0.0; // Rouge
        break;
      default:
        hue = 0.0;
    }
    return HSLColor.fromAHSL(1.0, hue, 1.0, 0.5).toColor();
  }
}
