import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:music_player/screens/settings.dart';

class PlayMyAudio {
  final int index;
  List<Audio> allsongs;

  PlayMyAudio({required this.allsongs, required this.index});
  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  openAsset({List<Audio>? audios, required int index}) async {
    await audioPlayer.open(
      Playlist(audios: allsongs, startIndex: index),
      loopMode: LoopMode.playlist,
      showNotification: temp,
    );
  }
}
