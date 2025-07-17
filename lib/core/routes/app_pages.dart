import 'package:get/get.dart';
import 'package:climater/core/routes/app_routes.dart';
import 'package:climater/features/weather/presentation/pages/loading_screen_new.dart';
import 'package:climater/features/weather/presentation/pages/city_screen_fixed.dart';
import 'package:climater/features/weather/presentation/pages/location_screen_fixed.dart';
import 'package:climater/features/weather/presentation/bindings/weather_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const LoadingScreen(),
      binding: WeatherBinding(),
    ),
    GetPage(
      name: AppRoutes.loading,
      page: () => const LoadingScreen(),
      binding: WeatherBinding(),
    ),
    GetPage(
      name: AppRoutes.city,
      page: () => const CityScreen(),
      binding: WeatherBinding(),
    ),
    GetPage(
      name: AppRoutes.location,
      page: () => const LocationScreen(),
      binding: WeatherBinding(),
    ),
  ];
}
