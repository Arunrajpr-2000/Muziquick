// import 'dart:developer';
//import 'dart:io';
// import 'package:just_audio/just_audio.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/model/box_class.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/tabs/favourite_tab.dart';
import 'package:music_player/tabs/playlist_tab.dart';
import 'package:music_player/widgets/fav.dart';
import 'package:music_player/widgets/miniplayer.dart';

import 'package:on_audio_query/on_audio_query.dart';

// import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:music_player/screens/favourite.dart';
import 'package:music_player/screens/nowplay.dart';
import 'package:music_player/screens/playlist.dart';
import 'package:music_player/screens/settings.dart';
import 'package:music_player/screens/splash.dart';
import 'package:music_player/widgets/drawer.dart';
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
  Widget myTitle = const Text('All Songs');
  String searchInput = "";

  // final _audioQuery = OnAudioQuery();

  // List? databasesongs = [];

  @override
  void initState() {
    // TODO: implement initState
    // likedsongs = box.get('favorites');
    databasesongs = box.get('musics');

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
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xff091127),
        appBar: AppBar(
          backgroundColor: Color(0xff091127),
          title: myTitle,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (myIcon.icon == Icons.search) {
                      myIcon = const Icon(Icons.clear);
                      myTitle = TextField(
                        onChanged: (value) {
                          searchInput = value;
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: 'Search here',
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      );
                    } else {
                      setState(() {
                        searchInput = '';
                      });
                      myIcon = const Icon(Icons.search);
                      myTitle = const Text('All songs');
                    }
                  });
                },
                icon: myIcon),
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
                          borderRadius: BorderRadius.circular(45),
                        ),
                        // elevation: 20,
                        backgroundColor: Colors.blueGrey.withOpacity(0.8),
                        context: context,
                        builder: (ctx) => MiniPlayer());
                    PlayMyAudio(index: index, allsongs: widget.audiosongs)
                        .openAsset(audios: audiosongs, index: index);
                  },
                  title: Text(
                    '${widget.audiosongs[index].metas.title.toString()}',
                    maxLines: 1,
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    widget.audiosongs[index].metas.artist.toString() ==
                            '<unknown>'
                        ? 'unknown'
                        : widget.audiosongs[index].metas.artist.toString(),
                    maxLines: 1,
                    style: TextStyle(color: Colors.white),
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
                                      // ListTile(
                                      //   title:  Text(
                                      //     "Add to Playlist",
                                      //     style: TextStyle(
                                      //         fontFamily: "poppinz",
                                      //         color: Colors.white,
                                      //         fontWeight:
                                      //             FontWeight.bold,
                                      //         fontSize: 18.sp),
                                      //   ),
                                      //   // trailing: const Icon(Icons.add),
                                      //   onTap: () {
                                      //     Navigator.of(context)
                                      //         .pop();
                                      //     showModalBottomSheet(
                                      //         backgroundColor:
                                      //             Colors.grey,
                                      //         shape: const RoundedRectangleBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.vertical(
                                      //                     top: Radius
                                      //                         .circular(
                                      //                             20))),
                                      //         context: context,
                                      //         builder: (context) =>
                                      //             PlaylistNow(
                                      //                 song: widget
                                      //                         .audiosongs[
                                      //                     index]));
                                      //   },
                                      // ),
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

                                                Navigator.of(context).pop();
                                              },
                                            )
                                          : ListTile(
                                              title: Text(
                                                "Remove from Favorites",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () async {
                                                likedsongs!.removeWhere(
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
