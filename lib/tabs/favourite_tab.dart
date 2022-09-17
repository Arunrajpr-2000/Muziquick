import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/model/box_class.dart';
import 'package:music_player/widgets/fav.dart';

import '../functions/functions.dart';
import '../model/hivemodel.dart';

class Fav_tab extends StatefulWidget {
  Fav_tab({Key? key}) : super(key: key);

  @override
  State<Fav_tab> createState() => _Fav_tabState();
}

class _Fav_tabState extends State<Fav_tab> {
  // List<LocalSongs> databasesong = [];
  // List<Audio> playlikedsongs = [];
  // List<LocalSongs> likedsongs = [];
  // final box = Boxes.getinstance();

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.only(top: 10),
    //   child: ValueListenableBuilder(
    //       valueListenable: box.listenable(),
    //       builder: (context, Boxes, _) {
    //         final likedSongs = box.get("favorites");
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (ctx1) => ScreenNowplay(
            //       songModel: item.data![index],
            //     )));
          },
          title: Text(
            'Hope',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'xxx tentaction',
            style: TextStyle(color: Colors.white),
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                'asset images/xxxtent.jpg',
                width: 55,
                height: 55,
                fit: BoxFit.cover,
              ),
            ),
          ),
          trailing: FavWidget(),
        );
      },
      itemCount: 5,
    );
    // }),
    //  );
  }
}
