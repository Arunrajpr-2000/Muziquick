// import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
// import 'package:music_player/functions/functions.dart';

import 'package:music_player/screens/home.dart';
import 'package:music_player/screens/nowplay.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/functions.dart';

class MiniPlayer extends StatefulWidget {
  int index;
  List<Audio> audiosongs = [];

  MiniPlayer({Key? key, required this.index, required this.audiosongs})
      : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AssetsAudioPlayer assetsaudioplayer = AssetsAudioPlayer.withId('0');
  bool prevvisible = true;
  bool nxtvisible = true;

  buttondesable() {
    if (widget.index == 0) {
      prevvisible = false;
    } else {
      prevvisible = true;
    }

    if (widget.index == audiosongs.length - 1) {
      nxtvisible = false;
    } else {
      nxtvisible = true;
    }
  }

  @override
  void initState() {
    buttondesable();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return assetsaudioplayer.builderCurrent(
        builder: (context, Playing? playing) {
      final myAudio = find(audiosongs, playing!.audio.assetAudioPath);
      // int? index;
      return SizedBox(
          // color: Colors.white.withOpacity(0.1),
          height: size.height * 0.12,
          child: ListTile(
            tileColor: Color(0xff16213E),
            // Color(0xff091127),
            contentPadding: EdgeInsets.only(bottom: 15, left: 5, top: 10),
            // contentPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            leading: QueryArtworkWidget(
              id: int.parse(myAudio.metas.id!),
              artworkFit: BoxFit.fill,
              artworkBorder: BorderRadius.circular(30),
              // artworkWidth: 50,
              // artworkHeight: 50,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: ClipOval(
                child: Image.asset(
                  'asset images/ArtMusicMen.jpg.jpg',
                  // width: size.width * 0.1,
                  // height: size.height * 0.1,
                  // width: size.width * 0.15,
                  // height: size.height * 0.2,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ScreenNowplay(index: widget.index, myaudiosong: audiosongs),
              ));
            },
            title: Marquee(
              text: myAudio.metas.title.toString(),
              pauseAfterRound: const Duration(seconds: 3),
              velocity: 30,
              blankSpace: 50,
              style: TextStyle(
                  fontFamily: "poppinz",
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            // subtitle: Text(
            //   myAudio.metas.artist.toString(),
            //   style: TextStyle(
            //       fontFamily: "poppinz",
            //       color: Colors.white,
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold),
            // ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // setState(() {

                // }),

                prevvisible
                    ? Visibility(
                        visible: prevvisible,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.index = widget.index + 1;
                                if (widget.index != audiosongs.length - 1) {
                                  nxtvisible = true;
                                }
                                assetsAudioPlayer.previous();
                              });
                            },
                            icon: Icon(
                              Icons.skip_previous_sharp,
                              color: Colors.white,
                              size: 30,
                            )),
                      )
                    : SizedBox(
                        width: 30,
                      ),
                PlayerBuilder.isPlaying(
                    player: assetsAudioPlayer,
                    builder: (context, isPlaying) {
                      return GestureDetector(
                        onTap: () async {
                          await assetsAudioPlayer.playOrPause();
                        },
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      );
                    }),
                nxtvisible
                    ? Visibility(
                        visible: nxtvisible,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.index = widget.index + 1;
                                if (widget.index > 0) {
                                  prevvisible = true;
                                }
                                assetsAudioPlayer.next();
                              });
                            },
                            icon: Icon(
                              Icons.skip_next_sharp,
                              color: Colors.white,
                              size: 30,
                            )),
                      )
                    : SizedBox(
                        width: 30,
                      )
              ],
            ),
          )

          // child: Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          // Container(
          //   width: size.width * 0.23,
          //   height: size.height * 0.2,
          //   child: QueryArtworkWidget(
          //     id: int.parse(myAudio.metas.id!),
          //     type: ArtworkType.AUDIO,
          //     nullArtworkWidget: ClipOval(
          //       child: Image.asset(
          //         'asset images/ArtMusicMen.jpg.jpg',
          //         width: size.width * 0.23,
          //         height: size.height * 0.2,
          //         // width: size.width * 0.51,
          //         // height: size.height * 0.21,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          //     GestureDetector(
          //       onTap: () {
          //         Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) => ScreenNowplay(
          //               index: widget.index, myaudiosong: audiosongs),
          //         ));
          //       },
          //       child: Container(
          //         width: size.width * 0.4,
          //         child: Marquee(
          //           text: myAudio.metas.title.toString(),
          //           pauseAfterRound: const Duration(seconds: 3),
          //           velocity: 30,
          //           blankSpace: 50,
          //           style: TextStyle(
          //               fontFamily: "poppinz",
          //               color: Colors.white,
          //               fontSize: 20,
          //               fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //     ),
          //     Row(
          //       children: [
          //         // setState(() {

          //         // }),

          //         prevvisible
          //             ? Visibility(
          //                 visible: prevvisible,
          //                 child: IconButton(
          //                     onPressed: () {
          //                       setState(() {
          //                         widget.index = widget.index + 1;
          //                         if (widget.index != audiosongs.length - 1) {
          //                           nxtvisible = true;
          //                         }
          //                         assetsAudioPlayer.previous();
          //                       });
          //                     },
          //                     icon: Icon(
          //                       Icons.skip_previous_sharp,
          //                       color: Colors.white,
          //                       size: 30,
          //                     )),
          //               )
          //             : SizedBox(
          //                 width: 10,
          //               ),
          //         PlayerBuilder.isPlaying(
          //             player: assetsAudioPlayer,
          //             builder: (context, isPlaying) {
          //               return GestureDetector(
          //                 onTap: () async {
          //                   await assetsAudioPlayer.playOrPause();
          //                 },
          //                 child: Icon(
          //                   isPlaying ? Icons.pause : Icons.play_arrow,
          //                   color: Colors.white,
          //                   size: 30,
          //                 ),
          //               );
          //             }),
          //         nxtvisible
          //             ? Visibility(
          //                 visible: nxtvisible,
          //                 child: IconButton(
          //                     onPressed: () {
          //                       setState(() {
          //                         widget.index = widget.index + 1;
          //                         if (widget.index > 0) {
          //                           prevvisible = true;
          //                         }
          //                         assetsAudioPlayer.next();
          //                       });
          //                     },
          //                     icon: Icon(
          //                       Icons.skip_next_sharp,
          //                       color: Colors.white,
          //                       size: 30,
          //                     )),
          //               )
          //             : SizedBox(
          //                 width: 50,
          //               )
          //       ],
          //     )
          //   ],
          // ),
          );
    });
  }
}
