import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'menuv2.dart';

class ParametresPage extends StatefulWidget {
  @override
  _ParametresPageState createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  bool isVolumeOn =
      true; // Exemple, cette permission n'est pas gérée par permission_handler
  bool isNotificationsOn = true;
  bool isGalleryOn = true;
  bool isMicroOn = true;
  bool isCameraOn = true;
  final iconColor = Color(0xFF606134);

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  void _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.photos,
      Permission.notification,
    ].request();

    setState(() {
      isCameraOn = statuses[Permission.camera]?.isGranted ?? false;
      isMicroOn = statuses[Permission.microphone]?.isGranted ?? false;
      isGalleryOn = statuses[Permission.photos]?.isGranted ?? false;
      isNotificationsOn = statuses[Permission.notification]?.isGranted ?? false;
    });
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paramètres',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF755846),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/background.svg',
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: ListTile.divideTiles(
              color: Colors.grey,
              context: context,
              tiles: [
                SwitchListTile(
                  title: const Text('Volume'),
                  value: isVolumeOn,
                  onChanged: (bool value) {
                    setState(() {
                      isVolumeOn = value;
                    });
                  },
                  secondary: Icon(
                    isVolumeOn
                        ? FontAwesomeIcons.volumeHigh
                        : FontAwesomeIcons.volumeXmark,
                    color: iconColor,
                  ),
                  activeColor: iconColor,
                  activeTrackColor: iconColor.withOpacity(0.5),
                ),
                ListTile(
                  title: const Text('Téléphone'),
                  leading: Icon(FontAwesomeIcons.phone, color: iconColor),
                  onTap: () => _navigateToPhone(context),
                ),
                ListTile(
                  title: const Text('Mail'),
                  leading: Icon(FontAwesomeIcons.envelope, color: iconColor),
                  onTap: () => _navigateToMail(context),
                ),
                ListTile(
                  title: const Text('Mot de passe'),
                  leading: Icon(FontAwesomeIcons.lock, color: iconColor),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(),
                    ));
                  },
                ),
                ListTile(
                  title: const Text('Code PIN'),
                  leading: Icon(FontAwesomeIcons.key, color: iconColor),
                  onTap: () => _navigateToCodePin(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Autorisations',
                          style: Theme.of(context).textTheme.titleLarge),
                      SwitchListTile(
                        title: const Text('Notifications'),
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
                        title: const Text('Galerie'),
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
                        title: const Text('Micro'),
                        value: isMicroOn,
                        onChanged: (bool value) {
                          setState(() {
                            isMicroOn = value;
                          });
                        },
                        secondary: Icon(FontAwesomeIcons.microphone, color: iconColor),
                        activeColor: iconColor,
                        activeTrackColor: iconColor.withOpacity(0.5),
                      ),
                      SwitchListTile(
                        title: const Text('Caméra'),
                        value: isCameraOn,
                        onChanged: (bool value) {
                          setState(() {
                            isCameraOn = value;
                          });
                        },
                        secondary: Icon(FontAwesomeIcons.cameraRetro, color: iconColor),
                        activeColor: iconColor,
                        activeTrackColor: iconColor.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Déconnexion'),
                  leading: Icon(FontAwesomeIcons.powerOff, color: iconColor),
                  onTap: () => _logout(context),
                ),
                const Menu(),
              ],
            ).toList(),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFFCEBE2),
    );
  }

  void _logout(BuildContext context) async {
    // Effacer les préférences partagées ici
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Naviguer vers la page de connexion (Login.dart)
    Navigator.pushNamedAndRemoveUntil(context, '/choose', (route) => false);
  }


  void _navigateToMail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MailScreen(),
    ));
  }

  void _navigateToCodePin(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CodePinScreen(),
    ));
  }

  void _navigateToPhone(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PhoneScreen(),
    ));
  }
}

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _changePassword(BuildContext context) async {
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword == confirmPassword) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String userId = prefs.getString('num_utilisateur') ?? '0';
        String databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'my_database.db');
        Database database = await openDatabase(path);

        await database.rawUpdate(
            'UPDATE User SET mdp = ? WHERE num_utilisateur = ?',
            [_newPasswordController.text, userId]);

        await database.close();
        // Affiche un message de succès si la mise à jour du mot de passe est réussie
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mot de passe changé avec succès')),
        );
      } catch (error) {
        // Affiche un message d'erreur si la mise à jour du mot de passe échoue
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors du changement de mot de passe')),
        );
      }
    } else {
      // Affiche un message d'erreur si les mots de passe ne correspondent pas
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les mots de passe ne correspondent pas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Changer le mot de passe',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF755846),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            fit: BoxFit.cover, // Assurez-vous que l'image SVG couvre tout l'écran
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF606134),
                          width: 1.25,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF606134),
                          width: 2.0 * 2.0,
                        ),
                      ),
                      labelText: 'Nouveau mot de passe',
                      labelStyle: const TextStyle(
                        color: Color(0xFF606134),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF606134),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF606134),
                          width: 1.25,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF606134),
                          width: 2.0 * 2.0,
                        ),
                      ),
                      labelText: 'Confirmez le mot de passe',
                      labelStyle: const TextStyle(
                        color: Color(0xFF606134),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF606134),
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => _changePassword(context),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF755846)),
                    ),
                    child: const Text(
                      'Changer le mot de passe',
                      style: TextStyle(color: Colors.white),
                    ),
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
  class MailScreen extends StatefulWidget {
  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  final TextEditingController _mailController = TextEditingController();

  Future<void> _changeMail(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('num_utilisateur') ?? '0';
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'my_database.db');
      Database database = await openDatabase(path);

      await database.rawUpdate(
          'UPDATE User SET mail = ? WHERE num_utilisateur = ?',
          [_mailController.text, userId]);

      await database.close();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Votre mail a correctement été mis à jour')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors du changement de mail')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mail'),
        backgroundColor: const Color(0xFF755846),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            fit: BoxFit.cover, // Assurez-vous que l'image SVG couvre tout l'écran
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _mailController,
                  decoration: const InputDecoration(
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
                    labelText: 'Nouvelle adresse mail',
                    labelStyle: TextStyle(
                      color: Color(0xFF606134),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _changeMail(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFF755846)),
                  ),
                  child: const Text('Changer l\'adresse mail', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
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
  final TextEditingController newPinController = TextEditingController();
  final bool _obscureText = true;

  Future<void> _changePin(BuildContext context) async {
    String newPin = newPinController.text;

    // Vérification des conditions du nouveau code PIN (par exemple, longueur)
    if (newPin.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le code PIN doit contenir au moins 4 chiffres'),
        ),
      );
      return;
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('num_utilisateur') ?? '0';
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'my_database.db');
      Database database = await openDatabase(path);

      await database.rawUpdate(
          'UPDATE User SET PIN = ? WHERE num_utilisateur = ?',
          [newPinController.text, userId]);

      await database.close();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Code PIN changé avec succès')),
      );
    } catch (error) {
      // Affiche un message d'erreur si la mise à jour du mot de passe échoue
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors du changement du PIN')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code PIN'),
        backgroundColor: const Color(0xFF755846),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            alignment: Alignment.center,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: newPinController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF606134),
                        width: 2.0 * 2.0,
                      ),
                    ),
                    labelText: 'Entrez votre nouveau code PIN',
                    labelStyle: TextStyle(
                      color: Color(0xFF606134),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: _obscureText,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _changePin(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF755846),
                  ),
                  child: const Text('Changer le code PIN', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class PhoneScreen extends StatefulWidget {
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _changePhone(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('num_utilisateur') ?? '0';
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'my_database.db');
      Database database = await openDatabase(path);

      await database.rawUpdate(
          'UPDATE User SET num_telephone = ? WHERE num_utilisateur = ?',
          [_phoneController.text, userId]);

      await database.close();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Numéro de téléphone mis à jour avec succès')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la mise à jour du numéro de téléphone')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Téléphone'),
        backgroundColor: const Color(0xFF755846),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            'assets/background.svg',
            fit: BoxFit.cover, // Assurez-vous que l'image SVG couvre tout l'écran
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF606134),
                        width: 2.0 * 2.0,
                      ),
                    ),
                    labelText: 'Nouveau numéro de téléphone',
                    labelStyle: TextStyle(
                      color: Color(0xFF606134),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _changePhone(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFF755846)),
                  ),
                  child: const Text('Changer le numéro de téléphone', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}