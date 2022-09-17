// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:miniplayer/miniplayer.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// import '../screens/nowplay.dart';

// class Miniply extends StatefulWidget {
//   List<Audio> myaudiosong = [];
//   Miniply({Key? key}) : super(key: key);

//   @override
//   State<Miniply> createState() => _MiniplyState();
// }

// class _MiniplyState extends State<Miniply> {
//   @override
//   Widget build(BuildContext context) {
//     return Miniplayer(
//       minHeight: 70,
//       elevation: 20,
//       maxHeight: 100,
//       builder: (height, percentage) {
//         // if (percentage > 0.2) {
//         // return Text('!mini');
//         // } else {
//         return Container(
//           color: Color(0xff091127),
//           alignment: Alignment.center,
//           width: 20,
//           height: 50,
//           child: assetsAudioPlayer.builderCurrent(
//               builder: (context, Playing? playing) {
//             final myAudio =
//                 find(widget.myaudiosong, playing!.audio.assetAudioPath);
//             return ListTile(
//               leading: QueryArtworkWidget(
//                 id: int.parse(myAudio.metas.id!),
//                 type: ArtworkType.AUDIO,
//                 nullArtworkWidget: const Icon(
//                   Icons.music_note,
//                   color: Colors.white,
//                 ),
//               ),
//               title: Text(
//                 myAudio.metas.title.toString(),
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               subtitle: Text(
//                 myAudio.metas.artist.toString(),
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               trailing: PlayerBuilder.isPlaying(
//                   player: assetsAudioPlayer,
//                   builder: (context, isPlaying) {
//                     return GestureDetector(
//                       onTap: () async {
//                         await assetsAudioPlayer.playOrPause();
//                       },
//                       child: Icon(
//                         isPlaying ? Icons.pause : Icons.play_arrow,
//                         color: Colors.white,
//                         size: 35,
//                       ),
//                     );
//                   }),
//             );
//           }),
//         );
//         //  }
//       },
//     );
//   }
// }
