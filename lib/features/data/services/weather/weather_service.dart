import 'package:climater/features/domain/entities/weather_entity.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@singleton
class WeatherService extends GetxService {
  static WeatherService get to => Get.find();

  var currentWeather = Rxn<WeatherEntity>();
  var weatherHistory = <WeatherEntity>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    print('WeatherService initialized');
  }

  void updateWeather(WeatherEntity weather) {
    currentWeather.value = weather;
    errorMessage.value = '';
    _addToHistory(weather);
    print('Weather updated: ${weather.cityName}');
  }

  void clearWeather() {
    currentWeather.value = null;
    errorMessage.value = '';
  }

  void setError(String error) {
    errorMessage.value = error;
    currentWeather.value = null;
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
    if (loading) {
      errorMessage.value = '';
    }
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

  bool get hasWeather => currentWeather.value != null;
  bool get hasError => errorMessage.value.isNotEmpty;
}
