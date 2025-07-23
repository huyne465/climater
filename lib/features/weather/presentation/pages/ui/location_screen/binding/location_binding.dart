import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/features/weather/presentation/pages/ui/location_screen/viewModel/location_screen_view_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

// class LocationBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: implement dependencies
//     Get.lazyPut<LocationViewModel>(() => getIt<LocationViewModel>());
//   }
// }

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationViewModel>(() => getIt<LocationViewModel>());
  }
}

// class LocationBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<LocationViewModel>(
//       () => LocationViewModel(
//         getWeatherByCity: Get.find<GetWeatherByCity>(),
//         getWeatherByCurrentLocation: Get.find<GetWeatherByCurrentLocation>(),
//       ),
//     );
//   }
// }
