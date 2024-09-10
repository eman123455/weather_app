import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  final Dio dio;
  final String baseUrl = 'https://api.weatherapi.com/v1';
  final String apiKey = '8df4d6cb080e4e6f9b2190337240509';
  WeatherService({required this.dio});
  Future<WeatherModel> getWeather(final String cityName) async {
    try {
      Response response =
          await dio.get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      final String errorMessage = e.response?.data["error"]["message"] ??
          'ops! there is no error , Try later!';

      throw Exception(errorMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('ops! there is no error , Try later!');
    }
  }
}
