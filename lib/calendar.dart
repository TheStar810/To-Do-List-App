import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:table_calendar/table_calendar.dart';
import 'home.dart';
import 'plan.dart';
import 'profile.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = focusedDay;
    });
  }

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 218, 83),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Container(
              child: TableCalendar(
                  locale: "en_US",
                  rowHeight: 43,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2024, 01, 11),
                  lastDay: DateTime.utc(2030, 12, 31),
                  onDaySelected: _onDaySelected),
            ),
            SizedBox(height: 30),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Plan.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              '"The only way to do great work is to love what you do." - Steve Jobs',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Serif',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Color.fromARGB(255, 174, 102, 1),
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: _currentIndex == 1
                  ? Icon(Icons.calendar_month,
                      color: Color.fromARGB(255, 174, 102, 1))
                  : Icon(Icons.calendar_month),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                );
              },
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.task),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanPage()),
                );
              },
            ),
            label: 'My Plans',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
