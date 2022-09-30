import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:music_player/screens/home.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff091127),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "asset images/Premium-Photo-_-Crowd-in-nightclub.jpeg"),
              fit: BoxFit.fill),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "asset images/landscape,-transparent-bg-+-shadow-designify.png"),
                      fit: BoxFit.cover),
                ),

                // child: Image.asset(
                //   'asset images/logopage21.png',
                //   width: 150,
                //   height: 150,
                // ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientText("M I X P O D",
                      style: TextStyle(
                          fontFamily: "poppinz",
                          fontSize: 28,
                          fontWeight: FontWeight.w700),
                      colors: const [
                        // Color(0xff7c4093),
                        // Color(0xffad3d4d),
                        // Color(0xff003d80),
                        Color(0xff1682cb),
                        Color(0xffd9f7f7),
                      ])
                ],
              )
            ]),
      ),
    );
  }

  Future<void> gotohome() async {
    await Future.delayed(Duration(seconds: 3));
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
