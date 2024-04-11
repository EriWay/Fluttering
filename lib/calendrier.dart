import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';
import 'majournee.dart';
import 'majourneehumeur.dart';
import 'menuv2.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importez les SharedPreferences

class CalendrierPage extends StatefulWidget {
  @override
  _CalendrierPageState createState() => _CalendrierPageState();
}

class _CalendrierPageState extends State<CalendrierPage> {
  late final ValueNotifier<List<dynamic>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _selectedUserId = ''; // Modifié en String pour gérer l'identifiant de l'utilisateur

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier([]);
    initializeDateFormatting();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> _getEventsForDayAndUser(DateTime date, String userId) async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'my_database.db');
      Database database = await openDatabase(path);

      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      List<Map<String, dynamic>> result = await database.rawQuery(
          'SELECT * FROM Notes WHERE date = ? AND num_utilisateur = ?', [formattedDate, userId]);

      await database.close();

      return result;
    } catch (e) {
      print('Error fetching events for date $date and user $userId: $e');
      return [];
    }
  }



  Future<String?> _getSelectedUserIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convertir le résultat en String
    return prefs.getString('num_utilisateur') ?? ''; // Renvoyer une chaîne vide si la clé n'est pas trouvée
  }


  Future<void> _storeDateInSharedPreferences(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedDate', DateFormat('yyyy-MM-dd').format(date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendrier',
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar<dynamic>(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    locale: 'fr_FR',
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _getSelectedUserIdFromSharedPreferences().then((userId) {
                            if (userId != null) {
                              _selectedUserId = userId;
                              _getEventsForDayAndUser(selectedDay, userId).then((events) {
                                setState(() {
                                  _selectedEvents.value = events;
                                  if (events.isEmpty) {
                                    print('No events for selected day');
                                  }
                                });
                              });
                            }
                          });
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: _getEventsForDayAndUser(_selectedDay ?? DateTime.now(), _selectedUserId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Extracting the text of the first note if available
                        String firstFiveWords = '';
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          String noteText = snapshot.data![0]['texte'];
                          List<String> words = noteText.split(' ');
                          firstFiveWords = words.take(5).join(' ');
                          firstFiveWords = firstFiveWords + '...';
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    firstFiveWords.isNotEmpty ? firstFiveWords : 'Aucune note',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _storeDateInSharedPreferences(_selectedDay ?? DateTime.now());
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PageHumeur()));
                                    },
                                    child: Text('Editer'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 120,),
                  const Menu(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page d\'édition'),
      ),
      body: const Center(
        child: Text('Page d\'édition'),
      ),
    );
  }
}
