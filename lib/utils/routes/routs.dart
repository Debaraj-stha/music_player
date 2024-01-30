import 'package:flutter/material.dart';

import 'package:music_player/utils/routes/routeName.dart';
import 'package:music_player/view/favouritePage.dart';
import 'package:music_player/view/homepage.dart';
import 'package:music_player/view/playList.dart';
import 'package:music_player/view/recentPage.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.HomePage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomePage());
      case RoutesName.Facvourite:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FacvouritePage());
      case RoutesName.PlayList:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PlayList());
      case RoutesName.Recent:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RecentPage());
   
       
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("No Page found"),
                  ),
                ));
    }
  }
}
