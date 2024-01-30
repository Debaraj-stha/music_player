import 'package:flutter/material.dart';

class BuildIcon extends StatelessWidget {
  const BuildIcon(
      {super.key,
      required this.icon,
      this.size = 30,
      this.color = Colors.white});
  final IconData icon;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
