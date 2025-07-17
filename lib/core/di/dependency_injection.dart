import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Data Sources
import 'package:climater/features/data/datasources/weather_remote_data_source.dart';
import 'package:climater/features/data/datasources/weather_remote_data_source_impl.dart';
import 'package:climater/features/data/datasources/location_remote_data_source.dart';
import 'package:climater/features/data/datasources/location_remote_data_source_impl.dart';

// Repositories
import 'package:climater/features/domain/repositories/weather_repository.dart';
import 'package:climater/features/data/repositories/weather_repository_impl.dart';
import 'package:climater/features/domain/repositories/location_repository.dart';
import 'package:climater/features/data/repositories/location_repository_impl.dart';

// Use Cases
import 'package:climater/features/domain/usecases/get_weather_by_city.dart';
import 'package:climater/features/domain/usecases/get_weather_by_current_location.dart';

class DependencyInjection {
  static void init() {
    // External Dependencies
    Get.put<http.Client>(http.Client());

    // Data Sources
    Get.put<WeatherRemoteDataSource>(
      WeatherRemoteDataSourceImpl(client: Get.find()),
    );

    Get.put<LocationRemoteDataSource>(LocationRemoteDataSourceImpl());

    // Repositories
    Get.put<WeatherRepository>(
      WeatherRepositoryImpl(remoteDataSource: Get.find()),
    );

    Get.put<LocationRepository>(
      LocationRepositoryImpl(remoteDataSource: Get.find()),
    );

    // Use Cases
    Get.put(GetWeatherByCity(Get.find()));

    Get.put(
      GetWeatherByCurrentLocation(
        weatherRepository: Get.find(),
        locationRepository: Get.find(),
      ),
    );
  }
}
