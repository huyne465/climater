import 'package:get/get.dart';
import 'package:climater/features/weather/presentation/controllers/weather_controller.dart';
import 'package:climater/features/domain/usecases/get_weather_by_city.dart';
import 'package:climater/features/domain/usecases/get_weather_by_current_location.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherController>(
      () => WeatherController(
        getWeatherByCity: Get.find<GetWeatherByCity>(),
        getWeatherByCurrentLocation: Get.find<GetWeatherByCurrentLocation>(),
      ),
    );
  }
}
