import 'package:flutter/material.dart';
import 'package:music_player/functions/functions.dart';

import 'package:music_player/widgets/drawer.dart';

bool temp = true;

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  bool islight = true;

  static bool toggleNotification({required bool isNotificationOn}) {
    isNotificationOn
        ? assetsAudioPlayer.showNotification = true
        : assetsAudioPlayer.showNotification = false;
    assetsAudioPlayer.showNotification ? temp = true : temp = false;

    return temp;
  }

  @override
  void initState() {
    // TODO: implement initState
    // switchvalues();
    super.initState();
  }

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
            leading: const Icon(Icons.notifications, color: Colors.white),
            title: const Text(
              'Notification',
              style: TextStyle(color: Colors.white),
            ),
            trailing: Switch(
                focusColor: Colors.blue,
                activeColor: Colors.orange,
                value: islight,
                onChanged: (value) {
                  bool temp = value;
                  temp = toggleNotification(isNotificationOn: value);
                  setState(() {
                    islight = temp;
                  });
                }),
          ),
          const ListTile(
            leading: Icon(Icons.share, color: Colors.white),
            title: Text(
              'Share',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.lock, color: Colors.white),
            title: Text(
              'Privacy policy',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.gavel, color: Colors.white),
              title: const Text(
                'Terms & conditions',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const LicensePage();
                }));
              }),
          ListTile(
            leading: const Icon(Icons.error_outline, color: Colors.white),
            title: const Text(
              'About',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              // AlertDialog();
              showAboutDialog(
                context: context,
                applicationName: "MIXPOD",

                applicationIcon: SizedBox(
                  height: size.height * 0.05,
                  width: size.width * 0.2,
                  child: Image.asset(
                    'asset images/landscape,-transparent-bg-+-shadow-designify.png',
                    // width: 70,
                    // height: 70,
                    fit: BoxFit.contain,
                  ),
                ),
                applicationVersion: "1.0",
                children: [
                  const Text(
                    "MIXPOD is a offline music player created by Arun Raj P R",
                    style: TextStyle(
                        fontFamily: "poppinz", fontWeight: FontWeight.w500),
                  )
                ],
                // applicationIcon: SizedBox(
                //   height: 45,
                //   width: 45,
                // child: Image.asset("assets/logo.jpg",fit: BoxFit.cover,),
                // )
              );
            },
          ),
          SizedBox(
            height: size.width * 0.5,
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
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
    );
  }
}
