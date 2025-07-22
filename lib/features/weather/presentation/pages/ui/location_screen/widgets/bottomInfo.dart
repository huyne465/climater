import 'package:climater/features/weather/presentation/pages/ui/location_screen/viewModel/location_screen_view_model.dart';
import 'package:climater/features/data/services/weather/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';

class bottomInfoWidget extends StatelessWidget {
  const bottomInfoWidget({super.key, required this.viewModel});

  final LocationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weatherService = Get.find<WeatherService>();
      if (weatherService.hasWeather) {
        final weather = weatherService.currentWeather.value!;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            viewModel.getWeatherMessage(weather.temperature),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
