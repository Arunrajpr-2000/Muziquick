import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:music_player/widgets/fav.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/functions.dart';
import '../model/hivemodel.dart';
import '../open audio/openaudio.dart';
import '../screens/nowplay.dart';

class Fav_tab extends StatefulWidget {
  Fav_tab({Key? key}) : super(key: key);

  @override
  State<Fav_tab> createState() => _Fav_tabState();
}

class _Fav_tabState extends State<Fav_tab> {
  List<LocalSongs> databasesong = [];
  List<Audio> playlikedsongs = [];
  List<LocalSongs> likedsongs = [];
  // final box = Boxes.getinstance();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Boxes, _) {
            // final likedSongs = box.get("favorites");

            final likedSongs = box.get("favorites");
            if (likedSongs == null || likedSongs.isEmpty) {
              return Center(
                child: Text(
                  'No Favourites',
                  style: TextStyle(
                      fontFamily: "poppinz",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    for (var element in likedSongs) {
                      PlayLikedSong.add(
                        Audio.file(
                          element.uri!,
                          metas: Metas(
                            title: element.title,
                            id: element.id.toString(),
                            artist: element.artist,
                          ),
                        ),
                      );
                    }
                    PlayMyAudio(allsongs: PlayLikedSong, index: index)
                        .openAsset(index: index, audios: PlayLikedSong);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenNowplay(
                                  // index: index,

                                  myaudiosong: PlayLikedSong,
                                )));
                  },
                  child:
                      // likedSongs == null
                      //     ? Center(
                      //         child: Text(
                      //           'No Favourite songs',
                      //           style: TextStyle(color: Colors.white),
                      //         ),
                      //       )
                      // :
                      ListTile(
                    leading: QueryArtworkWidget(
                        id: likedSongs[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipOval(
                          child: Image.asset(
                            'asset images/ArtMusicMen.jpg.jpg',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          likedSongs.removeAt(index);
                          box.put("favorites", likedSongs);
                        });
                      },
                      icon: Icon(Icons.favorite, color: Colors.red),
                    ),
                    title: Text(
                      likedSongs[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      likedSongs[index].artist == '<unknown>'
                          ? 'unknown Artist'
                          : likedSongs[index].artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                itemCount: likedSongs.length,
              );
            }
          }),
    );
  }
}
