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
              const LinearProgressIndicator(
                value: 0.6,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation(Colors.white),
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
                    onTap: () {},
                  ),
                
                   InkWell(
                    child:StreamBuilder<bool>(stream: _musicPlayerView.playPauseController.stream, builder: ((context, snapshot) {
                  if(snapshot.hasData){
                    if(snapshot.data==true){
                      return  const BuildIcon(icon: Icons.play_circle);
                    }
                    else{
                    
                    return  const BuildIcon(icon: Icons.play_circle);
                  
                    }
                  }
                  else{
                     return  const BuildIcon(icon: Icons.play_circle);
                
                  }
                 
                })),
                     onTap: () {
                      _musicPlayerView.playAudio(widget.track.link);
                    },
                  ),
                  InkWell(
                    child: const BuildIcon(icon: Icons.skip_next_rounded),
                    onTap: () {},
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
