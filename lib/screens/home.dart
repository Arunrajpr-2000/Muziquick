import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/screens/search.dart';
import 'package:music_player/tabs/favourite_tab.dart';
import 'package:music_player/tabs/playlist_tab.dart';
import 'package:music_player/PlayList/add_to_playlist_from_home.dart';

import 'package:music_player/widgets/miniplayer.dart';

import 'package:on_audio_query/on_audio_query.dart';

// import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';

import 'package:music_player/widgets/drawer.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../functions/functions.dart';

import '../open audio/openaudio.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key, required this.audiosongs}) : super(key: key);
  List<Audio> audiosongs = [];
  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  Icon myIcon = const Icon(Icons.search);
  // Widget myField = const Text('Musics');
  // Widget myField = const Text('Student Data');
  // Widget myTitle = const Text('ALL SONGS');
  //String search = "";

  // final _audioQuery = OnAudioQuery();

  // List? databasesongs = [];
  List<dynamic>? likedsongs = [];

  List<dynamic>? recentsongsdy = [];
  List<dynamic> recents = [];

  @override
  void initState() {
    // TODO: implement initState
    // likedsongs = box.get('favorites');
    databasesongs = box.get('musics');
    likedsongs = box.get("favorites");

    super.initState();
  }

  //final AudioPlayer _audioPlayer = AudioPlayer();

  // playSong(String? uri) {
  //   try {
  //     _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
  //   } on Exception {
  //     log('Error parsing song');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // List<Audio> searchResult = audiosongs
    //     .where((element) => element.metas.title!.toLowerCase().startsWith(
    //           search.toLowerCase(),
    //         ))
    //     .toList();
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: ScaffoldGradientBackground(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            // Color.fromARGB(255, 20, 30, 75),
            // Color(0xff113855),
            // Color(0xff760181),
            Color(0xff091127),
            Color(0xff091127),
            // Colors.black

            // Color(0xff9d6ff3),
            // Color(0xff8095fe),
            // Color(0xffc35055),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff091127),
          title: GradientText("MIX POD",
              style: TextStyle(
                  fontFamily: "poppinz",
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
              colors: const [
                Color(0xff1682cb),
                Color(0xffd9f7f7),
              ]),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(searchsong: audiosongs)));
                },
                icon: Icon(Icons.search))
          ],
          bottom: const TabBar(
            indicatorColor: Colors.red,
            // controller: controller,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.favorite),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.library_music),
              ),
            ],
          ),
        ),
        drawer: ScreenDrawer(),
        body: TabBarView(
          // controller: controller,
          children: [
            Fav_tab(),
            ListView.builder(
              itemCount: widget.audiosongs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    showBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        // elevation: 20,
                        // backgroundColor: Colors.blueGrey.withOpacity(0.8),
                        backgroundColor: Colors.blue,
                        context: context,
                        builder: (ctx) => MiniPlayer(
                              index: index,
                              audiosongs: audiosongs,
                            ));

                    PlayMyAudio(index: index, allsongs: widget.audiosongs)
                        .openAsset(audios: audiosongs, index: index);
                    // Recent.AddToRecent(songId: audiosongs[index].metas.id!);

                    if (recents.length < 10) {
                      final songs = box.get("musics") as List<LocalSongs>;
                      final temp = songs.firstWhere((element) =>
                          element.id.toString() ==
                          widget.audiosongs[index].metas.id.toString());
                      recents = recentsongsdy!;
                      recents.add(temp);
                      box.put("recent", recents);
                    } else {
                      recents.removeAt(0);
                      box.put("recent", recents);
                    }

                    // recents = box.get('recent')!;
                    // final isinrecent = recents
                    //     .where(((element) =>
                    //         element.id.toString() ==
                    //         databaseSong[index].id.toString()))
                    //     .toList();
                    // if (isinrecent.isEmpty) {
                    //   recents.add(databaseSong[index]);
                    //   recents = recents.reversed.toList();
                    //   if (recents.length >= 5) {
                    //     recents.removeLast();
                    //   }
                    //   recents = recents.reversed.toList();
                    //   box.put('recent', recents);
                    // }
                  },
                  title: Text(
                    '${widget.audiosongs[index].metas.title.toString()}',
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "poppinz",
                        fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    widget.audiosongs[index].metas.artist.toString() ==
                            '<unknown>'
                        ? 'unknown '
                        : widget.audiosongs[index].metas.artist.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "poppinz",
                        fontWeight: FontWeight.w300),
                  ),
                  leading: QueryArtworkWidget(
                    id: int.parse(widget.audiosongs[index].metas.id.toString()),
                    type: ArtworkType.AUDIO,
                    //size: 250,
                    nullArtworkWidget: ClipOval(
                      child: Image.asset(
                        'asset images/ArtMusicMen.jpg.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // likedsongs = box.get("favorites");
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xff091127),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Add To PlayList--->
                                      ListTile(
                                        title: Text(
                                          "Add to Playlist",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "poppinz",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Color(0xff091127),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      20))),
                                              context: context,
                                              builder: (context) => PlaylistNow(
                                                  song: widget
                                                      .audiosongs[index]));
                                        },
                                      ),
                                      //ADD TO FAVOURITES----->
                                      likedsongs!
                                              .where((element) =>
                                                  element.id.toString() ==
                                                  databasesongs![index]
                                                      .id
                                                      .toString())
                                              .isEmpty
                                          ? ListTile(
                                              title: const Text(
                                                  "Add to Favorites",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18)),
                                              onTap: () async {
                                                final songs = box.get("musics")
                                                    as List<LocalSongs>;
                                                final temp = songs.firstWhere(
                                                    (element) =>
                                                        element.id.toString() ==
                                                        widget.audiosongs[index]
                                                            .metas.id
                                                            .toString());
                                                favorites = likedsongs!;
                                                favorites.add(temp);
                                                box.put("favorites", favorites);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    "Added to Favourites",
                                                    style: TextStyle(
                                                      fontFamily: "poppinz",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Colors.orange,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ));

                                                Navigator.of(context).pop();
                                              },
                                            )
                                          : ListTile(
                                              title: Text(
                                                "Remove from Favorites",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: "poppinz",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () async {
                                                likedsongs?.removeWhere(
                                                    (elemet) =>
                                                        elemet.id.toString() ==
                                                        databasesongs![index]
                                                            .id
                                                            .toString());
                                                await box.put(
                                                    "favorites", likedsongs!);
                                                setState(() {});

                                                Navigator.of(context).pop();
                                              },
                                            ),
                                    ]),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            Playlist_tab(),
          ],
        ),
      ),
    );
  }
}
