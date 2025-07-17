import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:climater/features/weather/presentation/controllers/weather_controller.dart';

class LocationScreen extends GetView<WeatherController> {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
              Colors.lightBlue.shade400,
            ],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopSection(),
              _buildWeatherInfo(),
              _buildDetailedInfo(),
              _buildBottomInfo(),
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
            onPressed: () {
              controller.getWeatherForCurrentLocation();
            },
            icon: const Icon(Icons.near_me, size: 50.0, color: Colors.white),
          ),
        ),
        // Go to city search button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: () => Get.toNamed('/city'),
            icon: const Icon(
              Icons.location_city,
              size: 50.0,
              color: Colors.white,
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
              if (controller.hasWeather) {
                return Text(
                  '${controller.weather.value!.temperature.round()}°',
                  style: const TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ),
                );
              } else if (controller.isLoading.value) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                );
              } else {
                return const Icon(
                  Icons.ac_unit,
                  size: 100,
                  color: Colors.white,
                );
              }
            }),

            const SizedBox(height: 20),

            // Weather condition and location
            Obx(() {
              if (controller.hasWeather) {
                final weather = controller.weather.value!;
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
              } else if (controller.hasError) {
                return Column(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      controller.errorMessage.value,
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
      if (controller.hasWeather) {
        final weather = controller.weather.value!;
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
              _buildDetailItem(
                'Cảm giác như',
                '${weather.feelsLike.round()}°C',
                Icons.thermostat,
              ),
              _buildDetailItem(
                'Độ ẩm',
                '${weather.humidity.round()}%',
                Icons.water_drop,
              ),
              _buildDetailItem(
                'Gió',
                '${weather.windSpeed.round()} km/h',
                Icons.air,
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomInfo() {
    return Obx(() {
      if (controller.hasWeather) {
        final weather = controller.weather.value!;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            controller.getWeatherMessage(weather.temperature),
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
