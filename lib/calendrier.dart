import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'menuv2.dart';

class CalendrierPage extends StatefulWidget {
  @override
  _CalendrierPageState createState() => _CalendrierPageState();
}

class _CalendrierPageState extends State<CalendrierPage> {
  late final ValueNotifier<List<dynamic>>
      _selectedEvents; // Changed Event to dynamic
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier([]); // Initialize with an empty list
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    // Replace this with your own logic to get events for the given day
    // For example, querying your event data source
    return []; // Return an empty list or a list of events for the given day
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendrier',
          style: TextStyle(color: Colors.white),
        ),
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
            Container(
              color: const Color(0x00000000),
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
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            _selectedEvents.value = _getEventsForDay(selectedDay);
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
                      // Pass other properties according to your requirements
                    ),
                    // Continue with the rest of your UI
                  ],
                ),
              ),
            ),
            const Spacer(),
            const Menu(),
          ],
        ),
        ],
      ),
    );
  }
}
