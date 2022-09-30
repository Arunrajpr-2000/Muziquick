// import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/PlayList/add_to_playlist_from_home.dart';
// import 'package:just_audio/just_audio.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class ScreenNowplay extends StatefulWidget {
  Audio? song;
  List<Audio> myaudiosong = [];
  int index;
  ScreenNowplay({
    song,
    required this.myaudiosong,
    required this.index,
    Key? key,
  }) : super(key: key);
  //final SongModel songModel;
  // final AudioPlayer audioPlayer;

  @override
  State<ScreenNowplay> createState() => _ScreenNowplayState();
}

class _ScreenNowplayState extends State<ScreenNowplay> {
  // bool _isplaying = true;
  // double _currentsliderValue = 20;
  // int? index;
  int repeat = 0;
  List<dynamic> likedSongS = [];

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

  //final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    buttondesable();
    super.initState();
    databaseSong = box.get('musics') as List<LocalSongs>;

    assetsAudioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff091127),
      appBar: AppBar(
        backgroundColor: Color(0xff091127),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text('Playing Now'),
        centerTitle: true,
      ),
      body: assetsAudioPlayer.builderCurrent(
          builder: (context, Playing? playing) {
        final myAudio = find(widget.myaudiosong, playing!.audio.assetAudioPath);
        final currentSong = databaseSong.firstWhere(
            (element) => element.id.toString() == myAudio.metas.id.toString());
        // likedSongs = box.get("favorites");
        likedSongS = box.get("favorites")!;
        if (playing.audio.assetAudioPath.isEmpty) {
          return Center(
            child: Text('Loading....!!!'),
          );
        } else {
          return Column(
            children: [
              Container(
                width: size.width * 1.5,
                height: size.height * 0.3,
                margin: EdgeInsets.only(left: 80, top: 50, right: 80),
                child:
                    // ClipRRect(child: Image.asset('asset images/plyscrnImg.jpeg')),
                    QueryArtworkWidget(
                  id: int.parse(myAudio.metas.id!),
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: ClipRect(
                    child: Image.asset(
                      'asset images/ArtMusicMen.jpg.jpg',
                      width: size.width * 0.5,
                      height: size.height * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  artworkBorder: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                height: size.height * 0.05,
                width: size.width * 0.7,
                child: Marquee(
                  text: myAudio.metas.title.toString(),
                  pauseAfterRound: Duration(seconds: 3),
                  velocity: 30,
                  blankSpace: 50,
                  style: TextStyle(
                      fontFamily: "poppinz",
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                myAudio.metas.artist.toString() == '<unknown>'
                    ? 'unknown Artist'
                    : myAudio.metas.artist.toString(),
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              SizedBox(
                height: size.height * 0.09,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // FavWidget(),
                    likedSongS
                            .where((element) =>
                                element.id.toString() ==
                                currentSong.id.toString())
                            .isEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.favorite_outline,
                              size: 27,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              likedSongS.add(currentSong);
                              box.put("favorites", likedSongS);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Added to Favourites",
                                  style: TextStyle(
                                    fontFamily: "poppinz",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Colors.orange,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ));
                              // likedSongs = box.get("favorites");
                              setState(() {});
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.favorite,
                              size: 27,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              setState(() {
                                likedSongS.removeWhere((elemet) =>
                                    elemet.id.toString() ==
                                    currentSong.id.toString());
                                box.put("favorites", likedSongS);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Removed From Favourites",
                                  style: TextStyle(
                                    fontFamily: "poppinz",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Colors.orange,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ));
                            },
                          ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              context: context,
                              builder: (context) => PlaylistNow(song: myAudio));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Added to Playlist",
                              style: TextStyle(
                                fontFamily: "poppinz",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: Colors.orange,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ));
                        },
                        icon: Icon(
                          Icons.playlist_add,
                          color: Colors.white,
                          size: 35,
                        ))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: assetsAudioPlayer.builderRealtimePlayingInfos(
                      builder: (context, infos) {
                    Duration currentposition = infos.currentPosition;
                    Duration totalduration = infos.duration;
                    return ProgressBar(
                        timeLabelTextStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                        thumbColor: Colors.white,
                        baseBarColor: Colors.grey,
                        progressBarColor: Colors.red,
                        bufferedBarColor: Colors.red,
                        thumbRadius: 10,
                        barHeight: 4,
                        progress: currentposition,
                        total: totalduration,
                        onSeek: ((to) {
                          assetsAudioPlayer.seek(to);
                        }));
                  })),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          assetsAudioPlayer.toggleShuffle();
                        });
                      },
                      icon: assetsAudioPlayer.isShuffling.value
                          ? Icon(
                              Icons.shuffle_on_outlined,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.shuffle,
                              color: Colors.white,
                            )),
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
                          width: 50,
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
                            size: 35,
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
                          width: 50,
                        ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (repeat % 2 == 0) {
                            assetsAudioPlayer.setLoopMode(LoopMode.single);
                            repeat++;
                          } else {
                            assetsAudioPlayer.setLoopMode(LoopMode.none);
                            repeat++;
                          }
                        });
                      },
                      icon: repeat % 2 == 0
                          ? Icon(
                              Icons.repeat,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.repeat_on_outlined,
                              color: Colors.white,
                            ))
                ],
              )
            ],
          );
        }
      }),
    );
  }
}
