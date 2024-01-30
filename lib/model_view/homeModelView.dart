import 'package:get/get.dart';

import 'package:music_player/repository/model.dart';
import 'package:music_player/repository/songs.dart';
import 'package:music_player/utils/appUrl.dart';
import 'package:music_player/utils/utils.dart';

import '../data/network/network.dart';

class HomeModel extends GetxController {
  final RxList _song = [].obs;

  RxList get song => _song;
  final RxList _mySongs = [].obs;
  RxList get mySongs => _mySongs;
  Future<void> loadSongs() async {
    for (var song in songs) {
      _song.add(Tracks.fromJson(song));
    }
    update();
  }

  Future<void> loadTracks() async {
    final res = await getRequest(AppURL.recomendationURL);
    final tracks=res['tracks'];
    // for(var track in tracks ){
    //   _mySongs.add(Track.fromJson(track));
    // }
    print(tracks);
    Utils.printMessage(res['tracks']);
  }
}
