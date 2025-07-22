import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/viewModel/loading_screen_view_model.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/widgets/navigationButtons.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/widgets/weatherIcon.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/widgets/weatherInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends GetView<LoadingScreenViewModel> {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBlue100,
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: kLightBlue700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kLightBlue300, kLightBlue100, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Weather Display Card
                _buildWeatherCard(controller),

                const SizedBox(height: 40),

                // Action buttons
                _buildActionButtons(controller),

                const SizedBox(height: 30),

                // Navigation buttons
                NavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard(LoadingScreenViewModel controller) {
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
          weatherIcon(viewModel: controller),

          const SizedBox(height: 20),

          // Weather info display
          WeatherInfo(viewModel: controller),
        ],
      ),
    );
  }

  Widget _buildActionButtons(LoadingScreenViewModel viewModel) {
    return Column(
      children: [
        // Get current location weather button
        Obx(
          () => _buildActionButton(
            onPressed: controller.isLoading
                ? null
                : () => controller.getWeatherForCurrentLocation(),
            icon: Icons.my_location,
            label: 'Lấy thời tiết vị trí hiện tại',
            color: kLightBlue600,
            isLoading: controller.isLoading,
          ),
        ),

        const SizedBox(height: 15),

        // Test with Ho Chi Minh City
        Obx(
          () => _buildActionButton(
            onPressed: controller.isLoading
                ? null
                : () => controller.getWeatherForCity('Ho Chi Minh City'),
            icon: Icons.location_city,
            label: 'Lấy thời tiết TP.HCM',
            color: kBackGroundButtonSearchColor,
            isLoading: controller.isLoading,
          ),
        ),

        const SizedBox(height: 15),

        // Test with Hanoi
        Obx(
          () => _buildActionButton(
            onPressed: controller.isLoading
                ? null
                : () => controller.getWeatherForCity('Hanoi'),
            icon: Icons.location_city,
            label: 'Lấy thời tiết Hà Nội',
            color: Colors.green.shade600,
            isLoading: controller.isLoading,
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
}
