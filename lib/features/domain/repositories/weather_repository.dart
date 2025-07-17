import 'package:climater/core/error/failures.dart';
import 'package:climater/features/domain/entities/weather_entity.dart';
import 'package:climater/features/domain/entities/location_entity.dart';

abstract class WeatherRepository {
  ResultFuture<WeatherEntity> getWeatherByLocation(LocationEntity location);
  ResultFuture<WeatherEntity> getWeatherByCity(String cityName);
  ResultFuture<List<WeatherEntity>> getWeatherHistory();
  ResultVoid saveWeatherToHistory(WeatherEntity weather);
}
