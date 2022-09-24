import 'package:flutter/material.dart';
import 'package:music_player/functions/functions.dart';

import 'package:music_player/model/hivemodel.dart';

class editplaylist extends StatefulWidget {
  editplaylist({Key? key, required index, required playlistName})
      : super(key: key);

  @override
  State<editplaylist> createState() => _editplaylistState();
}

class _editplaylistState extends State<editplaylist> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // nameController.text = playlistName.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // playlists = box.keys.toList();
    //int? index;
    return AlertDialog(
      backgroundColor: const Color(0xff091127),
      title: Text("Edit Playlist",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "poppinz",
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      content: TextField(
        controller: nameController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
          ),
          hintStyle: const TextStyle(color: Colors.white),
          // labelText: playlistName.toString(),
          hintText: playlistName.toString(),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.orange,
              width: 2.0,
            ),
          ),
        ),
        onChanged: (value) {
          playlistName = value;
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              List<LocalSongs> librayry = [];
              List? excistingName = [];
              if (playlists.isNotEmpty) {
                excistingName = playlists
                    .where((element) => element == playlistName)
                    .toList();
              }

              if (playlistName != '' && excistingName.isEmpty) {
                box.put(playlistName, librayry);
                Navigator.of(context).pop();
                //setState(() {
                playlists = box.keys.toList();
                //});
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(
              "Edit",
              style: TextStyle(
                  fontFamily: "poppinz",
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
