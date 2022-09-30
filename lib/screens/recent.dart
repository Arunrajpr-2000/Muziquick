import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:music_player/open%20audio/openaudio.dart';
import 'package:music_player/widgets/drawer.dart';
import 'package:music_player/widgets/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/functions.dart';

class screenRecent extends StatefulWidget {
  screenRecent({Key? key}) : super(key: key);

  @override
  State<screenRecent> createState() => _screenRecentState();
}

class _screenRecentState extends State<screenRecent> {
  List<Audio> recentAudlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff091127),
      appBar: AppBar(
        backgroundColor: Color(0xff091127),
        title: Text('Recently Played'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      drawer: ScreenDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Boxes, _) {
              final recentsongs = box.get("recent");
              if (recentsongs == recentsongs?.isEmpty) {
                return Center(
                  child: Text(
                    'No Recents',
                    style: TextStyle(
                        fontFamily: "poppinz",
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                );
              } else {
                return ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            for (var element in recentsongs!) {
                              recentAudlist.add(
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
                            PlayMyAudio(allsongs: recentAudlist, index: index)
                                .openAsset(index: index, audios: recentAudlist);

                            showBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                // elevation: 20,
                                backgroundColor:
                                    Colors.blueGrey.withOpacity(0.8),
                                context: context,
                                builder: (ctx) => MiniPlayer(
                                      index: index,
                                      audiosongs: recentAudlist,
                                    ));

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ScreenNowplay(
                            //               // index: index,

                            //               myaudiosong: recentlist,
                            //             )));
                          },
                          child: ListTile(
                            leading: QueryArtworkWidget(
                                id: recentsongs![index].id,
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
                                  recentsongs.removeAt(index);
                                  box.put("recent", recentsongs);
                                });
                              },
                              icon:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            title: Text(
                              recentsongs[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              recentsongs[index].artist == '<unknown>'
                                  ? 'unknown Artist'
                                  : recentsongs[index].artist,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    itemCount: recentsongs!.length
                    // <= 11? recentsongs.length :   ,
                    );
              }
            }),
      ),
    );
  }
}
