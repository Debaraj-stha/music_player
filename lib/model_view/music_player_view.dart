import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:music_player/utils/utils.dart';

class MusicPlayerView extends GetxController {
  final audioPlayer = AudioPlayer();
  List<String> trackURL = [
    "audios/Alone_-_Color_Out.mp3",
    "audios/Erick_Fill_&amp;_Alwaro_-_You'll_Be_Fine_ft._Crushboys_(Original_Mix)_-_erickfill.mp3",
    "audios/LEEONA_-_LEEONA_-_Do_I.mp3",
    "audios/No_Rest_Or_Endless_Rest_-_Lisofv.mp3",
    "audios/Tab_-_Sake_Bomb_(feat._Jade_Gritty_&amp;_Aurc).mp3",
    "audios/The_Deep_-_Anitek.mp3"
  ];
  StreamController<String> playPauseController = StreamController<String>();
  StreamController durationController = StreamController();
  StreamController audioDurationController = StreamController();
  StreamController currentPositiingController = StreamController();
  RxInt currentAudio = 0.obs;
  changePlayerState(BuildContext context) {
    audioPlayer.onPlayerStateChanged.listen(
      (it) {
        switch (it) {
          case PlayerState.playing:
            playPauseController.add("playing");
            print("playing");
            break;
          case PlayerState.completed:
            playPauseController.add("completed");
            audioDurationController.add(0.0);
            durationController.add(0.0);
            currentPositiingController.add(0.0);
            handleNextAudio(context);

            break;
          case PlayerState.paused:
            playPauseController.add("paused");
            break;
          default:
            print(it.toString());
            break;
        }
      },
    );
  }

  Future<void> playAudio(BuildContext context) async {
    print('Attempting to play audio...');
    await audioPlayer.play(AssetSource(trackURL[currentAudio.value]));

    changePlayerState(context);
    print('Audio player volume: ${audioPlayer.volume}');
  }

  Future<void> pauseAudio(BuildContext context) async {
    await audioPlayer.pause();
    changePlayerState(context);
  }

  handleDurationChange() async {
    final currentPosition = await audioPlayer.getCurrentPosition();
    print("d $currentPosition");
    final audioDuration = await audioPlayer.getDuration();
    final x = currentPosition!.inMilliseconds / audioDuration!.inMilliseconds;
    audioDurationController.add(audioDuration.inMinutes.toDouble());
    currentPositiingController.add(currentPosition.inSeconds);
    durationController.add(x.toDouble());
    audioPlayer.onDurationChanged.listen((event) {
      print("x${event.inSeconds}");
      // audioDurationController.add(event.inMinutes);
      // durationController.add(event);
    });
  }

  handleNextAudio(BuildContext context) {
    if (currentAudio.value < trackURL.length - 1) {
      currentAudio.value += 1;
      pauseAudio(context);
      playAudio(context);
    } else {
      Utils().showSnackbar("No more songs", context);
    }
  }

  handlePrevious(BuildContext context) {
    if (currentAudio.value > 0) {
      currentAudio.value -= 1;
      pauseAudio(context);
      playAudio(context);
    } else {
      Utils().showSnackbar("No more songs", context);
    }
  }

  seekToPosition(DragUpdateDetails detailks, BuildContext context) async {
    final newPosition =
        (detailks.localPosition.dx / context.size!.width).clamp(0.0, 1.0);
    Duration seekTo = Duration(
        milliseconds:
            ((await audioPlayer.getDuration())! * newPosition).inMilliseconds);
    audioPlayer.seek(seekTo);
    durationController.add(newPosition.toDouble());
  }
}
