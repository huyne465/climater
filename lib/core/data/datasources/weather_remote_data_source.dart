import 'package:climater/features/data/models/weather_model.dart';
import 'package:climater/features/domain/entities/location_entity.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherByLocation(LocationEntity location);
  Future<WeatherModel> getWeatherByCity(String cityName);
}
