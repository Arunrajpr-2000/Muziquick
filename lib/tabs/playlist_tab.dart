import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:music_player/PlayList/music_in_playlist.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/functions/functions.dart';

import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/widgets/edit_playlist.dart';

class Playlist_tab extends StatefulWidget {
  Playlist_tab({Key? key}) : super(key: key);

  @override
  State<Playlist_tab> createState() => _Playlist_tabState();
}

class _Playlist_tabState extends State<Playlist_tab> {
  late TextEditingController controller;

  String? title;
  final formkey = GlobalKey<FormState>();

  final existingPlaylist = SnackBar(
    content: Text(
      "Playlist name already exist",
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Colors.orange,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Create Playlists',
              style: TextStyle(
                  fontFamily: "poppinz",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            leading: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return Dialog(
                      backgroundColor: Color(0xff091127),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Container(
                          width: 300,
                          height: 165,
                          child: Column(
                            children: [
                              Form(
                                key: formkey,
                                child: TextFormField(
                                  controller: controller,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Create a Playlist',
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.orange,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    title = value.trim();
                                  },
                                  // validator: (value) {
                                  //   List keys = box.keys.toList();
                                  //   if (value!.trim() == "") {
                                  //     return "Name required";
                                  //   }
                                  //   if (keys
                                  //       .where((element) =>
                                  //           element == value.trim())
                                  //       .isNotEmpty) {
                                  //     return "This name is already exists";
                                  //   }
                                  // },
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          submit();
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
          ),
          SizedBox(
            height: 27,
          ),
          ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, boxes, _) {
                playlists = box.keys.toList();

                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: playlists.length,
                    itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InsideList(
                                      playlistName: playlists[index],
                                    )),
                          );
                        },
                        child: playlists[index] != "musics" &&
                                playlists[index] != "favorites" &&
                                playlists[index] != "recent"
                            ? libraryList(
                                // child: customplay(
                                //     aatitle: playlists[index].toString(),))
                                child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Color(0xff16213E),
                                leading: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: AssetImage(
                                    'asset images/ArtMusicMen.jpg.jpg',
                                  ),
                                ),
                                title: Text(
                                  playlists[index].toString(),
                                  maxLines: 1,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: "poppinz",
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  '${listLength(listName: playlists[index]).toString()} Songs',
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      // fontFamily: "poppinz",
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return editplaylist(
                                                  playlistNameForEdit:
                                                      playlists[index],
                                                );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return Dialog(
                                                  backgroundColor:
                                                      const Color(0xff091127),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            40.0),
                                                    child: Container(
                                                      width: 300,
                                                      height: 115,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Do you want to delete',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "poppinz",
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                width: 80,
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: Colors
                                                                                .white,
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(
                                                                                    10))),
                                                                        onPressed:
                                                                            () {
                                                                          box.delete(
                                                                              playlists[index]);
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            content:
                                                                                Text(
                                                                              "Deleted Successfully",
                                                                              style: TextStyle(
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            backgroundColor:
                                                                                Colors.orange,
                                                                            behavior:
                                                                                SnackBarBehavior.floating,
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          ));

                                                                          setState(
                                                                              () {
                                                                            playlists =
                                                                                box.keys.toList();
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Delete',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        )),
                                                              ),
                                                              SizedBox(
                                                                width: 80,
                                                                child:
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary: Colors
                                                                                .white,
                                                                            shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(
                                                                                    10))),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          'Cancel',
                                                                          style:
                                                                              TextStyle(color: Colors.black),
                                                                        )),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ))
                            : Container()));
              }),
        ],
      ),
    );
  }

  Padding libraryList({required child}) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      child: child,
    );
  }

  void submit() {
    playlistName = controller.text;
    List<LocalSongs> librayry = [];
    List? excistingName = [];
    if (playlists.isNotEmpty) {
      excistingName =
          playlists.where((element) => element == playlistName).toList();
    }

    if (playlistName != '' &&
        excistingName.isEmpty &&
        formkey.currentState!.validate()) {
      box.put(playlistName, librayry);
      Navigator.of(context).pop();
      setState(() {
        playlists = box.keys.toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(existingPlaylist);
    }

    controller.clear();
  }
}

int listLength({required listName}) {
  final g = box.get(listName)!;
  return g.length;
}
