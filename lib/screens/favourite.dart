import 'package:flutter/material.dart';

import 'package:music_player/screens/nowplay.dart';
import 'package:music_player/widgets/drawer.dart';
import 'package:music_player/widgets/fav.dart';

class ScreenFavourite extends StatefulWidget {
  ScreenFavourite({Key? key}) : super(key: key);

  @override
  State<ScreenFavourite> createState() => _ScreenFavouriteState();
}

class _ScreenFavouriteState extends State<ScreenFavourite> {
  bool _isfavorite = false;
  //final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff091127),
      appBar: AppBar(
        backgroundColor: Color(0xff091127),
        title: Text('Favourites'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      drawer: ScreenDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
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
        ),
      ),
    );
  }
}
