// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';

// import 'package:music_player/PlayList/insidelist.dart';
// import 'package:music_player/model/box_class.dart';
// import 'package:music_player/model/hivemodel.dart';
// import 'package:music_player/screens/favourite.dart';

// import '../PlayList/Cusomsetting.dart';

// class Playlists extends StatefulWidget {
//   const Playlists({Key? key}) : super(key: key);

//   @override
//   State<Playlists> createState() => _PlaylistsState();
// }

// class _PlaylistsState extends State<Playlists> {
//   late TextEditingController controller;

//   String? title;
//   final formkey = GlobalKey<FormState>();

//   final existingPlaylist = SnackBar(
//     content: Text(
//       "This playlist name already exist",
//       style: TextStyle(
//         fontFamily: "poppinz",
//         fontSize: 15,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     backgroundColor: const Color.fromARGB(255, 156, 10, 0),
//     behavior: SnackBarBehavior.floating,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//   );

//   final box = Boxes.getinstance();
//   List playlists = [];
//   String? playlistName = '';

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     var mediaquery1 = MediaQuery.of(context);
//     return Scaffold(
//       backgroundColor: Color(0xff091127),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 CustomList(
//                   newtitle: 'Create Playlists',
//                   newleading: Icons.add,
//                   tap: () {
//                     showDialog(
//                         context: context,
//                         builder: (ctx) {
//                           return Dialog(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 102, 97, 97),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(40.0),
//                               child: Container(
//                                 width: 300,
//                                 height: 165,
//                                 child: Column(
//                                   children: [
//                                     Form(
//                                       key: formkey,
//                                       child: TextFormField(
//                                         textCapitalization:
//                                             TextCapitalization.sentences,
//                                         controller: controller,
//                                         style: const TextStyle(
//                                             color: Colors.white),
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                               borderSide: const BorderSide(
//                                                   color: Colors.white)),
//                                           enabledBorder: OutlineInputBorder(
//                                               borderSide: const BorderSide(
//                                                   color: Colors.white,
//                                                   width: 2),
//                                               borderRadius:
//                                                   BorderRadius.circular(30)),
//                                           hintStyle: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 202, 202, 202)),
//                                           hintText: 'Create a Playlist',
//                                           focusedBorder: OutlineInputBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(30),
//                                             borderSide: const BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 155, 122, 122),
//                                               width: 2.0,
//                                             ),
//                                           ),
//                                         ),
//                                         onChanged: (value) {
//                                           title = value.trim();
//                                         },
//                                         validator: (value) {
//                                           List keys = box.keys.toList();
//                                           if (value!.trim() == "") {
//                                             return "Name required";
//                                           }
//                                           if (keys
//                                               .where((element) =>
//                                                   element == value.trim())
//                                               .isNotEmpty) {
//                                             return "This name is already exists";
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 30,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(
//                                           20, 0, 20, 0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           SizedBox(
//                                             width: 80,
//                                             child: ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                     primary: Colors.white,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         20))),
//                                                 onPressed: () {
//                                                   submit();
//                                                 },
//                                                 child: const Text(
//                                                   'Create',
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 )),
//                                           ),
//                                           SizedBox(
//                                             width: 80,
//                                             child: ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                     primary: Colors.white,
//                                                     shape:
//                                                         RoundedRectangleBorder(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         20))),
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: const Text(
//                                                   'Cancel',
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 )),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                   },
//                 ),
//                 CustomList(
//                   newtitle: 'Favourites',
//                   newleading: Icons.favorite,
//                   tap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: ((context) => ScreenFavourite())));
//                   },
//                 ),
//                 SizedBox(
//                   height: 27,
//                 ),
//                 ValueListenableBuilder(
//                     valueListenable: box.listenable(),
//                     builder: (context, boxes, _) {
//                       playlists = box.keys.toList();

//                       return ListView.builder(
//                           physics: BouncingScrollPhysics(),
//                           shrinkWrap: true,
//                           itemCount: playlists.length,
//                           itemBuilder: (context, index) => GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => InsideList(
//                                             playlistName: playlists[index],
//                                           )),
//                                 );
//                               },
//                               child: playlists[index] != "musics" &&
//                                       playlists[index] != "favorites"
//                                   ? libraryList(
//                                       // child: customplay(
//                                       //     aatitle: playlists[index].toString(),))
//                                       child: Column(
//                                       children: [
//                                         GestureDetector(
//                                           child: Container(
//                                             height: 83,
//                                             width: 350,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                               color: Color(0xff091127),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(12.0),
//                                               child: Row(
//                                                 children: [
//                                                   Container(
//                                                     height: 58,
//                                                     width: 58,
//                                                     decoration: BoxDecoration(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         color: Colors.black
//                                                             .withOpacity(0.3)),
//                                                     child: const Icon(
//                                                       Icons.queue_music,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 20,
//                                                   ),
//                                                   SizedBox(
//                                                     width: 100,
//                                                     child: Text(
//                                                       playlists[index]
//                                                           .toString(),
//                                                       maxLines: 1,
//                                                       style: TextStyle(
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           fontFamily: "poppinz",
//                                                           color: Colors.white,
//                                                           fontSize: 20,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     ),
//                                                   ),
//                                                   const Spacer(),
//                                                   IconButton(
//                                                       onPressed: () {
//                                                         showDialog(
//                                                             context: context,
//                                                             builder: (ctx) {
//                                                               return Dialog(
//                                                                 backgroundColor:
//                                                                     const Color
//                                                                             .fromARGB(
//                                                                         255,
//                                                                         102,
//                                                                         97,
//                                                                         97),
//                                                                 shape:
//                                                                     RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               40),
//                                                                 ),
//                                                                 child: Padding(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                               .all(
//                                                                           40.0),
//                                                                   child:
//                                                                       Container(
//                                                                     width: 300,
//                                                                     height: 115,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         Text(
//                                                                           'Do you want to delete',
//                                                                           style: TextStyle(
//                                                                               fontFamily: "poppinz",
//                                                                               fontSize: 20,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: Colors.white),
//                                                                         ),
//                                                                         SizedBox(
//                                                                           height:
//                                                                               40,
//                                                                         ),
//                                                                         Padding(
//                                                                           padding: const EdgeInsets.fromLTRB(
//                                                                               20,
//                                                                               0,
//                                                                               20,
//                                                                               0),
//                                                                           child:
//                                                                               Row(
//                                                                             mainAxisAlignment:
//                                                                                 MainAxisAlignment.spaceBetween,
//                                                                             children: [
//                                                                               SizedBox(
//                                                                                 width: 80,
//                                                                                 child: ElevatedButton(
//                                                                                     style: ElevatedButton.styleFrom(primary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
//                                                                                     onPressed: () {
//                                                                                       box.delete(playlists[index]);
//                                                                                       setState(() {
//                                                                                         playlists = box.keys.toList();
//                                                                                       });
//                                                                                       Navigator.pop(context);
//                                                                                     },
//                                                                                     child: const Text(
//                                                                                       'Delete',
//                                                                                       style: TextStyle(color: Colors.black),
//                                                                                     )),
//                                                                               ),
//                                                                               SizedBox(
//                                                                                 width: 80,
//                                                                                 child: ElevatedButton(
//                                                                                     style: ElevatedButton.styleFrom(primary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
//                                                                                     onPressed: () {
//                                                                                       Navigator.pop(context);
//                                                                                     },
//                                                                                     child: const Text(
//                                                                                       'Cancel',
//                                                                                       style: TextStyle(color: Colors.black),
//                                                                                     )),
//                                                                               ),
//                                                                             ],
//                                                                           ),
//                                                                         )
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             });
//                                                       },
//                                                       icon: const Icon(
//                                                         Icons.delete,
//                                                         color: Colors.white,
//                                                       )),
                                                      
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ))
//                                   : Container()));
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Padding libraryList({required child}) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
//       child: child,
//     );
//   }

//   void submit() {
//     playlistName = controller.text;
//     List<LocalSongs> librayry = [];
//     List? excistingName = [];
//     if (playlists.isNotEmpty) {
//       excistingName =
//           playlists.where((element) => element == playlistName).toList();
//     }

//     if (playlistName != '' &&
//         excistingName.isEmpty &&
//         formkey.currentState!.validate()) {
//       box.put(playlistName, librayry);
//       Navigator.of(context).pop();
//       setState(() {
//         playlists = box.keys.toList();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(existingPlaylist);
//     }

//     controller.clear();
//   }
// }
