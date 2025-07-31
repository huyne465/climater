import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/viewModel/loading_screen_view_model.dart';
import 'package:climater/features/data/services/weather/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.viewModel});

  final LoadingScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weatherService = getIt<WeatherService>();
      String weatherText;

      if (weatherService.hasError) {
        weatherText = weatherService.errorMessage.value;
      } else if (weatherService.hasWeather) {
        final weather = weatherService.currentWeather.value!;
        weatherText =
            '🏙️ ${weather.cityName}, ${weather.region}\n'
            '🌡️ Nhiệt độ: ${weather.temperature.round()}°C\n'
            '🌡️ Cảm giác như: ${weather.feelsLike.round()}°C\n'
            '☁️ Tình trạng: ${weather.condition}\n'
            '💧 Độ ẩm: ${weather.humidity.round()}%\n'
            '💨 Gió: ${weather.windSpeed.round()} km/h ${weather.windDirection}\n\n'
            '${viewModel.getWeatherMessage(weather.temperature)}';
      } else {
        weatherText = 'Đang tải dữ liệu...';
      }

      return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kBlue50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          weatherText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: kBlueGrey800,
          ),
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
