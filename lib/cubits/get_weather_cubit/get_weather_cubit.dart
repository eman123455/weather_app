import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(NoWeatherState());
  WeatherModel? weatherModel;
  getWeather({required String cityname}) async {
    try {
     weatherModel =
          await WeatherService(dio: Dio()).getWeather(cityname);

      emit(WeatherLoadedState(
          weatherModel: weatherModel!)); // send object Weather loaded states
    } catch (e) {
      emit(WeatherFailureState());
    }
  }
}
