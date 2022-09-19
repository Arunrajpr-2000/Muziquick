// import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/model/hivemodel.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:music_player/widgets/fav.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class ScreenNowplay extends StatefulWidget {
  Audio? song;
  List<Audio> myaudiosong = [];
  ScreenNowplay({
    song,
    required this.myaudiosong,
    Key? key,
  }) : super(key: key);
  //final SongModel songModel;
  // final AudioPlayer audioPlayer;

  @override
  State<ScreenNowplay> createState() => _ScreenNowplayState();
}

class _ScreenNowplayState extends State<ScreenNowplay> {
  bool _isplaying = true;
  double _currentsliderValue = 20;
  int? index;
  int repeat = 0;

  //final AudioPlayer _audioPlayer = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // playsong();
    assetsAudioPlayer.play();
  }
  // void playsong() {
  //   try {
  //     widget.audioPlayer
  //         .setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri!)));
  //     widget.audioPlayer.play();
  //     _isplaying = true;
  //   } on Exception {
  //     log('Cannot parse song');
  //   }
  // }

  // Audio find(List<Audio> source, String fromPath) {
  //   return source.firstWhere((element) => element.path == fromPath);
  // }

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
        if (playing.audio.assetAudioPath.isEmpty) {
          return Center(
            child: Text('Loading....!!!'),
          );
        } else {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // width: 300,
                width: size.width * 1,
                // width: size.width,
//height: size.height,
                height: size.height * 0.3,

                margin:
                    EdgeInsets.only(left: 80, top: 50, right: 80, bottom: 20),
                child:
                    // ClipRRect(child: Image.asset('asset images/plyscrnImg.jpeg')),
                    QueryArtworkWidget(
                        id: int.parse(myAudio.metas.id!),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipOval(
                          child: Image.asset(
                            'asset images/ArtMusicMen.jpg.jpg',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                        // artworkBorder: BorderRadius.circular(20),
                        ),
              ),
              Text(
                // widget.song.metas.title.toString(),
                myAudio.metas.title.toString(),

                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 24),
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
                height: size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // FavWidget(),
                    likedsongs!
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
                              likedsongs?.add(currentSong);
                              box.put("favorites", likedsongs!);
                              //likedSongs = box.get("favorites");
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
                                likedsongs?.removeWhere((elemet) =>
                                    elemet.id.toString() ==
                                    currentSong.id.toString());
                                box.put("favorites", likedsongs!);
                              });
                            },
                          ),
                    IconButton(
                        onPressed: () {},
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
                  IconButton(
                      onPressed: () {
                        assetsAudioPlayer.previous();
                      },
                      icon: Icon(
                        Icons.skip_previous_sharp,
                        color: Colors.white,
                        size: 35,
                      )),
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
                  IconButton(
                      onPressed: () {
                        setState(() {});
                        assetsAudioPlayer.next();
                      },
                      icon: Icon(
                        Icons.skip_next_sharp,
                        color: Colors.white,
                        size: 35,
                      )),
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
