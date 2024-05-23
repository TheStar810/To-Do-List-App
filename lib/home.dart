import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'calendar.dart';
import 'plan.dart';
import 'profile.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  double? latitude;
  double? longitude;

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    print('Latitude: $latitude');
    print('');
    print('Longitude: $longitude');
  }

  int _currentIndex = 0;

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == 'null') {
      return 'assets/images/Sunny.json'; // default to sunny
    }

    switch (mainCondition?.toLowerCase()) {
      case 'Clouds':
      case 'Mist':
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Fog':
        return 'assets/images/Cloud.json';
      case 'Rain':
      case 'Drizzle':
      case 'Shower Rain':
        return 'assets/images/Rainy.json';
      case 'ThunderStorm':
        return 'assets/images/Thunder.json';
      case 'Clear':
        return 'assets/images/Sunny.json';
      default:
        return 'assets/images/Sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    Provider.of<WeatherProvider>(context, listen: false).fetchWeather();
  }

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
              semanticLabel: 'notif',
            ),
            onPressed: () {
              print('Notification');
            },
          ),
        ],
        title: const Text(
          'Home',
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
            SizedBox(height: 24),
            Row(
              children: [
                SizedBox(width: 20),
                Positioned(
                  left: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        AssetImage('assets/images/William Susilo.jpg'),
                  ),
                ),
                SizedBox(width: 24),
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    children: [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Serif",
                          fontWeight: FontWeight.bold,
                          height: 2.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
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
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 242, 192, 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Provider.of<WeatherProvider>(context, listen: false)
                    .fetchWeather();
                getLocation();
              },
              child: const Text(
                "Get My Location",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "Serif",
                  fontWeight: FontWeight.bold,
                  height: 2.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (latitude != null && longitude != null)
              Row(
                children: [
                  const SizedBox(width: 80),
                  _buildTextContainer('Latitude:\n$latitude'),
                  const SizedBox(width: 30),
                  _buildTextContainer('Longitude:\n$longitude'),
                ],
              ),
            const SizedBox(height: 30),
            // city name
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                return Text(
                  weatherProvider.weather?.cityName ?? "Loading City..",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Serif",
                    fontWeight: FontWeight.bold,
                    height: 2.0,
                  ),
                );
              },
            ),
            // animation
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                return Lottie.asset(
                  getWeatherAnimation(weatherProvider.weather?.mainCondition),
                );
              },
            ),
            // temperature
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                return Text(
                  '${weatherProvider.weather?.temperature.round()} °C',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Serif",
                    fontWeight: FontWeight.bold,
                    height: 2.0,
                  ),
                );
              },
            ),
            // weather condition
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, child) {
                return Text(
                  weatherProvider.weather?.mainCondition ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Serif",
                    fontWeight: FontWeight.bold,
                    height: 2.0,
                  ),
                );
              },
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
              icon: _currentIndex == 0
                  ? Icon(Icons.home, color: Color.fromARGB(255, 174, 102, 1))
                  : Icon(Icons.home),
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

Widget _buildTextContainer(String text) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 240, 233, 190),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontFamily: "Serif",
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
