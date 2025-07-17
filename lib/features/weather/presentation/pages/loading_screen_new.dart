import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:climater/features/weather/presentation/controllers/weather_controller.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherController controller = Get.find<WeatherController>();

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue.shade300,
              Colors.lightBlue.shade100,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Weather Display Card
                Obx(() => _buildWeatherCard(controller)),

                const SizedBox(height: 40),

                // Action buttons
                _buildActionButtons(controller),

                const SizedBox(height: 30),

                // Navigation buttons
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(WeatherController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        children: [
          // Weather icon based on status
          _buildWeatherIcon(controller),

          const SizedBox(height: 20),

          // Weather info display
          _buildWeatherInfo(controller),
        ],
      ),
    );
  }

  Widget _buildWeatherIcon(WeatherController controller) {
    if (controller.isLoading.value) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue.shade700),
      );
    } else if (controller.weather.value != null) {
      return Text(
        controller.getWeatherIcon(controller.weather.value!.condition),
        style: const TextStyle(fontSize: 80),
      );
    } else {
      return Icon(Icons.wb_sunny, size: 80, color: Colors.orange);
    }
  }

  Widget _buildWeatherInfo(WeatherController controller) {
    String displayText;

    if (controller.isLoading.value) {
      displayText = 'Đang lấy dữ liệu thời tiết...';
    } else if (controller.errorMessage.value.isNotEmpty) {
      displayText = '❌ ${controller.errorMessage.value}';
    } else if (controller.weather.value != null) {
      final weather = controller.weather.value!;
      displayText =
          '📍 ${weather.cityName}, ${weather.region}\n'
          '🌡️ Nhiệt độ: ${weather.temperature.round()}°C\n'
          '🌡️ Cảm giác như: ${weather.feelsLike.round()}°C\n'
          '☁️ Tình trạng: ${weather.condition}\n'
          '💧 Độ ẩm: ${weather.humidity.round()}%\n'
          '💨 Gió: ${weather.windSpeed.round()} km/h ${weather.windDirection}\n\n'
          '${controller.getWeatherMessage(weather.temperature)}';
    } else {
      displayText = 'Nhấn nút để lấy thông tin thời tiết';
    }

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.blueGrey.shade800,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildActionButtons(WeatherController controller) {
    return Column(
      children: [
        // Get current location weather button
        Obx(
          () => _buildActionButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.getWeatherForCurrentLocation(),
            icon: Icons.my_location,
            label: 'Lấy thời tiết vị trí hiện tại',
            color: Colors.lightBlue.shade600,
            isLoading: controller.isLoading.value,
          ),
        ),

        const SizedBox(height: 15),

        // Test with Ho Chi Minh City
        Obx(
          () => _buildActionButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.getWeatherForCity('Ho Chi Minh City'),
            icon: Icons.location_city,
            label: 'Lấy thời tiết TP.HCM',
            color: Colors.orange.shade600,
            isLoading: controller.isLoading.value,
          ),
        ),

        const SizedBox(height: 15),

        // Test with Hanoi
        Obx(
          () => _buildActionButton(
            onPressed: controller.isLoading.value
                ? null
                : () => controller.getWeatherForCity('Hanoi'),
            icon: Icons.location_city,
            label: 'Lấy thời tiết Hà Nội',
            color: Colors.green.shade600,
            isLoading: controller.isLoading.value,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required VoidCallback? onPressed,
    required IconData icon,
    required String label,
    required Color color,
    required bool isLoading,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        // Navigate to Location Screen
        Expanded(
          child: Container(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed('/location'),
              icon: const Icon(Icons.navigation, size: 20),
              label: const Text('Location Screen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Navigate to City Screen
        Expanded(
          child: Container(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed('/city'),
              icon: const Icon(Icons.search, size: 20),
              label: const Text('City Screen'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
