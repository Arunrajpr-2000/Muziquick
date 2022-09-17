import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class PlayMyAudio {
  final int? index;
  List<Audio> allsongs;

  PlayMyAudio({required this.allsongs, required this.index});
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  openAsset() async {
    await audioPlayer.open(
      Playlist(audios: allsongs, startIndex: index!),
      loopMode: LoopMode.playlist,
      showNotification: false,
      // notificationSettings: NotificationSettings(
      //   customStopIcon: AndroidResDrawable(name: "ic_stop_custom"),
      //   customPauseIcon: AndroidResDrawable(name: "ic_pause_custom"),
      //   customPlayIcon: AndroidResDrawable(name: "ic_play_custom"),
      //   customPrevIcon: AndroidResDrawable(name: "ic_prev_custom"),
      //   customNextIcon: AndroidResDrawable(name: "ic_next_custom"),
      // )
    );
  }
}
