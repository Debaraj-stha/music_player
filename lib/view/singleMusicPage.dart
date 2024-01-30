import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/model_view/music_player_view.dart';
import 'package:music_player/repository/model.dart';
import 'package:music_player/resources/appColor.dart';
import 'package:music_player/resources/components/buildIcons.dart';
import 'package:music_player/resources/components/buildText.dart';

class SingleMusicPage extends StatefulWidget {
  const SingleMusicPage({super.key, required this.track});
  final Tracks track;
  @override
  State<SingleMusicPage> createState() => _SingleMusicPageState();
}

class _SingleMusicPageState extends State<SingleMusicPage> {
  final MusicPlayerView _musicPlayerView = MusicPlayerView();
  @override
  void initState() {
    // TODO: implement initState
    _musicPlayerView.playAudio(context);
    _musicPlayerView.playPauseController.add("playing");
    setState(() {
      x();
    });
    super.initState();
  }

  x() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _musicPlayerView.handleDurationChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      backgroundColor: Colors.grey.withOpacity(0.7),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.7),
        elevation: 0,
        actions: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2), shape: BoxShape.circle),
              child: const Icon(Icons.more_vert))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.9,
                height: size.height * 0.4,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColor.colorsOrange, AppColor.colorYello])),
                child: const Icon(
                  Icons.music_note,
                  color: AppColor.colorsPurple,
                  size: 80,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BuildText(
                text: widget.track.title,
                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 30,
              ),

              StreamBuilder(
                  stream: _musicPlayerView.durationController.stream,
                  builder: ((context, snapshot) {
                    print("snapshot data :${snapshot.data}");
                    if (snapshot.hasData) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          _musicPlayerView.seekToPosition(details, context);
                        },
                        child: LinearProgressIndicator(
                          value: snapshot.data,
                          backgroundColor: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                        ),
                      );
                    } else {
                      return const LinearProgressIndicator(
                        value: 0,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      );
                    }
                  })),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                      stream:
                          _musicPlayerView.currentPositiingController.stream,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? BuildText(
                                text: snapshot.data.toString().padLeft(2, "0"),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white, fontSize: 16))
                            : const BuildText(text: "00:00");
                      }),
                  StreamBuilder(
                      stream: _musicPlayerView.audioDurationController.stream,
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? BuildText(
                                text: snapshot.data.toString().padLeft(2, "0"),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white, fontSize: 16))
                            : const BuildText(text: "0:0");
                      })
                ],
              ),
              SizedBox(height: size.height * 0.1),
              // Image(image: NetworkImage(widget.track.artist.picture),fit: BoxFit.contain,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: const BuildIcon(icon: Icons.repeat),
                    onTap: () {},
                  ),
                  InkWell(
                    child: const BuildIcon(icon: Icons.skip_previous),
                    onTap: () {
                      _musicPlayerView.handlePrevious(context);
                    },
                  ),
                  StreamBuilder<String>(
                      stream: _musicPlayerView.playPauseController.stream,
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == "playing") {
                            return InkWell(
                              child: const BuildIcon(icon: Icons.pause_circle),
                              onTap: () {
                                _musicPlayerView.pauseAudio(context);
                              },
                            );
                          } else if (snapshot.data == "paused") {
                            return InkWell(
                                onTap: () {
                                  _musicPlayerView.playAudio(context);
                                },
                                child:
                                    const BuildIcon(icon: Icons.play_circle));
                          } else {
                            return InkWell(
                                onTap: () {
                                  _musicPlayerView.pauseAudio(context);
                                },
                                child:
                                    const BuildIcon(icon: Icons.pause_circle));
                          }
                        } else {
                          return InkWell(
                            child: const BuildIcon(icon: Icons.play_circle),
                            onTap: () {
                              _musicPlayerView.playAudio(context);
                            },
                          );
                        }
                      })),
                  InkWell(
                    child: const BuildIcon(icon: Icons.skip_next_rounded),
                    onTap: () {
                      _musicPlayerView.handleNextAudio(context);
                    },
                  ),
                  InkWell(
                    child: const BuildIcon(icon: Icons.library_music_rounded),
                    onTap: () {},
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
