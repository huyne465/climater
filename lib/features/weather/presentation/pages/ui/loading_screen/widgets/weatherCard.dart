import 'package:climater/features/weather/presentation/pages/ui/loading_screen/viewModel/loading_screen_view_model.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/widgets/weatherIcon.dart';
import 'package:climater/features/weather/presentation/pages/ui/loading_screen/widgets/weatherInfo.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.viewModel});

  final LoadingScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
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
          weatherIcon(viewModel: viewModel),

          const SizedBox(height: 20),

          // Weather info display
          WeatherInfo(viewModel: viewModel),
        ],
      ),
    );
  }
}
