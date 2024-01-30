import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_player/repository/model.dart';
import 'package:music_player/resources/components/buildIcons.dart';
import 'package:music_player/view/singleMusicPage.dart';
import 'package:music_player/utils/routes/routeName.dart';
import 'package:music_player/utils/routes/routs.dart';

import '../appColor.dart';
import 'buildText.dart';

class SingleTrack extends StatelessWidget {
  SingleTrack({Key? key, required this.track}) : super(key: key);

  final Tracks track;
  final List<Color> _color = [
    AppColor.colorsOrange,
    AppColor.colorsPurple,
    AppColor.colorsGreen,
    AppColor.colorYello,
  ];

  int generateRandomNumber() => Random().nextInt(3);

  @override
  Widget build(BuildContext context) {
    int firstColorIndex = generateRandomNumber();
    int secondColorIndex = generateRandomNumber();

    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleMusicPage(track: track)));
      },
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _color[firstColorIndex],
              _color[secondColorIndex],
            ],
          ),
        ),
        // child: Image(
        //   image: NetworkImage(
        //     track.cover_small,
        //   ),

        // ),
      ),
      title: BuildText(text: track.title),
      subtitle: BuildText(
        text: track.artist.name,
        style: Theme.of(context)
            .primaryTextTheme
            .bodySmall!
            .copyWith(color: Colors.black, fontSize: 14),
      ),
      trailing: InkWell(
        onTap: () {},
        child: const BuildIcon(
          icon: Icons.more_vert,
          color: Colors.black,
        ),
      ),
    );
  }
}
