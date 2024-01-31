import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:music_player/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  StreamController<String> songNameController = StreamController<String>();
  StreamController<bool> isPlayingController = StreamController<bool>();
  Stream<String>?stream;

  final _sharedPreference = SharedPreferences.getInstance();
  final String _key = "last_track";
  final String _lastSongPositionKey = "song_position";
  final String playingPause = "playing_pause";
  final String currenntPosition = "currennt_position";
  Timer? timer;
  RxInt currentAudio = 0.obs;
  changePlayerState(BuildContext context) {
    audioPlayer.onPlayerStateChanged.listen(
      (it) {
        switch (it) {
          case PlayerState.playing:
            playPauseController.add("playing");

            break;
          case PlayerState.completed:
            playPauseController.add("completed");
            audioDurationController.add(0.0);
            durationController.add(0.0);
            currentPositiingController.add(0.0);
            songNameController.add("");

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
    Utils.printMessage('Attempting to play audio...');
    int lastPlayedTrack = await getLastPlayedTrack();
    int audioToPlay = lastPlayedTrack ?? currentAudio.value;
    await audioPlayer.play(AssetSource(trackURL[audioToPlay]));
    String songName = trackURL[audioToPlay].split("/").last;
    songNameController.add(songName);
    playPauseController.add("playing");
    await saveLastPlayedTrack(audioToPlay);
    changePlayerState(context);
    handleDurationChange();
    double trackCurrentPosition = await getCurrentPosition();

    audioPlayer.seek(trackCurrentPosition.seconds);
    setIsPlayingPause(true);
    Utils.printMessage('Audio player volume: ${audioPlayer.volume}');
  }

  Future<void> pauseAudio(BuildContext context) async {
    await audioPlayer.pause();
    changePlayerState(context);
    handleDurationChange();

    setIsPlayingPause(false);
  }

  handleDurationChange() async {
    double songLastPositon = await getLastSongPosition();
    double trackCurrentPosition = await getCurrentPosition();
    final currentPosition =
        await audioPlayer.getCurrentPosition() ?? trackCurrentPosition.seconds;
    print("song last position $songLastPositon");
    durationController.add(songLastPositon);

    Utils.printMessage("trackCurrentPosition $trackCurrentPosition");

    Utils.printMessage("currennt position $currentPosition");
    final audioDuration = await audioPlayer.getDuration();
    final x = audioDuration != null
        ? currentPosition.inMilliseconds / audioDuration.inMilliseconds
        : songLastPositon;
    setCurrentPosition(currentPosition.inSeconds.toDouble());
    currentPositiingController.add(currentPosition.inSeconds);
    if (audioDuration != null) {
      audioDurationController.add(audioDuration.inMinutes.toDouble());
    }
    setLastSongPosition(x);
    setLastSongPosition(x.toDouble());
    audioPlayer.onDurationChanged.listen((event) {
      Utils.printMessage("x${event.inSeconds}");
    });
  }

  handleNextAudio(BuildContext context) {
    if (currentAudio.value < trackURL.length - 1) {
      currentAudio.value += 1;
      pauseAudio(context);
      saveLastPlayedTrack(currentAudio.value);
      playAudio(context);
      changePlayerState(context);
    } else {
      Utils().showSnackbar("No more songs", context);
    }
  }

  handlePrevious(BuildContext context) {
    if (currentAudio.value > 0) {
      currentAudio.value -= 1;
      pauseAudio(context);
      saveLastPlayedTrack(currentAudio.value);
      playAudio(context);
      changePlayerState(context);
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

  saveLastPlayedTrack(int value) async {
    final sp = await _sharedPreference;
    await sp.setInt(_key, value);
  }

  Future<int> getLastPlayedTrack() async {
    final sp = await _sharedPreference;
    int value = sp.getInt(_key) ?? 0;
    return value;
  }

  getSongName() async {
    final sp = await _sharedPreference;
    int val = sp.getInt(_key) ?? 0;
    String songName = trackURL[val].split("/").last;
    songNameController.add(songName);
  }

  Future<void> setLastSongPosition(double value) async {
    final sp = await _sharedPreference;
    sp.setDouble(_lastSongPositionKey, value);
  }

  Future<double> getLastSongPosition() async {
    final sp = await _sharedPreference;
    double? lastSongPosition = sp.getDouble(_lastSongPositionKey);

    durationController.add(lastSongPosition);
    return lastSongPosition!;
  }

  Future<void> setIsPlayingPause(bool value) async {
    final sp = await _sharedPreference;
    sp.setBool(playingPause, value);
  }

  Future<void> getPlayingPause() async {
    final sp = await _sharedPreference;
    bool isPlaying = sp.getBool(playingPause) ?? false;
    isPlayingController.add(isPlaying);
  }

  Future<void> setCurrentPosition(double value) async {
    final sp = await _sharedPreference;
    sp.setDouble(currenntPosition, value);
  }

  Future<double> getCurrentPosition() async {
    final sp = await _sharedPreference;
    double currentPositionValue = sp.getDouble(currenntPosition) ?? 0;
    return currentPositionValue;
  }
  initStream(){
    stream=playPauseController.stream.asBroadcastStream();
  }
}
