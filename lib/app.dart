import 'package:flutter/material.dart';
import 'package:flutter_weather/weather/view/weather_page.dart';

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: WeatherPage(),
    );
  }
}
