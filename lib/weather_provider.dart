import 'package:flutter/material.dart';
import 'model/weather_model.dart';
import 'services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService =
      WeatherService('b9949e64d125837371ccf52d328117c3');
  Weather? _weather;

  Weather? get weather => _weather;

  Future<void> fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      _weather = weather;
      notifyListeners();
    }

    // any errors
    catch (e) {
      print(e);
    }
  }
}
