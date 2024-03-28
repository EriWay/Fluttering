import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class NotebookBackgroundPage extends StatefulWidget {
  @override
  _NotebookBackgroundPageState createState() => _NotebookBackgroundPageState();
}

class _NotebookBackgroundPageState extends State<NotebookBackgroundPage> {
  final TextEditingController _textEditingController = TextEditingController();
  XFile? _image;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page avec Fond de Cahier'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
                    controller: _textEditingController,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Écrivez ici...",
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0)
                          .copyWith(left: 20.0),
                      alignLabelWithHint: true,
                    ),
                    textAlignVertical: TextAlignVertical(y: 0.2),
                  ),
                ],
              ),
            ),
          ),
          // Positionnement de l'icône de la galerie en bas à droite
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: () async {
                  await requestPermission();
                  await pickImage();
                },
                backgroundColor: Color(0xFF606134), // Couleur du bouton
                child: Icon(Icons.photo_library, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}