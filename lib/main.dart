import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/model/box_class.dart';
import 'package:music_player/model/hivemodel.dart';
import 'package:music_player/screens/splash.dart';
import 'package:music_player/widgets/miniplayer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalSongsAdapter());
  await Hive.openBox<List>(boxname);
  final box = Boxes.getinstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
    );
  }
}
