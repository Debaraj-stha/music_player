import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class MusicPlayerView extends GetxController {
  final audioPlayer = AudioPlayer();
  StreamController<bool> playPauseController = StreamController<bool>();
  Future<void> playAudio(String url) async {
    await audioPlayer.setSource(UrlSource("https://cdns-preview-d.dzcdn.net/stream/c-deda7fa9316d9e9e880d2c6207e92260-10.mp3"));
    await audioPlayer.setVolume(1);
    await audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    playPauseController.add(true);
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
    playPauseController.add(false);
  }
}
