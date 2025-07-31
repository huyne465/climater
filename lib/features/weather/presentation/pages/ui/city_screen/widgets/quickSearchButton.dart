import 'package:climater/core/di/config/di_weather.dart';
import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:climater/features/weather/presentation/pages/ui/city_screen/viewModel/city_screen_view_model.dart';
import 'package:flutter/material.dart';

class quickSearchButton extends StatelessWidget {
  quickSearchButton({
    super.key,
    required this.cityText,
    required CityScreenViewModel viewModel,
  });

  final TextEditingController cityText;
  final viewModel = getIt<CityScreenViewModel>();

  @override
  Widget build(BuildContext context) {
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
                    viewModel.getWeatherForCity('Ho Chi Minh City');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBackGroundButtonSearchColor,
                    foregroundColor: kForGroundButtonSearchColor,
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
                    viewModel.getWeatherForCity('Hanoi');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBackGroundButtonSearchColor,
                    foregroundColor: kForGroundButtonSearchColor,
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
                    viewModel.getWeatherForCity('Da Nang');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBackGroundButtonSearchColor,
                    foregroundColor: kForGroundButtonSearchColor,
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
