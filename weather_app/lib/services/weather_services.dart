
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {
  static const ONE_CALL_URL = "https://api.openweathermap.org/data/3.0/onecall";
  static const GEOCODE_URL = "https://api.openweathermap.org/geo/1.0/direct";
  final String apiKey;

  WeatherServices(this.apiKey);

  // Get coordinates and city name for a city using Geocoding API
  Future<Map<String, dynamic>> getCoordinatesAndCity(String cityName) async {
    final response = await http.get(Uri.parse('$GEOCODE_URL?q=$cityName&limit=1&appid=$apiKey'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return {
          'lat': (data[0]['lat'] as num).toDouble(),
          'lon': (data[0]['lon'] as num).toDouble(),
          'city_name': data[0]['name'] ?? cityName,
        };
      } else {
    throw Exception('City not found. Please check the spelling.');
  }
    }
    else {
  throw Exception('Failed to get coordinates for city');
}
  }


  // Get weather using One Call 3.0 API with coordinates and city name
  Future<Weather> getWeatherByCoords(double lat, double lon, String cityName) async {
    final url =
        '$ONE_CALL_URL?lat=$lat&lon=$lon&exclude=minutely,daily,alerts&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      json['city_name'] = cityName;
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // For other screens
  Future<Weather> getWeather(String cityName) async {
    final geo = await getCoordinatesAndCity(cityName);
    return getWeatherByCoords(geo['lat'], geo['lon'], geo['city_name']);
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}