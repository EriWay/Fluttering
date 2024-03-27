import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Connection extends StatelessWidget {
  const Connection({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        SvgPicture.asset(
          '/background.svg',
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'img.png',
                width: MediaQuery.of(context).size.width/3,
                alignment: Alignment.center,
              ),
              const Text("CalmLeaf Diary"),
              const Spacer(flex: 3,),
              const LoginForm(),
              const Spacer(),
            ], 
          ),
        )
      ],
    ),
  );  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _mdpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFieldWithTitle('Nom', _nomController),
            _buildTextFieldWithTitle('Mot de passe', _mdpController, obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  //_saveUser();
                }
              }, // Texte en blanc
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF755846), // Couleur mocha (marron clair)
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
              child: const Text('S\'inscrire', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildTextFieldWithTitle(String title, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF706F45)), // Texte en blanc
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Ce champ est obligatoire';
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF755846),
            hintText: 'Entrez votre $title',
            hintStyle: const TextStyle(color: Colors.white), // Texte en blanc
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}