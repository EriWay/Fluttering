import 'package:flutter/material.dart';
import 'menuv2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

var pot1 = [0,9];
var pot2 = [0,9];
var pot3 = [0,9];
var pot4 = [0,9];
var pot5 = [0,9];
var pot6 = [0,9];
var pot7 = [0,9];
var pot8 = [0,9];
var pot9 = [0,9];

var nbFleurs = [0,0,0];

class Jardin extends StatelessWidget{
  Jardin({super.key});

  final _popupMenu1 = GlobalKey<PopupMenuButtonState>();
  final _popupMenu2 = GlobalKey<PopupMenuButtonState>();
  final _popupMenu3 = GlobalKey<PopupMenuButtonState>();
  final _popupMenu4 = GlobalKey<PopupMenuButtonState>();
  final _popupMenu5 = GlobalKey<PopupMenuButtonState>();
  final _popupMenu6 = GlobalKey<PopupMenuButtonState>();
  final _popupMenu7 = GlobalKey<PopupMenuButtonState>();
  final _popupMenu8 = GlobalKey<PopupMenuButtonState>();
  final _popupMenu9 = GlobalKey<PopupMenuButtonState>();
  
  Future<String> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('prenom') ?? ''; // Retourner une chaîne vide si le prénom n'est pas trouvé
  }


  @override
  Widget build(BuildContext context) {

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/fleurb.png",height: 25,),
                      Text("${nbFleurs[0]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/fleurr.png",height: 25,),
                      Text("${nbFleurs[1]}"),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset("assets/fleurv.png",height: 25,),
                      Text("${nbFleurs[2]}"),
                    ],
                  ),
                ],
              ),
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

                        onPressed: () {}, 
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
                          child: Image.asset('assets/Fleur${pot3[0]}${pot3[1]}.png')
                        ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton(
                        key: _popupMenu1,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 1),
                          _buildPopupMenuItem("Fleur Rouge", 1, 1),
                          _buildPopupMenuItem("Fleur Violette", 2, 1),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot1[1] == 9){
                              pot1 = await getFleur(1);
                              _popupMenu1.currentState?.showButtonMenu();
                            }else if(pot1[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence !"),
                                content: const Text("ça pousse"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot1 = [0,9];
                              deleteOneFleur(1);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),
                      
                        PopupMenuButton(
                        key: _popupMenu2,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 2),
                          _buildPopupMenuItem("Fleur Rouge", 1, 2),
                          _buildPopupMenuItem("Fleur Violette", 2, 2),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot2[1] == 9){
                              pot2 = await getFleur(2);
                              _popupMenu2.currentState?.showButtonMenu();
                            }else if(pot2[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence !"),
                                content: const Text("ça pousse"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot2 = [0,9];
                              deleteOneFleur(2);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),

                        PopupMenuButton(
                        key: _popupMenu3,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 3),
                          _buildPopupMenuItem("Fleur Rouge", 1, 3),
                          _buildPopupMenuItem("Fleur Violette", 2, 3),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot3[1] == 9){
                              pot3 = await getFleur(3);
                              _popupMenu3.currentState?.showButtonMenu();
                            }else if(pot3[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence !"),
                                content: const Text("ça pousse"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot3 = [0,9];
                              deleteOneFleur(3);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),
                    ],
                  ),
                ]
              ),
              
              
              Image.asset('assets/etagewe.png'),
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
                            child: Image.asset('assets/Fleur${pot4[0]}${pot4[1]}.png')
                            ),

                            ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x00000000),
                              shadowColor: const Color(0x00000000),
                              surfaceTintColor: const Color(0x00000000),
                              foregroundColor: const Color(0x00000000),
                            ),
                            onPressed: () {
                            }, 
                            child: Image.asset('assets/Fleur${pot5[0]}${pot5[1]}.png')
                            ),

                            ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x00000000),
                              shadowColor: const Color(0x00000000),
                              surfaceTintColor: const Color(0x00000000),
                              foregroundColor: const Color(0x00000000),
                            ),
                            onPressed: () {
                            }, 
                            child: Image.asset('assets/Fleur${pot6[0]}${pot6[1]}.png')
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton(
                        key: _popupMenu4,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 4),
                          _buildPopupMenuItem("Fleur Rouge", 1, 4),
                          _buildPopupMenuItem("Fleur Violette", 2, 4),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot4[1] == 9){
                              pot4 = await getFleur(4);
                              _popupMenu2.currentState?.showButtonMenu();
                            }else if(pot4[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence !"),
                                content: const Text("ça pousse"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot4 = [0,9];
                              deleteOneFleur(4);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),

                      PopupMenuButton(
                        key: _popupMenu5,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 5),
                          _buildPopupMenuItem("Fleur Rouge", 1, 5),
                          _buildPopupMenuItem("Fleur Violette", 2, 5),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot5[1] == 9){
                              pot5 = await getFleur(5);
                              _popupMenu5.currentState?.showButtonMenu();
                            }else if(pot5[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence !"),
                                content: const Text("ça pousse"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot5 = [0,9];
                              deleteOneFleur(5);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),

                      PopupMenuButton(
                        key: _popupMenu6,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 6),
                          _buildPopupMenuItem("Fleur Rouge", 1, 6),
                          _buildPopupMenuItem("Fleur Violette", 2, 6),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot6[1] == 9){
                              pot6 = await getFleur(6);
                              _popupMenu6.currentState?.showButtonMenu();
                            }else if(pot6[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence !"),
                                content: const Text("ça pousse"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot6 = [0,9];
                              deleteOneFleur(6);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              
              Image.asset('assets/etagewe.png'),
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
                            child: Image.asset('assets/Fleur${pot7[0]}${pot7[1]}.png')
                            ),

                            ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x00000000),
                              shadowColor: const Color(0x00000000),
                              surfaceTintColor: const Color(0x00000000),
                              foregroundColor: const Color(0x00000000),
                            ),
                            onPressed: () {
                            }, 
                            child: Image.asset('assets/Fleur${pot8[0]}${pot8[1]}.png')
                            ),

                            ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x00000000),
                              shadowColor: const Color(0x00000000),
                              surfaceTintColor: const Color(0x00000000),
                              foregroundColor: const Color(0x00000000),
                            ),
                            onPressed: () {
                            }, 
                            child: Image.asset('assets/Fleur${pot9[0]}${pot9[1]}.png')
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton(
                        key: _popupMenu7,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 7),
                          _buildPopupMenuItem("Fleur Rouge", 1, 7),
                          _buildPopupMenuItem("Fleur Violette", 2, 7),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot7[1] == 9){
                              pot7 = await getFleur(7);
                              _popupMenu7.currentState?.showButtonMenu();
                            }else if(pot7[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence !"),
                                content: const Text("ça pousse"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot7 = [0,9];
                              deleteOneFleur(7);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),

                      PopupMenuButton(
                        key: _popupMenu8,
                        tooltip: "",
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 8),
                          _buildPopupMenuItem("Fleur Rouge", 1, 8),
                          _buildPopupMenuItem("Fleur Violette", 2, 8),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot8[1] == 9){
                              pot8 = await getFleur(8);
                              _popupMenu8.currentState?.showButtonMenu();
                            }else if(pot8[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence !"),
                                content: const Text("ça pousse"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot8 = [0,9];
                              deleteOneFleur(8);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]){
                          _onMenuItemSelected(value as List<int>);
                        },
                      ),

                      PopupMenuButton(
                        key: _popupMenu9,
                        tooltip: "",
                        position: PopupMenuPosition.under,
                        color: Colors.transparent,
                        surfaceTintColor: Colors.brown,
                        iconColor: Colors.transparent,
                        shadowColor: Colors.brown,
                        itemBuilder: (context)=>[
                          _buildPopupMenuItem("Fleur Blanche", 0, 9),
                          _buildPopupMenuItem("Fleur Rouge", 1, 9),
                          _buildPopupMenuItem("Fleur Violette", 2, 9),
                        ],
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x00000000),
                            shadowColor: const Color(0x00000000),
                            surfaceTintColor: const Color(0x00000000),
                          ),
                          onPressed: () async {
                            if(pot9[1] == 9){
                              pot9 = await getFleur(9);
                              _popupMenu9.currentState?.showButtonMenu();
                            }else if(pot9[1] != 1){
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Silence..."),
                                content: const Text("ça pousse !"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                            }else{
                              pot9 = [0,9];
                              deleteOneFleur(9);
                              showDialog(context: context,barrierDismissible: true, builder: (context)=> AlertDialog(
                                title: const Text("Fleur ramassée"),
                                actions: <Widget>[TextButton(onPressed: ()=> Navigator.pop(context,'Cancel'), child: const Text("OK"))],
                              ));
                              
                              Navigator.pushReplacementNamed(context, '/jardin');
                            }
                          },
                          child: Image.asset('assets/Pot.png'),
                        ),
                        onSelected: ([value,pot]) async {
                          _onMenuItemSelected(value as List<int>);
                          pot9 = await getFleur(9);
                          Navigator.pushReplacementNamed(context, '/jardin');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              Image.asset('assets/etagewe.png'),
              const Spacer(flex: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () async {incrementFleurs();
                  pot9 = await getFleur(9);
                  Navigator.pushReplacementNamed(context, '/jardin');
                  }, child: const Text("Pousse !")),
                  ElevatedButton(onPressed: (){printFleurs();}, child: const Text("BDD !")),
                  ElevatedButton(onPressed: () async {
                    pot1 = await getFleur(1);
                    pot2 = await getFleur(2);
                    pot3 = await getFleur(3);
                    pot4 = await getFleur(4);
                    pot5 = await getFleur(5);
                    pot6 = await getFleur(6);
                    pot7 = await getFleur(7);
                    pot8 = await getFleur(8);
                    pot9 = await getFleur(9);
                    nbFleurs = await getTotaux();
                    Navigator.pushReplacementNamed(context, '/jardin');
                  }, child: const Text("Update")),
                ],
              ),
              ElevatedButton(onPressed: (){deleteFleurs();}, child: const Text("Suppr !")),
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
      child: Text(title,selectionColor: Colors.white,style: const TextStyle(color: Colors.white),),
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
    int pousse = 9;
    if (plants.isNotEmpty) {
      // Récupérer les données de l'utilisateur
      final plant = plants.first;
      type = plant['type_fleur'];
      pousse = plant['pousse'] as int;
    }

  var res = [0,0];
  res[0] = type;
  res[1] = pousse>1&&pousse<9?1:pousse;

    print("Plantes fetched");
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

  Future<void> incrementFleurs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('num_utilisateur') ?? '';
    int idUserint = int.parse(idUser);
    final Future<Database> database = openDatabase(join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );

    final Database db = await database;
//num_utilisateur INTEGER, num_pot INTEGER, type_fleur INTEGER, pousse INTEGER
      await db.rawQuery('UPDATE Plantes SET pousse = pousse+1 WHERE num_utilisateur = ?',[idUserint]);
    print("Fleur poussées");
  }

  Future<void> printFleurs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('num_utilisateur') ?? '';
    int idUserint = int.parse(idUser);
    final Future<Database> database = openDatabase(join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );

    final Database db = await database;
//num_utilisateur INTEGER, num_pot INTEGER, type_fleur INTEGER, pousse INTEGER
      var res = await db.rawQuery('SELECT * FROM Plantes WHERE num_utilisateur = ?',[idUserint]);
      print("Printing BDD");
      if(res.isNotEmpty){  
        for (var fleur in res) {
          print(fleur['type_fleur']);
          print(fleur['pousse']);
          print("/");
        }
      }
  }

  Future<void> deleteFleurs() async {
    final Future<Database> database = openDatabase(join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );

    final Database db = await database;
//num_utilisateur INTEGER, num_pot INTEGER, type_fleur INTEGER, pousse INTEGER
    await db.rawQuery('DELETE FROM Plantes');
    await db.rawQuery('DELETE FROM TotalPlantes');
    print("Plantes supprimées");
  }

  Future<void> deleteOneFleur(numpot) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('num_utilisateur') ?? '';
    int idUserInt = int.parse(idUser);
    final Future<Database> database = openDatabase(join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );
    final Database db = await database;
//num_utilisateur INTEGER, num_pot INTEGER, type_fleur INTEGER, pousse INTEGER
    var tmp = await db.rawQuery('SELECT * FROM Plantes WHERE num_utilisateur = ? and num_pot = ?',[idUserInt,numpot]);
  if(tmp.isNotEmpty){
    var res = tmp.first;
    var insert = [0,0,0,idUserInt];
    var tmp2 = res['type_fleur'];
    switch (tmp2) {
      case 0:
        insert[0]=1;
        break;
      case 1:
        insert[1]=1;
        break;
      case 2:
        insert[2]=1;
        break;
    }
  //num_utilisateur INTEGER, fleur0 INTEGER, fleur1 INTEGER, fleur2 INTEGER
    await db.rawQuery('INSERT INTO TotalPlantes  (fleur0, fleur1, fleur2, num_utilisateur) VALUES(?,?,?,?)',insert);
  }

  await db.rawQuery('DELETE FROM Plantes WHERE num_pot = ? AND num_utilisateur = ?',[numpot,idUserInt]);
  }

  Future<List<int>> getTotaux() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('num_utilisateur') ?? '';
    int idUserInt = int.parse(idUser);
    final Future<Database> database = openDatabase(join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );
    final Database db = await database;
    var res = await db.rawQuery('SELECT * FROM TotalPlantes WHERE num_utilisateur = ?',[idUserInt]);
var ret = [0,0,0];
    if (res.isNotEmpty){
      for (var fleur in res) {
        if(fleur['fleur0']!=0){
          ret[0]++;
        }
        if(fleur['fleur1']!=0){
          ret[1]++;
        }
        if(fleur['fleur2']!=0){
          ret[2]++;
        }
        }
      }

    return ret;
  }
}