import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  const BuildText(
      {super.key,
      required this.text,
      this.style = const TextStyle(color: Colors.black)});
  final String text;
  final TextStyle style;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
