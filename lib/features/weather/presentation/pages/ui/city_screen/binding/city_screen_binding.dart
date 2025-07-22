import 'package:climater/features/domain/usecases/get_weather_by_city.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/viewModel/city_screen_view_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class CityScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CityScreenViewModel>(
      () => CityScreenViewModel(getWeatherByCity: Get.find<GetWeatherByCity>()),
    );
  }
}
