import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());
  final WeatherRepository _weatherRepository;

  fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final weather = await _weatherRepository.getWeather(city);
      emit(state.copyWith(
        weather: weather,
        status: WeatherStatus.success,
      ));
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }
}
