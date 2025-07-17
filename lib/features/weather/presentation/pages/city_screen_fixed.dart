import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:climater/features/weather/presentation/controllers/weather_controller.dart';

class CityScreen extends GetView<WeatherController> {
  const CityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController cityController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.lightBlue.shade300,
            ],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              _buildBackButton(),
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 30),
              _buildSearchContainer(cityController),
              const SizedBox(height: 20),
              _buildWeatherDisplay(),
              const Spacer(),
              _buildQuickSearchButtons(cityController),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, size: 28, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Tìm Kiếm Thành Phố',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSearchContainer(TextEditingController cityController) {
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
            controller: cityController,
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
                borderSide: BorderSide(color: Colors.blue.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
              prefixIcon: Icon(
                Icons.location_city,
                color: Colors.blue.shade600,
                size: 28,
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
            ),
          ),

          const SizedBox(height: 20),

          // Get Weather button
          _buildSearchButton(cityController),
        ],
      ),
    );
  }

  Widget _buildSearchButton(TextEditingController cityController) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: controller.isLoading.value
              ? null
              : () {
                  final cityName = cityController.text.trim();
                  if (cityName.isNotEmpty) {
                    controller.getWeatherForCity(cityName);
                  } else {
                    Get.snackbar(
                      'Lỗi',
                      'Vui lòng nhập tên thành phố',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
          icon: controller.isLoading.value
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.cloud, size: 24),
          label: Text(
            controller.isLoading.value ? 'Đang tải...' : 'Lấy Thời Tiết',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade600,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
        ),
      );
    });
  }

  Widget _buildWeatherDisplay() {
    return Obx(() {
      if (!controller.hasWeather &&
          !controller.hasError &&
          !controller.isLoading.value) {
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
            _buildWeatherIcon(),
            const SizedBox(height: 20),
            _buildWeatherInfo(),
          ],
        ),
      );
    });
  }

  Widget _buildWeatherIcon() {
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
        );
      } else if (controller.hasError) {
        return const Icon(Icons.error_outline, size: 60, color: Colors.red);
      } else if (controller.hasWeather) {
        return Text(
          controller.getWeatherIcon(controller.weather.value!.condition),
          style: const TextStyle(fontSize: 60),
        );
      } else {
        return const Icon(Icons.wb_sunny, size: 60, color: Colors.orange);
      }
    });
  }

  Widget _buildWeatherInfo() {
    return Obx(() {
      String weatherText;

      if (controller.hasError) {
        weatherText = controller.errorMessage.value;
      } else if (controller.hasWeather) {
        final weather = controller.weather.value!;
        weatherText =
            '🏙️ ${weather.cityName}, ${weather.region}\n'
            '🌡️ Nhiệt độ: ${weather.temperature.round()}°C\n'
            '🌡️ Cảm giác như: ${weather.feelsLike.round()}°C\n'
            '☁️ Tình trạng: ${weather.condition}\n'
            '💧 Độ ẩm: ${weather.humidity.round()}%\n'
            '💨 Gió: ${weather.windSpeed.round()} km/h ${weather.windDirection}\n\n'
            '${controller.getWeatherMessage(weather.temperature)}';
      } else {
        weatherText = 'Đang tải dữ liệu...';
      }

      return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          weatherText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey.shade800,
          ),
          textAlign: TextAlign.center,
        ),
      );
    });
  }

  Widget _buildQuickSearchButtons(TextEditingController cityController) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Tìm kiếm nhanh:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.getWeatherForCity('Ho Chi Minh City');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('TP.HCM'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.getWeatherForCity('Hanoi');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Hà Nội'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.getWeatherForCity('Da Nang');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Đà Nẵng'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
