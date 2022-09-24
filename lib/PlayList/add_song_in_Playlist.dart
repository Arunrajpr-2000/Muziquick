import 'package:flutter/material.dart';
import 'package:music_player/functions/functions.dart';

import 'package:music_player/model/hivemodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/box_class.dart';

class songadd extends StatefulWidget {
  String playlistName;
  songadd({Key? key, required this.playlistName}) : super(key: key);

  @override
  _buildSheetState createState() => _buildSheetState();
}

class _buildSheetState extends State<songadd> {
  final box = Boxes.getinstance();

  @override
  void initState() {
    super.initState();
    getSongs();
  }

  getSongs() {
    databaseSong = box.get("musics") as List<LocalSongs>;
    playlistSongmodel = box.get(widget.playlistName)!.cast<LocalSongs>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff091127),
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5),
        child: ListView.builder(
          itemCount: databaseSong.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Container(
                  height: 45,
                  width: 45,
                  child: QueryArtworkWidget(
                    id: databaseSong[index].id!,
                    type: ArtworkType.AUDIO,
                    artworkBorder: BorderRadius.circular(15),
                    artworkFit: BoxFit.cover,
                    nullArtworkWidget: Container(
                      height: 45,
                      width: 45,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: AssetImage("asset images/ArtMusicMen.jpg.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  databaseSong[index].title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "poppinz",
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 15),
                ),
                trailing: playlistSongmodel
                        .where((element) =>
                            element.id.toString() ==
                            databaseSong[index].id.toString())
                        .isEmpty
                    ? IconButton(
                        onPressed: () async {
                          playlistSongmodel.add(databaseSong[index]);
                          await box.put(widget.playlistName, playlistSongmodel);
                          //box.get(widget.playlistName);

                          setState(() {
                            // playlistSongs =
                            //     box.get(widget.playlistName)!.cast<Songs>();
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ))
                    : IconButton(
                        onPressed: () async {
                          // await box.put(widget.playlistName, playlistSongs);

                          playlistSongmodel.removeWhere((elemet) =>
                              elemet.id.toString() ==
                              databaseSong[index].id.toString());

                          await box.put(widget.playlistName, playlistSongmodel);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        )),
              ),
            );
          },
        ));
  }
}
