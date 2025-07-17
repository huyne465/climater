import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:climater/features/data/models/weather_model.dart';
import 'package:climater/features/domain/entities/location_entity.dart';
import 'package:climater/features/data/datasources/weather_remote_data_source.dart';
import 'package:climater/core/error/exceptions.dart';

const String _baseURL = 'http://api.weatherapi.com/v1';
const String _apiKey = '11f5cb485331466cb4341146251707';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    final url = '$_baseURL/current.json?key=$_apiKey&q=$cityName&aqi=no';

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else {
        throw ServerException(
          message: 'Failed to get weather data',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      } else {
        throw NetworkException(message: 'Network error: ${e.toString()}');
      }
    }
  }

  @override
  Future<WeatherModel> getWeatherByLocation(LocationEntity location) async {
    final url =
        '$_baseURL/current.json?key=$_apiKey&q=${location.latitude},${location.longitude}&aqi=no';

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else {
        throw ServerException(
          message: 'Failed to get weather data',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      } else {
        throw NetworkException(message: 'Network error: ${e.toString()}');
      }
    }
  }
}
