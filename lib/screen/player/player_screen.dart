import 'dart:developer';
import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mozika/utils/audio_utils.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  PlayerScreenState createState() => PlayerScreenState();
}

class PlayerScreenState extends State<PlayerScreen> {
  String _platformVersion = 'Unknown';

  late var list = [];

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    // setupAudio();
  }

  Future<bool> initAudioList() async {
    list = await AudioUtils().getAllAudioFiles();
    // log(list.toString());
    return true;
  }

  void setupAudio() {
    List<AudioInfo> _list = [];

    list.forEach((e) => _list.add(AudioInfo(e['url'] ?? "",
        title: e['title'] ?? "",
        desc: e['desc'] ?? "",
        coverUrl: e['coverUrl'] ?? "")));

    AudioManager.instance.audioList = _list;
    AudioManager.instance.intercepter = true;
    AudioManager.instance.play(auto: false);
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await AudioManager.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Demo player'),
        ),
        body: FutureBuilder(
            future: initAudioList(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading');
              }

              return Center(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(list[index]['title'] ?? ""),
                                  subtitle: Text(list[index]['desc'] ?? ""),
                                  onTap: () {
                                    var vazo = list[index];
                                    AudioManager.instance.file(
                                        File(vazo['url']), vazo['title'],
                                        desc: vazo['desc'],
                                        cover: vazo['coverUrl'],
                                        auto: true);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: list.length))
                    ],
                  ),
                ),
              );
            })));
  }
}
