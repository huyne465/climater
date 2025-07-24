import 'package:dio/dio.dart';

import 'package:climater/features/data/models/weather_model.dart';
import 'package:climater/features/domain/entities/location_entity.dart';
import 'package:climater/features/data/datasources/weather_remote_data_source.dart';
import 'package:climater/core/error/exceptions.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      final response = await dio.get(
        '/current.json',
        queryParameters: {'q': cityName},
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw HandleDioException(e);
    } catch (e) {
      throw NetworkException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<WeatherModel> getWeatherByLocation(LocationEntity location) async {
    try {
      final response = await dio.get(
        '/current.json',
        queryParameters: {'q': '${location.latitude},${location.longitude}'},
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw HandleDioException(e);
    } catch (e) {
      throw NetworkException(message: 'Unexpected error: ${e.toString()}');
    }
  }
}
