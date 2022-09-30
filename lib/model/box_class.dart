import 'package:hive/hive.dart';

String boxname = 'songs';

class Boxes {
  static Box<List>? _box;

  static Box<List> getinstance() {
    return _box ??= Hive.box(boxname);
  }

  // static Box<List> getList() => Hive.box<List>('SongsList_db');
  // static Box<LocalSongs> getSongs() => Hive.box<LocalSongs>('musics');

  // static getList() {}

  // static getSongs() {}
}
