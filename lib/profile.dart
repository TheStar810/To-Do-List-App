import 'package:flutter/material.dart';
import 'home.dart';
import 'calendar.dart';
import 'plan.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 247, 234),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu Button');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              semanticLabel: 'notification',
            ),
            onPressed: () {
              // print('Notification');
            },
          ),
        ],
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Serif",
            fontWeight: FontWeight.bold,
            height: 2.0,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 218, 83),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Positioned(
              left: 0,
              top: 0,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/William Susilo.jpg'),
              ),
            ),
            SizedBox(width: 24),
            Container(
              margin: EdgeInsets.only(
                  bottom: 8.0), // Atur margin bagian bawah sesuai kebutuhan
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    'William Susilo',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Serif",
                      fontWeight: FontWeight.bold,
                      height: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '@william.susilo',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Serif",
                      fontWeight: FontWeight.bold,
                      height: 2.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 64),
                  Row(
                    children: [
                      SizedBox(width: 32),
                      Text(
                        'Username',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Serif",
                            fontWeight: FontWeight.bold,
                            height: 2.0),
                      ),
                      SizedBox(width: 145),
                      Text(
                        'leonstar810',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Serif",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            height: 2.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 350.0, // Sesuaikan dengan lebar yang diinginkan
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black, // Warna garis bagian bawah
                            width: 2.0, // Lebar garis bagian bawah
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      SizedBox(width: 32),
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Serif",
                            fontWeight: FontWeight.bold,
                            height: 2.0),
                      ),
                      SizedBox(width: 25),
                      Text(
                        'williamsusilo810@gmail.com',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Serif",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            height: 2.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 350.0, // Sesuaikan dengan lebar yang diinginkan
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black, // Warna garis bagian bawah
                            width: 2.0, // Lebar garis bagian bawah
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(width: 32),
                      Text(
                        'Notifications',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Serif",
                            fontWeight: FontWeight.bold,
                            height: 2.0),
                      ),
                      SizedBox(width: 160),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isSwitched = !isSwitched;
                          });
                        },
                        icon: Icon(
                          isSwitched ? Icons.toggle_on : Icons.toggle_off,
                          color: isSwitched
                              ? Color.fromARGB(255, 0, 213, 14)
                              : const Color.fromARGB(255, 0, 0, 0),
                        ),
                        iconSize: 60,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 350.0, // Sesuaikan dengan lebar yang diinginkan
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black, // Warna garis bagian bawah
                            width: 2.0, // Lebar garis bagian bawah
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
        unselectedItemColor: Colors.black, // Warna ikon ketika tidak terpilih
        selectedItemColor:
            Color.fromARGB(255, 174, 102, 1), // Warna ikon ketika terpilih
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
              icon: Icon(Icons.calendar_month),
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
              icon: _currentIndex == 3
                  ? Icon(Icons.person, color: Color.fromARGB(255, 174, 102, 1))
                  : Icon(Icons.person),
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
