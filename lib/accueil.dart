// accueil.dart
import 'package:flutter/material.dart';
import 'package:helloworld/menuv2.dart';

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Accueil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF755846),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFFCEBE2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Bonjour Christelle',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Citation du jour',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Card(
              color: Color(0xFFFFDCC7),
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '"Il ne savait pas que c\'était impossible, alors il l\'a fait"',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6D4C41),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Menu(),
          ],
        ),
      ),
    );
  }
}
