import 'package:flutter/material.dart';

import 'package:music_player/screens/home.dart';

import 'package:music_player/screens/recent.dart';
import 'package:music_player/screens/settings.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../functions/functions.dart';

class ScreenDrawer extends StatefulWidget {
  ScreenDrawer({Key? key}) : super(key: key);

  @override
  State<ScreenDrawer> createState() => _DrawerState();
}

class _DrawerState extends State<ScreenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff091127),
        child: Column(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Color(0xff091127)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'asset images/landscape,-transparent-bg-+-shadow-designify.png',
                      width: 50,
                      height: 50,
                      //fit: BoxFit.contain,
                    ),
                    GradientText("M I X P O D",
                        style: TextStyle(
                            fontFamily: "poppinz",
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                        colors: const [
                          // Color(0xffAAC4FF),
                          // Color.fromARGB(255, 111, 72, 165),
                          Color(0xff1682cb),
                          Color(0xffd9f7f7),
                        ])
                  ],
                )),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (ctx1) => ScreenHome(audiosongs: audiosongs)));
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.favorite, color: Colors.white),
            //   title: const Text(
            //     'Favourites',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pushReplacement(
            //         MaterialPageRoute(builder: (ctx1) => Fav_tab()));
            //   },
            // ),

            // ListTile(
            //   leading: const Icon(Icons.music_note, color: Colors.white),
            //   title: const Text(
            //     'Most Played',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () {
            //     // Navigator.of(context).pushReplacement(
            //     //     MaterialPageRoute(builder: (_) => Playlist_tab()));
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.recent_actors, color: Colors.white),
              title: const Text(
                'Recents',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx1) => screenRecent()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx1) => ScreenSettings()));
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.settings, color: Colors.white),
            //   title: const Text(
            //     'PalyList',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () {
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) => Playlists()));
            //   },
            // ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Version',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '1.0.0',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
