import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/core/utilities/constants/app_icon_custom.dart';
import 'package:climater/features/weather/presentation/pages/ui/location_screen/viewModel/location_screen_view_model.dart';
import 'package:climater/features/weather/presentation/pages/ui/location_screen/widgets/bottomInfo.dart';
import 'package:climater/features/weather/presentation/pages/ui/location_screen/widgets/detailItem.dart';
import 'package:climater/features/data/services/weather/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationScreen extends GetView<LocationViewModel> {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kBlue800, kBlue600, kBlue400],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopSection(),
              _buildWeatherInfo(),
              _buildDetailedInfo(),
              bottomInfoWidget(viewModel: controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // Get current location button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: () => Get.toNamed('/loading'),
            icon: IconCustom(
              iconName: Icons.near_me,
              size: 50.0,
              color: kIconWhite,
            ),
          ),
        ),
        // Go to city search button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: () => Get.toNamed('/city'),
            icon: IconCustom(
              iconName: Icons.location_city,
              size: 50.0,
              color: kIconWhite,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherInfo() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Temperature display
            Obx(() {
              final weatherService = Get.find<WeatherService>();
              final hasWeather = weatherService.hasWeather;
              final isLoading = weatherService.isLoading.value;

              if (hasWeather) {
                return Text(
                  '${weatherService.currentWeather.value!.temperature.round()}°',
                  style: const TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ),
                );
              } else if (isLoading) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                );
              } else {
                return IconCustom(
                  iconName: Icons.ac_unit,
                  size: 100,
                  color: kIconWhite,
                );
              }
            }),

            const SizedBox(height: 20),

            // Weather condition and location
            Obx(() {
              final weatherService = Get.find<WeatherService>();
              final hasWeather = weatherService.hasWeather;
              final hasError = weatherService.hasError;
              final errorMessage = weatherService.errorMessage.value;

              if (hasWeather) {
                final weather = weatherService.currentWeather.value!;
                return Column(
                  children: [
                    Text(
                      controller.getWeatherIcon(weather.condition),
                      style: const TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      weather.condition,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${weather.cityName}, ${weather.region}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                );
              } else if (hasError) {
                return Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      errorMessage,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              } else {
                return const Text(
                  'Nhấn nút để lấy thời tiết',
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedInfo() {
    return Obx(() {
      final weatherService = Get.find<WeatherService>();
      if (weatherService.hasWeather) {
        final weather = weatherService.currentWeather.value!;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              detailItemWidget(
                label: 'Cảm giác như',
                value: '${weather.feelsLike.round()}°C',
                icon: Icons.thermostat,
              ),
              detailItemWidget(
                label: 'Độ ẩm',
                value: '${weather.humidity.round()}%',
                icon: Icons.water_drop,
              ),
              detailItemWidget(
                label: 'Gió',
                value: '${weather.windSpeed.round()} km/h',
                icon: Icons.air,
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
