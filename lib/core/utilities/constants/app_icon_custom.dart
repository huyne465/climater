import 'package:flutter/material.dart';

class IconCustom extends StatelessWidget {
  final double size;

  final dynamic color;

  final IconData iconName;

  const IconCustom({
    super.key,
    required this.iconName,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(iconName, size: size, color: color);
  }
}


      // Icons.ac_unit,
      // size: 100,
      // color: Colors.white,