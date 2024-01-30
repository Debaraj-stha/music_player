import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/utils/routes/routeName.dart';
import 'package:music_player/utils/routes/routs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesName.HomePage,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
