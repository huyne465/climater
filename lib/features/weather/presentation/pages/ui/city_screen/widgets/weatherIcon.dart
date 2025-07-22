import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/viewModel/city_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class weatherIcon extends StatelessWidget {
  const weatherIcon({super.key, required this.viewModel});

  final CityScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (viewModel.isLoading) {
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kBlue600),
        );
      } else if (viewModel.hasError) {
        return const Icon(Icons.error_outline, size: 60, color: Colors.red);
      } else if (viewModel.hasWeather) {
        return Text(
          viewModel.getWeatherIcon(viewModel.weather!.condition),
          style: const TextStyle(fontSize: 60),
        );
      } else {
        return const Icon(Icons.wb_sunny, size: 60, color: Colors.orange);
      }
    });
  }
}
