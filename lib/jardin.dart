import 'package:flutter/material.dart';
import 'menuv2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'BDD.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Jardin extends StatelessWidget{
  Jardin({super.key});

  final _popupMenu = GlobalKey<PopupMenuButtonState>();
  
  Future<String> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('prenom') ?? ''; // Retourner une chaîne vide si le prénom n'est pas trouvé
  }

  var pot1 = [0,9];
  var pot2 = [0,9];
  var pot3 = [0,9];
  var pot4 = [0,9];
  var pot5 = [0,9];
  var pot6 = [0,9];
  var pot7 = [0,9];
  var pot8 = [0,9];
  var pot9 = [0,9];

  @override
  Widget build(BuildContext context) {
  if (true) {() async {
    pot1 = await getFleur(1);
    pot2 = await getFleur(2);
    pot3 = await getFleur(3);
    pot4 = await getFleur(4);
    pot5 = await getFleur(5);
    pot6 = await getFleur(6);
    pot7 = await getFleur(7);
    pot8 = await getFleur(8);
    pot9 = await getFleur(9);
  };
  }

    return  Scaffold (
      appBar: AppBar(
        title: const Text(
          'Mon jardin secret',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF755846),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(
            'assets/background.svg',
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              const Spacer(),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0x00000000),
                          shadowColor: const Color(0x00000000),
                          surfaceTintColor: const Color(0x00000000),
                          foregroundColor: const Color(0x00000000),
                        ),

                        onPressed: () {
                        }, 
                        child: Image.asset('assets/Fleur${pot1[0]}${pot1[1]}.png')
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: (){}, 
                          child: Image.asset('assets/Fleur${pot2[0]}${pot2[1]}.png')
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: (){}, 
                          child: Image.asset('assets/Fleur${pot2[0]}${pot2[1]}.png')
                        ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton(
                        key: _popupMenu,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Graine 1", 0, 1),
                          _buildPopupMenuItem("Graine 2", 1, 1),
                          _buildPopupMenuItem("Graine 3", 2, 1),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            pot1 = await getFleur(1);
                            _popupMenu.currentState?.showButtonMenu();
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),
                      
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0x00000000),
                          shadowColor: const Color(0x00000000),
                          surfaceTintColor: const Color(0x00000000),
                        ),
                        onPressed: (){}, 
                        child: Image.asset('assets/Pot.png')
                        ),
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0x00000000),
                          shadowColor: const Color(0x00000000),
                          surfaceTintColor: const Color(0x00000000),
                        ),
                        onPressed: (){}, 
                        child: Image.asset('assets/Pot.png')
                        ),
                    ],
                  ),
                ]
              ),
              
              
              Image.asset('assets/etagewe.png'),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                ],
              ),
              Image.asset('assets/etagewe.png'),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onHover: (value) {},
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                    ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x00000000),
                      shadowColor: const Color(0x00000000),
                      surfaceTintColor: const Color(0x00000000),
                    ),
                    onPressed: (){}, 
                    child: Image.asset('assets/Pot.png')
                    ),
                ],
              ),
              Image.asset('assets/etagewe.png'),
              //const Spacer(),
              const Menu(),
            ],
          )
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, int position, int pot) {
    return PopupMenuItem(
      value: [position,pot],
      child: Text(title),
    );
  }

  _onMenuItemSelected(List<int> value) {
    print(value[0]);
    print(value[1]);
    insertFleur(value[1], value[0]);
  }

  Future<List<int>> getFleur(numpot) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('num_utilisateur') ?? '';
    int idUserint = int.parse(idUser);

    final Future<Database> database = openDatabase(join(await getDatabasesPath(), 'my_database.db'),
        version: 1,
      );

    final Database db = await database;

    final List<Map<String, dynamic>> plants =  await db.rawQuery('SELECT type_fleur, pousse FROM Plantes WHERE num_utilisateur = ? AND num_pot = ?',
    [idUserint,numpot]);
    int type = 0;
    int pousse = 0;
    if (plants.isNotEmpty) {
      // Récupérer les données de l'utilisateur
      final plant = plants.first;
      type = plant['type_fleur'];
      pousse = plant['pousse'] as int;
    }

  var res = [0,0];
  res[0] = type;
  res[1] = pousse;

    print("Plantes fetched");
    print(res);
    return res;
  }

  Future<void> insertFleur(numPot,typeFleur) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('num_utilisateur') ?? '';

    final Future<Database> database = openDatabase(join(await getDatabasesPath(), 'my_database.db'),
          version: 1,
        );

        final Database db = await database;
//num_utilisateur INTEGER, num_pot INTEGER, type_fleur INTEGER, pousse INTEGER
      await db.rawQuery(
          'INSERT INTO Plantes (num_utilisateur, num_pot, type_fleur, pousse) VALUES(?,?,?,?)',
          [idUser, numPot, typeFleur, 0]);
      print("Plante insérée");

  }
}