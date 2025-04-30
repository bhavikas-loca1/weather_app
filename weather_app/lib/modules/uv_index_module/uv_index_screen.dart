import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class UvIndexPage extends StatelessWidget {
  final double uvIndex;
  const UvIndexPage({super.key, required this.uvIndex});

  String getUvAdvice(double uv) {
    if (uv < 2) return "Low: Safe to be outside.";
    if (uv < 6) return "Moderate: Wear sunglasses and sunscreen.";
    if (uv < 8) return "High: Reduce time in the sun between 10 a.m. and 4 p.m.";
    if (uv < 11) return "Very High: Protection against sun damage is needed.";
    return "Extreme: Avoid being outside during midday hours.";
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return "";
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

  // Example: How to load the API key if needed in this widget
  Future<String> loadApiKey() async {
    final data = await rootBundle.loadString('assets/API_key/secret_key.json');
    final jsonResult = json.decode(data);
    return jsonResult['OPENWEATHER_API_KEY'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UV Index Details".toUpperCase())),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              "Current UV Index: $uvIndex".toUpperCase(),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // Simple Bar Graph
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: (uvIndex / 11).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: uvIndex < 2
                            ? Colors.green
                            : uvIndex < 6
                                ? Colors.yellow
                                : uvIndex < 8
                                    ? Colors.orange
                                    : uvIndex < 11
                                        ? Colors.red
                                        : Colors.purple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "UV ${uvIndex.toStringAsFixed(1)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              getUvAdvice(uvIndex),
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}