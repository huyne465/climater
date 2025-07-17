import 'package:climater/features/domain/entities/weather_entity.dart';
import 'package:climater/features/domain/repositories/weather_repository.dart';
import 'package:climater/features/domain/repositories/location_repository.dart';
import 'package:climater/features/domain/usecases/usecase.dart';
import 'package:climater/core/error/failures.dart';
import 'package:dartz/dartz.dart';

class GetWeatherByCurrentLocation extends UseCaseWithoutParams<WeatherEntity> {
  final WeatherRepository weatherRepository;
  final LocationRepository locationRepository;

  GetWeatherByCurrentLocation({
    required this.weatherRepository,
    required this.locationRepository,
  });

  @override
  ResultFuture<WeatherEntity> call() async {
    final locationResult = await locationRepository.getCurrentLocation();

    return locationResult.fold(
      (failure) async => Left(failure),
      (location) async =>
          await weatherRepository.getWeatherByLocation(location),
    );
  }
}
