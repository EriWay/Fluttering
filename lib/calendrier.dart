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
import 'package:shared_preferences/shared_preferences.dart'; // 1. Importez les SharedPreferences

class CalendrierPage extends StatefulWidget {
  @override
  _CalendrierPageState createState() => _CalendrierPageState();
}

class _CalendrierPageState extends State<CalendrierPage> {
  late final ValueNotifier<List<dynamic>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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

  Future<List<Map<String, dynamic>>> _getEventsForDay(DateTime date) async {
    try {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'my_database.db');
      Database database = await openDatabase(path);

      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      List<Map<String, dynamic>> result = await database.rawQuery(
          'SELECT * FROM Notes WHERE date = ?', [formattedDate]);

      await database.close();

      return result;
    } catch (e) {
      print('Error fetching events for date $date: $e');
      return [];
    }
  }

  // 2. Ajoutez une fonction pour stocker la date dans les SharedPreferences
  Future<void> _storeDateInSharedPreferences(DateTime date) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDate', DateFormat('yyyy-MM-dd').format(date));
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
                          _getEventsForDay(selectedDay).then((events) {
                            setState(() {
                              _selectedEvents.value = events;
                              if (events.isEmpty) {
                                print('No events for selected day');
                              }
                            });
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
                    future: _getEventsForDay(_selectedDay ?? DateTime.now()),
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
                                      // 2. Stockez la date dans les SharedPreferences
                                      await _storeDateInSharedPreferences(_selectedDay ?? DateTime.now());
                                      // 3. Naviguez vers une autre page en .dart
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

// 3. Créez une autre page en .dart pour l'édition
class EditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'édition'),
      ),
      body: Center(
        child: Text('Page d\'édition'),
      ),
    );
  }
}
