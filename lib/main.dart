import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:climater/core/di/dependency_injection.dart';
import 'package:climater/core/routes/app_pages.dart';
import 'package:climater/core/routes/app_routes.dart';

void main() {
  // Initialize dependencies first
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Climater - Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      initialRoute: AppRoutes.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
