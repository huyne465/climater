import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/viewModel/city_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class searchButton extends StatelessWidget {
  searchButton({super.key, required this.cityText, required viewModel});

  final viewModel = getIt<CityScreenViewModel>();
  final TextEditingController cityText;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          onPressed: viewModel.isLoading
              ? null
              : () {
                  final cityName = cityText.text.trim();
                  if (cityName.isNotEmpty) {
                    viewModel.getWeatherForCity(cityName);
                  } else {
                    Get.snackbar(
                      'Lỗi',
                      'Vui lòng nhập tên thành phố',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
          icon: viewModel.isLoading
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
            viewModel.isLoading ? 'Đang tải...' : 'Lấy Thời Tiết',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kBackGroundButtonSearchColor,
            foregroundColor: kForGroundButtonSearchColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
        ),
      );
    });
  }
}
