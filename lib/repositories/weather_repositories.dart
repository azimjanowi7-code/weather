import 'package:dio/dio.dart';
import 'package:weather/core/api/api.dart';
import 'package:weather/model/weather_model.dart';

class WeatherRepositories {
  final Dio _dio = Dio();
  final String city;

  WeatherRepositories({required this.city});

  Future<WeatherModel> getWeather() async {
    final response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {'q': 'Osh', 'appid': Api.apiKey, 'units': 'metric'},
    );
    return WeatherModel.fromJson(response.data);
  }
}
