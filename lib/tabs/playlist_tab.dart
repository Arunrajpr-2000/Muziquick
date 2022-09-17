import 'package:flutter/material.dart';

class Playlist_tab extends StatefulWidget {
  Playlist_tab({Key? key}) : super(key: key);

  @override
  State<Playlist_tab> createState() => _Playlist_tabState();
}

class _Playlist_tabState extends State<Playlist_tab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return SizedBox(
              height: 70,
              child: ListTile(
                title: Text(
                  'Playlist',
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Are you sure? '),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      //  data[index].delete();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'))
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              ),
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
