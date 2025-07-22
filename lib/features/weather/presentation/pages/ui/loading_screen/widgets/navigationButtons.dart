import 'package:climater/core/utilities/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
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
                foregroundColor: kForgroundColor,
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
                foregroundColor: kForgroundColor,
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
