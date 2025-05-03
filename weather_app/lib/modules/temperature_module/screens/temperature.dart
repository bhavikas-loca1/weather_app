import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/chatbot/chatbot_screen.dart';
import 'package:weather_app/modules/temperature_module/screens/temperature_dark_screen.dart';
import 'package:weather_app/modules/uv_index_module/uv_index_screen.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/models/weather_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TemperatureScreen extends StatefulWidget {
  const TemperatureScreen({super.key});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  WeatherServices? _weatherServices;
  Weather? _weather;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initWeatherServices();
  }

  Future<void> _initWeatherServices() async {
    final apiKey = await _loadApiKey();
    setState(() {
      _weatherServices = WeatherServices(apiKey);
    });
    _fetchWeather();
  }

  Future<String> _loadApiKey() async {
    final data = await rootBundle.loadString('assets/API_key/secret_key.json');
    final jsonResult = json.decode(data);
    return jsonResult['OPENWEATHER_API_KEY'];
  }

  Future<void> _fetchWeather([String? cityName]) async {
    if (_weatherServices == null) return;
    try {
      final weather = await _weatherServices!.getWeather(
        cityName ?? await _weatherServices!.getCurrentCity(),
      );
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String _getWeatherQuote(Weather? weather) {
    if (weather == null) return "";
    final condition = weather.mainCondition.toLowerCase();
    final temp = weather.temperature;

    if (condition.contains('rain')) {
      return "\"Pakodas are always the vibe on rainy days..\"";
    } else if (condition.contains('clear') && temp >= 30) {
      return "It's going to be very hot today, wear sunscreen and stay protected!";
    } else if (condition.contains('clear')) {
      return "A perfect day to go outside and enjoy the sunshine!";
    } else if (condition.contains('cloud')) {
      return "A little cloudy, but still a great day!";
    } else if (condition.contains('snow')) {
      return "Stay warm! It's snowing outside.";
    } else if (condition.contains('thunder')) {
      return "Thunderstorms ahead, stay indoors and stay safe!";
    } else if (temp <= 10) {
      return "It's chilly today, don't forget your jacket!";
    } else if (temp >= 35) {
      return "Extreme heat! Stay hydrated and avoid the sun.";
    } else {
      return "Have a wonderful day!";
    }
  }

  Widget _buildHourlyTemperatures() {
    if (_weather == null || _weather!.hourlyTemperatures.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _weather!.hourlyTemperatures.length > 12 ? 12 : _weather!.hourlyTemperatures.length,
        itemBuilder: (context, index) {
          final temp = _weather!.hourlyTemperatures[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xff5F5F5F), width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${temp.round()}°C',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5F5F5F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'H+${index}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff5F5F5F),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "assets/animations/sunny_animation.json";
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
        return 'assets/animations/cloud_animation.lottie';
      case 'rain':
      case 'shower rain':
      case 'drizzle':
      case 'thunderstorm':
        return 'assets/nimations/nimation - 1745867957986.lottie';
      case 'partially cloudy':
        return 'assets/animations/partially_cloudy_animations.json';
      case 'snowy':
        return 'assets/animations/snow_animation.lottie';
      case 'clear':
        return 'assets/animations/sunny_animation.json';
      default:
        return 'assets/animations/sunny_animation.json';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDBDCDE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffD2CFCF),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Color(0xff5F5F5F)),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (value) {
                                  if (value.trim().isNotEmpty) {
                                    _fetchWeather(value.trim());
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Toggle switch placeholder
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TemperatureDarkScreen()));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Color(0xff5F5F5F), width: 3),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffDBDCDE),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(100),
                                    bottomLeft: Radius.circular(100),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff5F5F5F),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                // Cloud image
                Lottie.asset(getWeatherAnimation(_weather?.mainCondition), width: 200, height: 200, fit: BoxFit.fill,repeat: true, options: LottieOptions(enableMergePaths: true)),
                const SizedBox(height: 30),
                // City Name and Temperature
                Text(
                  _weather?.cityName.toUpperCase() ?? "LOADING CITY..",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Color(0xff5F5F5F),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _weather != null ? '${_weather!.temperature.round()}°C' : "",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5F5F5F),
                  ),
                ),
                const SizedBox(height: 20),
                // Dynamic Quote
                Text(
                  _getWeatherQuote(_weather),
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Hourly Temperatures
                _buildHourlyTemperatures(),
                const SizedBox(height: 20),
                // UV Index Container (Clickable)
                if (_weather != null)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UvIndexPage(uvIndex: _weather!.uvIndex),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.orange, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.wb_sunny, color: Colors.orange, size: 24),
                          const SizedBox(width: 10),
                          Text(
                            "See UV Index & Advice",
                            style: TextStyle(
                              color: Colors.orange[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                // Moon icon at bottom right
                GestureDetector(
                  onTap:() {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => WeatherChatbotScreen() ,));
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: const Icon(Icons.nightlight_round, size: 24, color: Colors.blueGrey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}