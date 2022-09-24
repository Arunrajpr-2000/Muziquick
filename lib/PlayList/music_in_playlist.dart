import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/PlayList/add_song_in_Playlist.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/model/box_class.dart';
import 'package:music_player/model/hivemodel.dart';

import 'package:music_player/widgets/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../open audio/openaudio.dart';

class InsideList extends StatefulWidget {
  String playlistName;

  InsideList({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<InsideList> createState() => _InsideListState();
}

class _InsideListState extends State<InsideList> {
  List<LocalSongs>? playlistSongs = [];

  final box = Boxes.getinstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff091127),
      appBar: AppBar(
        backgroundColor: Color(0xff091127),
        elevation: 10,
        title: Text(
          widget.playlistName,
          maxLines: 1,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: "poppinz",
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Color(0xff091127),
                    // shape: const RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.vertical(
                    //     top: Radius.circular(20),
                    //   ),
                    // ),
                    context: context,
                    builder: (context) {
                      return songadd(
                        playlistName: widget.playlistName,
                      );
                    });
              },
              icon: const Icon(
                Icons.playlist_add,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Color(0xff091127),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, boxes, _) {
                    final playlistSongs = box.get(widget.playlistName)!;
                    return playlistSongs.isEmpty
                        ? SizedBox(
                            child: Center(
                              child: Text(
                                "No songs Here",
                                style: TextStyle(
                                    fontFamily: "poppinz",
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: playlistSongs.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                for (var element in playlistSongs) {
                                  playlistsplay.add(Audio.file(element.uri!,
                                      metas: Metas(
                                        title: element.title,
                                        id: element.id.toString(),
                                        artist: element.artist,
                                      )));
                                }

                                PlayMyAudio(
                                        allsongs: playlistsplay, index: index)
                                    .openAsset(
                                        index: index, audios: playlistsplay);

                                showBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(45),
                                    ),
                                    backgroundColor:
                                        Colors.blueGrey.withOpacity(0.8),
                                    context: context,
                                    builder: (ctx) => MiniPlayer());
                              },
                              child: ListTile(
                                leading: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: QueryArtworkWidget(
                                    id: playlistSongs[index].id!,
                                    type: ArtworkType.AUDIO,
                                    artworkBorder: BorderRadius.circular(15),
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget: Container(
                                      height: 47,
                                      width: 47,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "asset images/ArtMusicMen.jpg.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  playlistSongs[index].title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: "poppinz",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  playlistSongs[index].artist!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: "poppinz",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      playlistSongs.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
