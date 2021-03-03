import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/search/view/search_page.dart';
import 'package:flutter_weather/weather/cubit/weather_cubit.dart';
import 'package:flutter_weather/weather/widgets/weather_empty.dart';
import 'package:flutter_weather/weather/widgets/weather_loading.dart';
import 'package:flutter_weather/weather/widgets/weather_success.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(
        context.read<WeatherRepository>(),
      ),
      child: WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Weather"),
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return WeatherEmpty();
                break;
              case WeatherStatus.loading:
                return WeatherLoading();
              case WeatherStatus.success:
                return WeatherSuccess(
                  weather: state.weather,
                );
              default:
                return WeatherEmpty();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if (city != null) {
            context.read<WeatherCubit>().fetchWeather(city);
          }
        },
      ),
    );
  }
}
