// import 'dart:developer';
//import 'dart:io';
// import 'package:just_audio/just_audio.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:music_player/model/box_class.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/tabs/favourite_tab.dart';
import 'package:music_player/tabs/playlist_tab.dart';
import 'package:music_player/widgets/fav.dart';
import 'package:music_player/widgets/miniplayer.dart';
import 'package:music_player/widgets/miniply.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
import 'package:music_player/screens/favourite.dart';
import 'package:music_player/screens/nowplay.dart';
import 'package:music_player/screens/playlist.dart';
import 'package:music_player/screens/settings.dart';
import 'package:music_player/screens/splash.dart';
import 'package:music_player/widgets/drawer.dart';

import '../open audio/openaudio.dart';

class ScreenHome extends StatefulWidget {
  List<Audio> audiosongs = [];
  ScreenHome({Key? key, required this.audiosongs}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  Icon myIcon = const Icon(Icons.search);
  Widget myTitle = const Text('All Songs');
  String searchInput = "";

  final box = Boxes.getinstance();
  // final _audioQuery = OnAudioQuery();

  // List? databasesongs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // databasesongs = box.get('musics') as List<LocalSongs>;
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
                      myIcon = const Icon(
                        Icons.clear,
                        color: Colors.orange,
                      );
                      myTitle = TextField(
                        onChanged: (value) {
                          searchInput = value;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Search here',
                            hintStyle: TextStyle(color: Colors.grey)),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      );
                    } else {
                      setState(() {
                        searchInput = '';
                      });
                      myIcon = const Icon(Icons.search);
                      myTitle = const Text('All Songs');
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
        body: Stack(
          children: [
            TabBarView(
              // controller: controller,
              children: [
                Fav_tab(),
                ListView.builder(
                  itemCount: widget.audiosongs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          PlayMyAudio(index: index, allsongs: widget.audiosongs)
                              .openAsset();

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx1) => ScreenNowplay(
                                    song: widget.audiosongs[index],
                                    myaudiosong: widget.audiosongs,
                                  )));
                        },
                        title: Text(
                          '${widget.audiosongs[index].metas.title.toString()}',
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${widget.audiosongs[index].metas.artist.toString()}',
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: QueryArtworkWidget(
                          id: int.parse(
                              widget.audiosongs[index].metas.id.toString()),
                          type: ArtworkType.AUDIO,
                          //size: 250,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: Colors.white,
                          ),
                        ),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                value: 1,
                                child: Text(
                                  'Add to fav',
                                ),
                              ),
                              const PopupMenuItem(
                                value: 2,
                                child: Text('Add to Plylist'),
                              ),
                            ];
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          onSelected: (value) {
                            if (value == 1) {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (ctx1) => Fav_tab()));
                            } else {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (ctx1) => Playlist_tab()));
                            }
                          },
                        ));
                  },
                ),
                Playlist_tab(),
              ],
            ),
            Positioned(bottom: 5, child: MiniPlayer()),
          ],
        ),
      ),
    );
  }
}
