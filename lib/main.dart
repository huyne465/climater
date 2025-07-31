import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:climater/core/routes/app_pages.dart';
import 'package:climater/core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependencies first
  configureDependencies();
  //DioService
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
