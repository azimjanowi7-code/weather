class WeatherModel {
  final double temp;
  final String icon;
  final String descripion;

  WeatherModel({
    required this.temp,
    required this.icon,
    required this.descripion,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['main']['temp'],
      icon: json['weather'][0]['icon'],
      descripion: json['weather'][0]['description'],
    );
  }
}
