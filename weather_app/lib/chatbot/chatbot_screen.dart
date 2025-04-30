import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class WeatherChatbotScreen extends StatefulWidget {
  const WeatherChatbotScreen({super.key});

  @override
  State<WeatherChatbotScreen> createState() => _WeatherChatbotScreenState();
}

class _WeatherChatbotScreenState extends State<WeatherChatbotScreen> {
  WeatherServices? _weatherServices;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _loading = false;

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
  }

  Future<String> _loadApiKey() async {
    final data = await rootBundle.loadString('assets/API_key/secret_key.json');
    final jsonResult = json.decode(data);
    return jsonResult['OPENWEATHER_API_KEY'];
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _loading || _weatherServices == null) return;
    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _loading = true;
    });

    try {
      final geoResult = await _weatherServices!.getCoordinatesAndCity(text.trim());
      final lat = geoResult['lat'];
      final lon = geoResult['lon'];
      final actualCityName = geoResult['city_name'];

      Weather weather = await _weatherServices!.getWeatherByCoords(lat, lon, actualCityName);

      String reply =
          "Weather in ${weather.cityName}:\n"
          "Temperature: ${weather.temperature.round()}°C\n"
          "Condition: ${weather.mainCondition}\n"
          "UV Index: ${weather.uvIndex}\n"
          "Next hour: ${weather.hourlyTemperatures.length > 1 ? '${weather.hourlyTemperatures[1].round()}°C' : 'N/A'}";
      setState(() {
        _messages.add(_ChatMessage(text: reply, isUser: false));
      });
    } catch (e) {
      setState(() {
        _messages.add(_ChatMessage(text: "Sorry, I couldn't find weather for that location.", isUser: false));
      });
      print("Error: $e");
    }
    setState(() {
      _loading = false;
    });
    // Scroll to bottom after message is added
    await Future.delayed(Duration(milliseconds: 100));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    _controller.clear(); // Clear only after sending
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildMessage(_ChatMessage msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: msg.isUser ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(msg.text, style: const TextStyle(color: Color(0xff5F5F5F))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather Chatbot".toUpperCase())),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildMessage(_messages[index]),
            ),
          ),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Ask about any city's weather...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) async {
                      await _sendMessage(value);
                    },
                    enabled: !_loading,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _loading
                      ? null
                      : () async {
                          await _sendMessage(_controller.text);
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage({required this.text, required this.isUser});
}