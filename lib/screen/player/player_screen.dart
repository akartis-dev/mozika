import 'dart:developer';
import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mozika/model/entity/audio_model.dart';
import 'package:mozika/services/audio_service.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  PlayerScreenState createState() => PlayerScreenState();
}

class PlayerScreenState extends State<PlayerScreen> {
  String _platformVersion = 'Unknown';

  late var list = [];
  late List<Audio> audioList = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();

    // setupAudio();
  }

  Future<bool> initAudioList() async {
    // AudioService().saveAllAudioInDatabase();
    audioList = await AudioService().getAllAudio();
    list = await AudioService().getAllAudioFiles();
    // log(list.toString());
    return true;
  }

  void setupAudio() {
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
                                Audio currentMusic = audioList[index];
                                return ListTile(
                                  title: Text(currentMusic.name),
                                  subtitle: Text(currentMusic.folder),
                                  onTap: () {
                                    AudioManager.instance.file(
                                        File(currentMusic.uriPath),
                                        currentMusic.name,
                                        desc: "",
                                        cover: 'assets/images/photo1.jpeg',
                                        auto: true);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: audioList.length))
                    ],
                  ),
                ),
              );
            })));
  }
}
