import 'dart:convert';

import 'package:meta_weather_api/src/models/location.dart';

import 'models/models.dart';
import 'package:http/http.dart' as http;

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when locationSearch fails.
class LocationIdRequestFailure implements Exception {}

class MetaWeatherApi {
  MetaWeatherApi({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'www.metaweather.com';
  final http.Client _httpClient;

  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(_baseUrl, '/api/location/search', {
      'query': query,
    });
    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationIdRequestFailure();
    }

    final locationJson = jsonDecode(
      locationResponse.body,
    ) as List;
    return locationJson?.isNotEmpty == true
        ? Location.fromJson(locationJson.first as Map<String, dynamic>)
        : null;
  }

  Future<Weather> getWeather(int locationId) async {
    final weatherRequest = Uri.https(_baseUrl, '/api/location/$locationId');
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final weatherJson = jsonDecode(
      weatherResponse.body,
    )['consolidated_weather'] as List;
    return weatherJson?.isNotEmpty == true
        ? Weather.fromJson(weatherJson.first as Map<String, dynamic>)
        : null;
  }
}
