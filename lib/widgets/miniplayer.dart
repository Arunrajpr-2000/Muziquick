import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/screens/home.dart';
import 'package:music_player/screens/nowplay.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../functions/functions.dart';

class MiniPlayer extends StatefulWidget {
  MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  AssetsAudioPlayer assetsaudioplayer = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return assetsaudioplayer.builderCurrent(
        builder: (context, Playing? playing) {
      final myAudio = find(audiosongs, playing!.audio.assetAudioPath);
      int? index;
      return Container(
        // color: Colors.white.withOpacity(0.1),
        height: size.height * 0.12,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width * 0.23,
              height: size.height * 0.2,
              child: QueryArtworkWidget(
                id: int.parse(myAudio.metas.id!),
                type: ArtworkType.AUDIO,
                nullArtworkWidget: ClipOval(
                  child: Image.asset(
                    'asset images/ArtMusicMen.jpg.jpg',
                    width: size.width * 0.23,
                    height: size.height * 0.2,
                    // width: size.width * 0.51,
                    // height: size.height * 0.21,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenNowplay(myaudiosong: audiosongs),
                ));
              },
              child: Container(
                width: size.width * 0.4,
                child: Marquee(
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
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      assetsAudioPlayer.previous();
                    },
                    icon: Icon(
                      Icons.skip_previous_sharp,
                      color: Colors.white,
                      size: 30,
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
                          size: 30,
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
                      size: 30,
                    )),
              ],
            )
          ],
        ),
      );
    });
  }
}
