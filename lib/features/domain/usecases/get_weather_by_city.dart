import 'package:climater/features/domain/entities/weather_entity.dart';
import 'package:climater/features/domain/repositories/weather_repository.dart';
import 'package:climater/features/domain/usecases/usecase.dart';
import 'package:climater/core/error/failures.dart';

class GetWeatherByCity extends UseCase<WeatherEntity, GetWeatherByCityParams> {
  final WeatherRepository repository;

  GetWeatherByCity(this.repository);

  @override
  ResultFuture<WeatherEntity> call(GetWeatherByCityParams params) async {
    return await repository.getWeatherByCity(params.cityName);
  }
}

class GetWeatherByCityParams {
  final String cityName;

  const GetWeatherByCityParams({required this.cityName});
}
