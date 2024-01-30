import 'package:flutter/material.dart';
import 'package:music_player/resources/appColor.dart';

class MyBox extends StatelessWidget {
  const MyBox(
      {super.key,
      this.child,
      this.width = 120,
      this.height = 100,
      this.colors = const [AppColor.colorYello]});
  final child;
  final double width;
  final double height;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
