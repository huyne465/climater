import 'package:get/get.dart';
import 'package:climater/features/domain/entities/weather_entity.dart';
import 'package:climater/features/domain/usecases/get_weather_by_city.dart';
import 'package:climater/features/domain/usecases/get_weather_by_current_location.dart';

enum WeatherStatus { initial, loading, success, error }

class WeatherController extends GetxController {
  final GetWeatherByCity _getWeatherByCity;
  final GetWeatherByCurrentLocation _getWeatherByCurrentLocation;

  WeatherController({
    required GetWeatherByCity getWeatherByCity,
    required GetWeatherByCurrentLocation getWeatherByCurrentLocation,
  }) : _getWeatherByCity = getWeatherByCity,
       _getWeatherByCurrentLocation = getWeatherByCurrentLocation;

  // Observable variables
  var isLoading = false.obs;
  var weather = Rxn<WeatherEntity>();
  var errorMessage = ''.obs;
  var weatherHistory = <WeatherEntity>[].obs;

  // Getters for UI convenience
  bool get hasWeather => weather.value != null;
  bool get hasError => errorMessage.value.isNotEmpty;

  // Methods
  Future<void> getWeatherForCurrentLocation() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _getWeatherByCurrentLocation();

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
        weather.value = null;
      },
      (weatherData) {
        isLoading.value = false;
        weather.value = weatherData;
        errorMessage.value = '';
        _addToHistory(weatherData);
      },
    );
  }

  Future<void> getWeatherForCity(String cityName) async {
    if (cityName.trim().isEmpty) {
      errorMessage.value = 'Tên thành phố không được để trống';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final result = await _getWeatherByCity(
      GetWeatherByCityParams(cityName: cityName.trim()),
    );

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = failure.message;
        weather.value = null;
      },
      (weatherData) {
        isLoading.value = false;
        weather.value = weatherData;
        errorMessage.value = '';
        _addToHistory(weatherData);
      },
    );
  }

  void _addToHistory(WeatherEntity weatherData) {
    // Remove if already exists (to avoid duplicates)
    weatherHistory.removeWhere((w) => w.cityName == weatherData.cityName);

    // Add to beginning of list
    weatherHistory.insert(0, weatherData);

    // Keep only last 10 searches
    if (weatherHistory.length > 10) {
      weatherHistory.removeRange(10, weatherHistory.length);
    }
  }

  void clearError() {
    errorMessage.value = '';
  }

  void clearWeather() {
    weather.value = null;
    errorMessage.value = '';
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
