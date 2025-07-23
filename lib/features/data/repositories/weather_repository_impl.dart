import 'package:dartz/dartz.dart';
import 'package:climater/features/domain/entities/weather_entity.dart';
import 'package:climater/features/domain/entities/location_entity.dart';
import 'package:climater/features/domain/repositories/weather_repository.dart';
import 'package:climater/features/data/datasources/weather_remote_data_source.dart';
import 'package:climater/core/error/failures.dart';
import 'package:climater/core/error/exceptions.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<WeatherEntity> getWeatherByCity(String cityName) async {
    try {
      final result = await remoteDataSource.getWeatherByCity(cityName);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  ResultFuture<WeatherEntity> getWeatherByLocation(
    LocationEntity location,
  ) async {
    try {
      final result = await remoteDataSource.getWeatherByLocation(location);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  @override
  ResultFuture<List<WeatherEntity>> getWeatherHistory() async {
    // TODO: Implement local storage for weather history
    return const Right([]);
  }

  @override
  ResultVoid saveWeatherToHistory(WeatherEntity weather) async {
    // TODO: Implement local storage for weather history
    return const Right(null);
  }
}
