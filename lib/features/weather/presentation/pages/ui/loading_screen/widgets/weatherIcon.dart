import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/viewModel/loading_screen_view_model.dart';
import 'package:climater/features/data/services/weather/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class weatherIcon extends StatelessWidget {
  const weatherIcon({super.key, required this.viewModel});

  final LoadingScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weatherService = getIt<WeatherService>();

      if (weatherService.isLoading.value) {
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kLightBlue700),
        );
      } else if (weatherService.hasWeather) {
        return Text(
          viewModel.getWeatherIcon(
            weatherService.currentWeather.value!.condition,
          ),
          style: const TextStyle(fontSize: 80),
        );
      } else {
        return Icon(Icons.wb_sunny, size: 80, color: Colors.orange);
      }
    });
  }
}
