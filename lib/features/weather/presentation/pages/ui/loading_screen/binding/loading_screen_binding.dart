import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/viewModel/loading_screen_view_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

// class LoadingScreenBinding extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: implement dependencies
//     Get.lazyPut<LoadingScreenViewModel>(() => getIt<LoadingScreenViewModel>());
//   }
// }

class LoadingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoadingScreenViewModel>(() => getIt<LoadingScreenViewModel>());
  }
}

// class LoadingScreenBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<LoadingScreenViewModel>(
//       () => LoadingScreenViewModel(
//         getWeatherByCity: Get.find<GetWeatherByCity>(),
//         getWeatherByCurrentLocation: Get.find<GetWeatherByCurrentLocation>(),
//       ),
//     );
//   }
// }
