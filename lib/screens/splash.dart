import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/box_class.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/screens/home.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../functions/functions.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({Key? key}) : super(key: key);

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  // final box = Boxes.getinstance();

  // final _audioquery = OnAudioQuery();
  // List<Audio> audiosongs = [];
  // List<LocalSongs> mappedsongs = [];
  // List<LocalSongs> databaseSong = [];

  @override
  void initState() {
    fetchingsongs();
    gotohome();

    // gotohome();
    super.initState();
  }

  // void requestPermission() {
  //   Permission.storage.request();
  // }
  // List<SongModel> allSongs = [];

  // fetchingsongs() async {
  //   bool ispermission = await _audioquery.permissionsStatus();
  //   if (!ispermission) {
  //     await _audioquery.permissionsRequest();
  //   }
  //   allSongs = await _audioquery.querySongs();
  //   mappedsongs = allSongs
  //       .map((e) => LocalSongs(
  //           title: e.title,
  //           artist: e.artist,
  //           id: e.id,
  //           duration: e.duration,
  //           uri: e.uri!))
  //       .toList();

  //   await box.put("musics", mappedsongs);
  //   databaseSong = box.get("musics") as List<LocalSongs>;

  //   databaseSong.forEach((element) {
  //     audiosongs.add(Audio.file(element.uri.toString(),
  //         metas: Metas(
  //             title: element.title,
  //             id: element.id.toString(),
  //             artist: element.artist)));
  //   });
  //   gotohome();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff091127),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'asset images/SAVE_20220829_222402-removebg.png',
                  width: 150,
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Muzi',
                      style: TextStyle(
                          color: Color(0xffE71F1F),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Text(
                      'Quick',
                      style: TextStyle(
                          color: Color(0xff24BBBB),
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }

  Future<void> gotohome() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => ScreenHome(audiosongs: audiosongs),
      ),
    );
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => ScreenHome(audiosongs: audiosongs),
    //   ),
    //   (route) => false,
    // );
  }
}
