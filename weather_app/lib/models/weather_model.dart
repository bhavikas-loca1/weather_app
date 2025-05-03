class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final List<double> hourlyTemperatures;
  final double uvIndex;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.hourlyTemperatures,
    required this.uvIndex,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['city_name'] ??  'Unknown',
      temperature: (json['current']['temp'] as num).toDouble(),
      mainCondition: json['current']['weather'][0]['main'],
      hourlyTemperatures: (json['hourly'] as List)
          .map<double>((h) => (h['temp'] as num).toDouble())
          .toList(),
      uvIndex: (json['current']['uvi'] as num).toDouble(),
    );
  }
}