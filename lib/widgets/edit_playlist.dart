import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_player/functions/functions.dart';

import 'package:music_player/model/hivemodel.dart';

class editplaylist extends StatefulWidget {
  editplaylist({Key? key, required this.playlistNameForEdit}) : super(key: key);
  final String playlistNameForEdit;
  @override
  State<editplaylist> createState() => _editplaylistState();
}

class _editplaylistState extends State<editplaylist> {
  late TextEditingController nameController;
  String playlistNewName = '';
  @override
  void initState() {
    // TODO: implement initState
    nameController =
        TextEditingController(text: widget.playlistNameForEdit.toString());
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
          // hintText: playlistName.toString(),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.orange,
              width: 2.0,
            ),
          ),
        ),
        onChanged: (value) {
          playlistNewName = value;
        },
      ),
      actions: [
        TextButton(
            onPressed: () {
              List playListnames = box.keys.toList();

              if (!playListnames.contains(playlistNewName)) {
                List<dynamic> playListSongs =
                    box.get(widget.playlistNameForEdit)!;
                box.delete(widget.playlistNameForEdit);
                box.put(playlistNewName, playListSongs);
              } else {
                // ScaffoldMessenger(
                //     child: SnackBar(
                //   content: Text('${playlistNewName} already exist in playlist'),
                // ));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    '${playlistNewName} already exist in playlist',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.orange,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ));
              }
              Navigator.of(context).pop();
            },
            child: const Text(
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
