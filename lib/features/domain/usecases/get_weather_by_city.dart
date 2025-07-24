import 'package:climater/features/domain/entities/weather_entity.dart';
import 'package:climater/features/domain/repositories/weather_repository.dart';
import 'package:climater/features/domain/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWeatherByCity extends UseCase<WeatherEntity, GetWeatherByCityParams> {
  final WeatherRepository _repository;

  GetWeatherByCity(this._repository);

  @override
  ResultFuture<WeatherEntity> call(GetWeatherByCityParams params) async {
    return await _repository.getWeatherByCity(params.cityName);
  }
}

class GetWeatherByCityParams {
  final String cityName;

  const GetWeatherByCityParams({required this.cityName});
}
