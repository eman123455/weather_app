import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
          //to solve the problem as we can't use Bloc in same time we define
          builder: (context) => BlocBuilder<GetWeatherCubit,WeatherState>(
                builder: (context, state) {
                  return MaterialApp(
                    theme: ThemeData(
                      primaryColor:  getThemeColor(
                          BlocProvider.of<GetWeatherCubit>(context)
                              .weatherModel
                              ?.condition),
                    appBarTheme:AppBarTheme(
                    backgroundColor:   getThemeColor(
                          BlocProvider.of<GetWeatherCubit>(context)
                              .weatherModel
                              ?.condition),
                  )
                              
                              ),
                       
                    
                    debugShowCheckedModeBanner: false,
                    home: const Home(),
                  );
                },
              )
              ),
    );
  }

  
}



MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  switch (condition) {
    case 'Sunny':
    case 'Clear':
      return Colors.orange; // Bright and sunny
    case 'Partly cloudy':
      return Colors.yellow; // Slightly overcast
    case 'Cloudy':
      return Colors.blueGrey; // Overcast
    case 'Overcast':
      return Colors.grey; // Dark clouds
    case 'Mist':
      return Colors.blue; // Misty conditions
    case 'Patchy rain possible':
    case 'Light rain':
    case 'Moderate rain':
    case 'Heavy rain':
      return Colors.grey; // Rainy weather
    case 'Patchy snow possible':
    case 'Light snow':
    case 'Moderate snow':
    case 'Heavy snow':
      return Colors.blue; // Snowy weather
    case 'Fog':
    case 'Freezing fog':
      return Colors.blueGrey; // Foggy conditions
    case 'Blizzard':
      return Colors.grey; // MaterialColor for severe winter conditions
    case 'Thundery outbreaks possible':
      return Colors.deepPurple; // Thunderstorms
    case 'Ice pellets':
    case 'Freezing rain':
      return Colors.teal; // Icy conditions
    case 'Light sleet':
    case 'Moderate sleet':
      return Colors.grey; // Sleet
    case 'Patchy light drizzle':
    case 'Light drizzle':
      return Colors.lightBlue; // Use a MaterialColor
    default:
      return Colors.blue; // Default color for unknown conditions
  }
}
