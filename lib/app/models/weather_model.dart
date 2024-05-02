class Weather {
  final String cityName;
  final String temperature;
  final String humidity;
  final String windSpeed;
  final String condition;
  Weather(
      {required this.cityName,
      required this.condition,
      required this.humidity,
      required this.temperature,
      required this.windSpeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'].toString(),
      temperature: json['main']['temp'].toString(),
      humidity: json['main']['humidity'].toString(),
      windSpeed: json['wind']['speed'].toString(),
      condition: json['weather'][0]['main'].toString(),
    );
  }
}
