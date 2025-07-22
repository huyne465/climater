import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/viewModel/city_screen_view_model.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/widgets/backButton.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/widgets/quickSearchButton.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/widgets/searchCityButton.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/widgets/titleFindingCity.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/widgets/weatherIcon.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/widgets/weatherInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityScreen extends GetView<CityScreenViewModel> {
  const CityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityTextController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kBlue700, kBlue500, kBLue300],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              backButton(),
              const SizedBox(height: 20),
              titleFindingCity.titleFindingCity(),
              const SizedBox(height: 30),
              _buildSearchContainer(cityTextController),
              const SizedBox(height: 20),
              _buildWeatherDisplay(),
              const Spacer(),
              quickSearchButton(
                viewModel: controller,
                cityText: cityTextController,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchContainer(TextEditingController cityTextController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        children: [
          // City input field
          TextField(
            controller: cityTextController,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                controller.getWeatherForCity(value.trim());
              }
            },
            style: const TextStyle(fontSize: 20, color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'Nhập tên thành phố...',
              hintStyle: TextStyle(color: Colors.grey.shade600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: kBLue300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: kBlue600, width: 2),
              ),
              prefixIcon: Icon(Icons.location_city, color: kBlue600, size: 28),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
          ),

          const SizedBox(height: 20),

          // Get Weather button
          searchButton(viewModel: controller, cityText: cityTextController),
        ],
      ),
    );
  }

  Widget _buildWeatherDisplay() {
    return Obx(() {
      // Always access .value for observable variables inside Obx
      final isLoading = controller.isLoading;
      final hasWeather = controller.weather != null;
      final hasError = controller.errorMessage.isNotEmpty;

      if (!hasWeather && !hasError && !isLoading) {
        return Container();
      }

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            weatherIcon(viewModel: controller),
            const SizedBox(height: 20),
            WeatherInfo(viewModel: controller),
          ],
        ),
      );
    });
  }
}
