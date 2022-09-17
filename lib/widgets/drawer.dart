import 'package:flutter/material.dart';
import 'package:music_player/screens/favourite.dart';
import 'package:music_player/screens/home.dart';
import 'package:music_player/screens/playlist.dart';
import 'package:music_player/screens/recent.dart';
import 'package:music_player/screens/settings.dart';
import 'package:music_player/tabs/favourite_tab.dart';
import 'package:music_player/tabs/playlist_tab.dart';

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
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Color(0xff091127)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'asset images/SAVE_20220829_222402-removebg.png',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      'Muzi',
                      style: TextStyle(
                          color: Color(0xffE71F1F),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      'Quick',
                      style: TextStyle(
                          color: Color(0xff24BBBB),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )
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
            //   leading: const Icon(Icons.star, color: Colors.white),
            //   title: const Text(
            //     'Favourites',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   onTap: () {
            //     Navigator.of(context).pushReplacement(MaterialPageRoute(
            //         builder: (_) => ScreenHome(
            //               audiosongs: audiosongs,
            //             )));
            //   },
            // ),

            ListTile(
              leading: const Icon(Icons.music_note, color: Colors.white),
              title: const Text(
                'Most Played',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (_) => Playlist_tab()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.recent_actors, color: Colors.white),
              title: const Text(
                'Recents',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx1) => ScreenRecents()));
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
            ListTile(
              leading: Icon(Icons.error_outline, color: Colors.white),
              title: Text(
                'About',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Column(
                          children: [
                            const Text('MuziQuick '),
                            Text('Version 1.0.0')
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Okey')),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
