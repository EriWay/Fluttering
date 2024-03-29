import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'majourneehumeur.dart';

class NotebookPage extends StatefulWidget {
  @override
  NotebookPageState createState() => NotebookPageState();
}

class NotebookPageState extends State<NotebookPage> {

  final TextEditingController _textEditingController = TextEditingController();
  XFile? _image;
  String? _noteText;

  @override
  void initState() {
    super.initState();
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

  Future<void> _getNoteText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? formattedDate = prefs.getString('selectedDate');

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
        });
      }
    }
  }

  Future<void> postNotes(String notes) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? formattedDate = prefs.getString('selectedDate');
    String idUser = prefs.getString('num_utilisateur') ?? '';
    int idUserint = int.parse(idUser);

    if (formattedDate != null) {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'my_database.db');
      Database database = await openDatabase(path);
    //Verif si y a une note 
    List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT * FROM Notes WHERE date = ?',
      [formattedDate],
    );
    if (result.isEmpty) {
      await database.rawInsert(
        'INSERT INTO Notes(num_utilisateur, date, humeur, image, vocal, texte) VALUES(?, ?, ?, ?, ?, ?)',
        [idUserint, formattedDate, 'Humeur', '', '', notes],
      );
      print('Nouvelle note insérée pour la date : $formattedDate');
    } else {
      print('Une note existe déjà pour la date : $formattedDate');
      await database.rawQuery("UPDATE Notes SET texte = '$notes' WHERE num_utilisateur ='$idUser'AND date = '$formattedDate'");
    }

//num_utilisateur INTEGER, date TEXT PRIMARY KEY, humeur TEXT, image TEXT, vocal TEXT, texte TEXT
      
    }
  }

bool once=false;
TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(!once){
      _getNoteText();
      once=!once;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Intime'),
        backgroundColor: const Color(0xFF755846),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFCEBE2),
              image: DecorationImage(
                image: AssetImage('assets/cahier.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: MediaQuery.of(context).size.height * 0.2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_image != null) Image.file(File(_image!.path)),
                  TextField(
                    controller: _controller = TextEditingController(text: _noteText,),
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Écrivez ici...",
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0)
                          .copyWith(left: 20.0),
                      alignLabelWithHint: true,
                    ),
                    textAlignVertical: const TextAlignVertical(y: 0.2),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'Save',
                    onPressed: () async {
                      await postNotes(_controller.text);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PageHumeur()),ModalRoute.withName('/calendar'));
                    },
                    backgroundColor: const Color(0xFF606134),
                    child: const Icon(Icons.save, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    heroTag: 'Edit',
                    onPressed: () {
                      // Action pour éditer
                    },
                    backgroundColor: const Color(0xFF606134),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    heroTag: 'add',
                    onPressed: () async {
                      await requestPermission();
                      await pickImage();
                    },
                    backgroundColor: const Color(0xFF606134),
                    child: const Icon(Icons.photo_library, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
