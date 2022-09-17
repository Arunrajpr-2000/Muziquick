import 'package:flutter/material.dart';
import 'package:music_player/screens/home.dart';
import 'package:music_player/widgets/drawer.dart';

class ScreenSettings extends StatefulWidget {
  ScreenSettings({Key? key}) : super(key: key);

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  bool islight = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff091127),
      appBar: AppBar(
        backgroundColor: Color(0xff091127),
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //     icon: Icon(Icons.arrow_back)),
        title: Text('Settings'),
        centerTitle: true,
      ),
      drawer: ScreenDrawer(),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            title: Text(
              'Notification',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Switch(
                focusColor: Colors.blue,
                activeColor: Colors.orange,
                value: islight,
                onChanged: (value) {
                  setState(() {
                    islight = value;
                  });
                }),
          ),
          ListTile(
            leading: Icon(Icons.share, color: Colors.white),
            title: Text(
              'Share',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.white),
            title: Text(
              'Privacy policy',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.gavel, color: Colors.white),
            title: Text(
              'Terms & conditions',
              style: TextStyle(color: Colors.white),
            ),
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
          Padding(
            padding: const EdgeInsets.only(
              bottom: 0,
              top: 150,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
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
            ),
          )
        ],
      ),
    );
  }
}
