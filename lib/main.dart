import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/features/data/services/Dio/dio_service.dart';
import 'package:climater/features/data/services/weather/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:climater/core/routes/app_pages.dart';
import 'package:climater/core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependencies first
  configureDependencies();

  getIt<DioService>();

  // Initialize WeatherService with GetX
  Get.put(getIt<WeatherService>(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Climater - Weather App',
      theme: ThemeData(
        primarySwatch: kBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: AppRoutes.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
