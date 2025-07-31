import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/features/domain/entities/weather_entity.dart';
import 'package:climater/features/domain/usecases/get_weather_by_city.dart';
import 'package:climater/features/domain/usecases/get_weather_by_current_location.dart';
import 'package:climater/features/data/services/weather/weather_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:injectable/injectable.dart';

enum LocationScreenStatus { initial, loading, success, error }

@injectable
class LocationViewModel extends GetxController {
  final GetWeatherByCurrentLocation _getWeatherByCurrentLocation;
  final GetWeatherByCity _getWeatherByCity;
  final WeatherService _weatherService = getIt<WeatherService>();

  LocationViewModel({
    required GetWeatherByCity getWeatherByCity,
    required GetWeatherByCurrentLocation getWeatherByCurrentLocation,
  }) : _getWeatherByCity = getWeatherByCity,
       _getWeatherByCurrentLocation = getWeatherByCurrentLocation;

  @override
  void onInit() {
    super.onInit();
  }

  // Use WeatherService observables directly
  bool get isLoading => _weatherService.isLoading.value;
  String get errorMessage => _weatherService.errorMessage.value;
  bool get hasWeather => _weatherService.hasWeather;
  bool get hasError => _weatherService.hasError;
  WeatherEntity? get weather => _weatherService.currentWeather.value;
  List<WeatherEntity> get weatherHistory => _weatherService.weatherHistory;

  Future<void> getWeatherForCity(String cityName) async {
    if (cityName.trim().isEmpty) {
      _weatherService.setError('Tên thành phố không được để trống');
      return;
    }

    _weatherService.setLoading(true);

    final result = await _getWeatherByCity(
      GetWeatherByCityParams(cityName: cityName.trim()),
    );

    result.fold(
      (failure) {
        _weatherService.setLoading(false);
        _weatherService.setError(failure.message);
      },
      (weatherData) {
        _weatherService.setLoading(false);
        _weatherService.updateWeather(weatherData);
      },
    );
  }

  // Methods
  Future<void> getWeatherForCurrentLocation() async {
    _weatherService.setLoading(true);

    final result = await _getWeatherByCurrentLocation();

    result.fold(
      (failure) {
        _weatherService.setLoading(false);
        _weatherService.setError(failure.message);
      },
      (weatherData) {
        _weatherService.setLoading(false);
        _weatherService.updateWeather(weatherData);
      },
    );
  }

  String getWeatherIcon(String condition) {
    final lowerCondition = condition.toLowerCase();

    if (lowerCondition.contains('sunny') || lowerCondition.contains('clear')) {
      return '☀️';
    } else if (lowerCondition.contains('cloud')) {
      return '☁️';
    } else if (lowerCondition.contains('rain') ||
        lowerCondition.contains('drizzle')) {
      return '🌧️';
    } else if (lowerCondition.contains('thunder') ||
        lowerCondition.contains('storm')) {
      return '⛈️';
    } else if (lowerCondition.contains('snow')) {
      return '❄️';
    } else if (lowerCondition.contains('fog') ||
        lowerCondition.contains('mist')) {
      return '🌫️';
    } else {
      return '🌤️';
    }
  }

  String getWeatherMessage(double temperature) {
    if (temperature > 30) {
      return 'Trời nóng! Nhớ uống nhiều nước 🥤';
    } else if (temperature > 25) {
      return 'Thời tiết dễ chịu 😊';
    } else if (temperature > 20) {
      return 'Thời tiết mát mẻ 🍃';
    } else if (temperature > 15) {
      return 'Hơi lạnh, mặc thêm áo nhé 🧥';
    } else {
      return 'Trời lạnh! Giữ ấm cơ thể 🧣';
    }
  }
}
