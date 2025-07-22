import 'package:climater/features/weather/presentation/pages/ui/city_screen/city_screen.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/loading_screen.dart';
import 'package:climater/features/weather/presentation/pages/ui/location_screen/location_screen.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/binding/loading_screen_binding.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/binding/city_screen_binding.dart';
import 'package:climater/features/weather/presentation/pages/ui/location_screen/binding/location_binding.dart';
import 'package:get/get.dart';
import 'package:climater/core/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const LoadingScreen(),
      binding: LoadingScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.loading,
      page: () => const LoadingScreen(),
      binding: LoadingScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.city,
      page: () => const CityScreen(),
      binding: CityScreenBinding(),
    ),
    GetPage(
      name: AppRoutes.location,
      page: () => const LocationScreen(),
      binding: LocationBinding(),
    ),
  ];
}
