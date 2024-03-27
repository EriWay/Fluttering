
import 'menuv2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ParametresPage extends StatefulWidget {
  @override
  _ParametresPageState createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  bool isVolumeOn = true;
  bool isNotificationsOn = true;
  bool isGalleryOn = true;
  bool isMicroOn = true;
  bool isCameraOn = true;
  final iconColor = Color(0xFF606134);

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToChangePassword(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ChangePasswordScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ));
  }

  void _navigateToMail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MailScreen(),
      ),
    );
  }

  void _navigateToCodePin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CodePinScreen(),
      ),
    );
  }

  void _navigateToPhone(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PhoneScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paramètres'),
        backgroundColor: Color(0xFF755846),
      ),
      body: ListView(
        children: ListTile.divideTiles(
          color: Colors.grey,
          context: context,
          tiles: [
            SwitchListTile(
              title: Text('Volume'),
              value: isVolumeOn,
              onChanged: (bool value) {
                setState(() {
                  isVolumeOn = value;
                });
              },
              secondary: Icon(
                  isVolumeOn
                      ? FontAwesomeIcons.volumeUp
                      : FontAwesomeIcons.volumeMute,
                  color: iconColor),
              activeColor: iconColor,
              activeTrackColor: iconColor.withOpacity(0.5),
            ),
            ListTile(
              title: Text('Téléphone'),
              leading: Icon(FontAwesomeIcons.phone, color: iconColor),
              onTap: () => _navigateToPhone(context),
            ),
            ListTile(
              title: Text('Mail'),
              leading: Icon(FontAwesomeIcons.envelope, color: iconColor),
              onTap: () => _navigateToMail(context),
            ),
            ListTile(
              title: Text('Mot de passe'),
              leading: Icon(FontAwesomeIcons.lock, color: iconColor),
              onTap: () => _navigateToChangePassword(context),
            ),
            ListTile(
              title: Text('Code PIN'),
              leading: Icon(FontAwesomeIcons.key, color: iconColor),
              onTap: () => _navigateToCodePin(context),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Autorisations',
                      style: Theme.of(context).textTheme.headline6),
                  SwitchListTile(
                    title: Text('Notifications'),
                    value: isNotificationsOn,
                    onChanged: (bool value) {
                      setState(() {
                        isNotificationsOn = value;
                      });
                    },
                    secondary: Icon(FontAwesomeIcons.bell, color: iconColor),
                    activeColor: iconColor,
                    activeTrackColor: iconColor.withOpacity(0.5),
                  ),
                  SwitchListTile(
                    title: Text('Galerie'),
                    value: isGalleryOn,
                    onChanged: (bool value) {
                      setState(() {
                        isGalleryOn = value;
                      });
                    },
                    secondary: Icon(FontAwesomeIcons.images, color: iconColor),
                    activeColor: iconColor,
                    activeTrackColor: iconColor.withOpacity(0.5),
                  ),
                  SwitchListTile(
                    title: Text('Micro'),
                    value: isMicroOn,
                    onChanged: (bool value) {
                      setState(() {
                        isMicroOn = value;
                      });
                    },
                    secondary:
                        Icon(FontAwesomeIcons.microphone, color: iconColor),
                    activeColor: iconColor,
                    activeTrackColor: iconColor.withOpacity(0.5),
                  ),
                  SwitchListTile(
                    title: Text('Caméra'),
                    value: isCameraOn,
                    onChanged: (bool value) {
                      setState(() {
                        isCameraOn = value;
                      });
                    },
                    secondary:
                        Icon(FontAwesomeIcons.cameraRetro, color: iconColor),
                    activeColor: iconColor,
                    activeTrackColor: iconColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Déconnexion'),
              leading: Icon(FontAwesomeIcons.powerOff, color: iconColor),
              onTap: () => _showMessage('Déconnexion cliquée'),
            ),
          ],
        ).toList(),
      ),
      backgroundColor: Color(0xFFFCEBE2),
    );
  }
}

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Changer le mot de passe'),
        backgroundColor: Color(0xFF755846), // Couleur de l'appBar inchangée
      ),
      backgroundColor: Color(0xFFFCEBE2), // Couleur de fond changée ici
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: Colors.green, // Couleur du curseur
                ),
                child: TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF606134), // Bordure par défaut
                        width: 1.25, // Épaisseur de la bordure
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF606134), // Couleur lorsqu'on écrit
                        width: 2.0 *
                            2.0, // Épaisseur de la bordure multipliée par 3
                      ),
                    ),
                    labelText: 'Nouveau mot de passe',
                    labelStyle: TextStyle(
                      color: Color(
                          0xFF606134), // Couleur du texte de la bordure changée ici
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: Color(0xFF606134),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Theme(
                data: Theme.of(context).copyWith(
                  primaryColor: Color(0xFF606134), // Couleur du curseur
                ),
                child: TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF606134), // Bordure par défaut
                        width: 1.25, // Épaisseur de la bordure
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF606134), // Couleur lorsqu'on écrit
                        width: 2.0 *
                            2.0, // Épaisseur de la bordure multipliée par 3
                      ),
                    ),
                    labelText: 'Confirmez le mot de passe',
                    labelStyle: TextStyle(
                      color: Color(
                          0xFF606134), // Couleur du texte de la bordure changée ici
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: Color(0xFF606134),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Logique de changement de mot de passe
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(
                      0xFF606134)), // Couleur du fond du bouton changée ici
                ),
                child: Text('Changer le mot de passe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MailScreen extends StatefulWidget {
  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  final TextEditingController _mailController = TextEditingController();

  void _changeMail() {
    // Logique de changement d'adresse mail (simulation)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Changement d\'adresse mail'),
          content: Text(
              'Votre adresse mail serait changée en: ${_mailController.text}'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mail'),
        backgroundColor: Color(0xFF755846),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Color(0xFF606134), // Couleur du curseur
              ),
              child: TextField(
                controller: _mailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF606134), // Bordure par défaut
                      width: 1.25, // Épaisseur de la bordure multipliée par 3
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF606134), // Couleur lorsqu'on écrit
                      width: 2.0 *
                          2.0, // Épaisseur de la bordure lors de la saisie
                    ),
                  ),
                  labelText: 'Nouvelle adresse mail',
                  labelStyle: TextStyle(
                    color: Color(0xFF606134), // Couleur du texte du label
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeMail,
              child: Text('Changer l\'adresse mail'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF755846)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mailController.dispose();
    super.dispose();
  }
}

class CodePinScreen extends StatefulWidget {
  @override
  _CodePinScreenState createState() => _CodePinScreenState();
}

class _CodePinScreenState extends State<CodePinScreen> {
  final TextEditingController pinController = TextEditingController();

  void _verifyAndNavigate() {
    if (pinController.text == PinService.currentPin) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ChangePinScreen()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Code PIN incorrect")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code PIN'),
        backgroundColor: Color(0xFF755846),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: pinController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF606134),
                    width: 1.25,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF606134),
                    width: 2.0 * 2.0,
                  ),
                ),
                labelText: 'Entrez votre code PIN actuel',
                labelStyle: TextStyle(
                  color: Color(0xFF606134),
                ),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyAndNavigate,
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF606134), // Couleur de fond du bouton
              ),
              child: Text('Vérifier'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePinScreen extends StatefulWidget {
  @override
  _ChangePinScreenState createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final TextEditingController newPinController = TextEditingController();

  void _changePin() {
    PinService.currentPin = newPinController.text;
    Navigator.popUntil(context, ModalRoute.withName('/'));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Code PIN changé avec succès")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Changer le Code PIN'),
        backgroundColor: Color(0xFF755846),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: newPinController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF606134),
                    width: 1.25,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF606134),
                    width: 2.0 * 2.0,
                  ),
                ),
                labelText: 'Nouveau code PIN',
                labelStyle: TextStyle(
                  color: Color(0xFF606134),
                ),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePin,
              child: Text('Changer'),
            ),
          ],
        ),
      ),
    );
  }
}

class PinService {
  static String currentPin = "0000"; // Code PIN par défaut
}

class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _changePhone() {
    // Logique pour changer le numéro de téléphone
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Changement de numéro de téléphone'),
          content: Text(
              'Votre numéro de téléphone sera changé en : ${_phoneController.text}.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Téléphone'),
        backgroundColor: Color(0xFF755846),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number, // Clavier numérique
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  // Bordure en état de saisie
                  borderSide: BorderSide(
                    color: Color(0xFF606134), // Couleur spécifique
                    width: 2.0 * 2.0,
                  ),
                ),
                labelText: 'Nouveau numéro de téléphone',
                labelStyle: TextStyle(
                  color: Color(0xFF606134),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePhone,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color(0xFF606134)), // Couleur du bouton
              ),
              child: Text('Changer le numéro de téléphone'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}

