import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotebookBackgroundPage extends StatefulWidget {
  @override
  _NotebookBackgroundPageState createState() => _NotebookBackgroundPageState();
}

class _NotebookBackgroundPageState extends State<NotebookBackgroundPage> {
  XFile? _image;
  int selectedSmileyIndex = -1;

  @override
  void initState() {
    super.initState();
    requestPermission();
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
    });
    // Ajoutez ici votre logique en fonction du smiley sélectionné
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page avec Fond de Cahier'),
        backgroundColor: Color(0xFF755846),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFCEBE2),
          image: DecorationImage(
            image: AssetImage('assets/cahier.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _getCurrentDate(),
                textAlign: TextAlign.center,
                style: TextStyle(
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
                      child: Row(
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
                    ),
                  ),
                ],
              ),
            ),
            // Ajoutez ici d'autres éléments si nécessaire
          ],
        ),
      ),
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

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year}";
    return formattedDate;
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
