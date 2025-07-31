import 'package:climater/features/weather/presentation/pages/ui/city_screen/city_screen.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/loading_screen.dart';
import 'package:climater/features/weather/presentation/pages/ui/location_screen/location_screen.dart';
import 'package:get/get.dart';
import 'package:climater/core/routes/app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.initial, page: () => LoadingScreen()),
    GetPage(name: AppRoutes.loading, page: () => LoadingScreen()),
    GetPage(name: AppRoutes.city, page: () => CityScreen()),
    GetPage(name: AppRoutes.location, page: () => LocationScreen()),
  ];
}
