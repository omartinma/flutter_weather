part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
  });

  final WeatherStatus status;
  final Weather weather;

  WeatherState copyWith({
    WeatherStatus status,
    Weather weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object> get props => [
        status,
        weather,
      ];
}
