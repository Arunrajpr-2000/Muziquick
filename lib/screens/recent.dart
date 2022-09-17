import 'package:flutter/material.dart';

import 'package:music_player/widgets/drawer.dart';

import 'nowplay.dart';

class ScreenRecents extends StatefulWidget {
  ScreenRecents({Key? key}) : super(key: key);

  @override
  State<ScreenRecents> createState() => _ScreenRecentsState();
}

class _ScreenRecentsState extends State<ScreenRecents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff091127),
      appBar: AppBar(
        backgroundColor: Color(0xff091127),
        title: Text('Recents'),
        centerTitle: true,
      ),
      drawer: ScreenDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (ctx1) => ScreenNowplay()));
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
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                )),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
