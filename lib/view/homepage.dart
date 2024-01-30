import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/model_view/homeModelView.dart';
import 'package:music_player/resources/appColor.dart';
import 'package:music_player/resources/components/box.dart';
import 'package:music_player/resources/components/buildIcons.dart';
import 'package:music_player/resources/components/buildText.dart';
import 'package:music_player/resources/components/singleMusic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  TabController? _tabController;
  final List<String> _tabs = ['Songs', 'Artists'];
  final HomeModel _homeModel = HomeModel();
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this);
    _homeModel.loadSongs();
    _homeModel.loadTracks();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: SearchBar(
          controller: _searchController,
          elevation: MaterialStateProperty.all<double>(0),
          focusNode: _focusNode,
          trailing: const [Icon(Icons.search)],
          onSubmitted: (value) {},
          hintText: "Search track,playlist...",
          hintStyle: MaterialStateProperty.all<TextStyle>(Theme.of(context)
              .primaryTextTheme
              .bodyMedium!
              .copyWith(color: Colors.black)),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 193, 189, 189)),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyBox(
                    width: size.width * 0.3,
                    colors: const [
                      AppColor.colorYello,
                      AppColor.colorsOrange,
                      AppColor.colorsPurple
                    ],
                    child: BuildText(
                      text: "Favourites",
                      style: Theme.of(context).primaryTextTheme.bodyMedium!,
                    )),
                MyBox(
                  width: size.width * 0.3,
                  colors: const [
                    AppColor.colorYello,
                    AppColor.colorsOrange,
                    AppColor.colorsGreen,
                  ],
                  child: BuildText(
                    text: "Playlist",
                    style: Theme.of(context).primaryTextTheme.bodyMedium!,
                  ),
                ),
                MyBox(
                  width: size.width * 0.3,
                  colors: const [
                    AppColor.colorsOrange,
                    AppColor.colorYello,
                    AppColor.colorsGreen
                  ],
                  child: BuildText(
                    text: "Recent",
                    style: Theme.of(context).primaryTextTheme.bodyMedium!,
                  ),
                ),
              ],
            ),
            TabBar(
                controller: _tabController,
                onTap: (value) {},
                tabs: _tabs
                    .map((e) => Tab(
                          child: Text(e),
                        ))
                    .toList()),
            Row(
              children: [
                InkWell(
                  child: Container(
                    child: const Icon(
                      Icons.shuffle,
                      color: AppColor.colorsPurple,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const BuildText(text: "Suffle Track"),
                const Spacer(),
                const InkWell(
                    child: BuildIcon(
                  icon: Icons.sort,
                  color: Colors.black,
                )),
                const SizedBox(
                  width: 5,
                ),
                const InkWell(
                    child: BuildIcon(
                  icon: Icons.list_sharp,
                  color: Colors.black,
                ))
              ],
            ),
            Expanded(
                child: Obx(
              () => ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _homeModel.song.length,
                  itemBuilder: (context, index) {
                    final track = _homeModel.song[index];
                    return SingleTrack(track: track);
                  }),
            )),
            const Divider(
              thickness: 3,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(child: const Icon(Icons.music_note)),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildText(text: "Music name sss"),
                      BuildText(text: "Artist name")
                    ],
                  ),
                  const Spacer(),
                  const Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.grey,
                        valueColor:
                            AlwaysStoppedAnimation(AppColor.colorsPurple),
                      ),
                      InkWell(
                        child: BuildIcon(
                          icon: Icons.pause_circle,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const BuildIcon(
                          icon: Icons.skip_next,
                          color: Colors.black,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
