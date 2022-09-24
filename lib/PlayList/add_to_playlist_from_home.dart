import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/functions/functions.dart';

import 'package:music_player/model/box_class.dart';

import '../model/hivemodel.dart';

class PlaylistNow extends StatelessWidget {
  PlaylistNow({Key? key, required this.song}) : super(key: key);
  Audio song;

  @override
  Widget build(BuildContext context) {
    final box = Boxes.getinstance();
    playlists = box.keys.toList();
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff091127),
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListView(
        //  physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: ListTile(
              onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xff091127),
                  title: Text("Add new Playlist",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "poppinz",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  content: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                      ),
                      hintStyle: const TextStyle(color: Colors.white),
                      hintText: 'Create a Playlist',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.orange,
                          width: 2.0,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      playlistName = value;
                    },
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          List<LocalSongs> librayry = [];
                          List? excistingName = [];
                          if (playlists.isNotEmpty) {
                            excistingName = playlists
                                .where((element) => element == playlistName)
                                .toList();
                          }

                          if (playlistName != '' && excistingName.isEmpty) {
                            box.put(playlistName, librayry);
                            Navigator.of(context).pop();
                            //setState(() {
                            playlists = box.keys.toList();
                            //});
                          } else {
                            Navigator.of(context).pop();
                          }

                          // controller.clear();
                        },
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              fontFamily: "poppinz",
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              leading: Icon(
                Icons.add,
                color: Colors.white,
                size: 23,
              ),
              title: Text(
                "Create Playlist",
                style: TextStyle(
                    fontFamily: "poppinz",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16),
              ),
            ),
          ),
          ...playlists
              .map((e) => e != "musics"
                  ? libraryList(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Container(
                        height: 75,
                        width: 95,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          // color: Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: ListTile(
                            onTap: () async {
                              playlistSongs = box.get(e);
                              List existingSongs = [];
                              existingSongs = playlistSongs!
                                  .where((element) =>
                                      element.id.toString() ==
                                      song.metas.id.toString())
                                  .toList();

                              if (existingSongs.isEmpty) {
                                final songs =
                                    box.get("musics") as List<LocalSongs>;
                                final temp = songs.firstWhere((element) =>
                                    element.id.toString() ==
                                    song.metas.id.toString());
                                playlistSongs?.add(temp);

                                await box.put(e, playlistSongs!);

                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            leading: Container(
                              height: 45,
                              width: 45,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 154, 142, 142),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Icon(
                                Icons.queue,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              e.toString(),
                              style: TextStyle(
                                  fontFamily: "poppinz",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ))
                  : Container())
              .toList()
        ],
      ),
    );
  }

  Padding libraryList({required child}) {
    return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: child);
  }
}
