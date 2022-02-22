import 'dart:developer';
import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mozika/model/entity/audio_model.dart';
import 'package:mozika/screen/player/player_audio_screen.dart';
import 'package:mozika/screen/widget/appBar/appbar.dart';
import 'package:mozika/screen/widget/appBar/bottom_bar.dart';
import 'package:mozika/screen/widget/music/one_music_item.dart';
import 'package:mozika/screen/widget/music/search_input.dart';
import 'package:mozika/screen/widget/player/mini_player.dart';
import 'package:mozika/services/audio_service.dart';
import 'package:mozika/utils/theme.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  PlayerScreenState createState() => PlayerScreenState();
}

class PlayerScreenState extends State<PlayerScreen> {
  String _platformVersion = 'Unknown';

  late List<Audio> audioList = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();

    // setupAudio();
  }

  Future<bool> initAudioList() async {
    // AudioService().saveAllAudioInDatabase();
    audioList = await AudioService().getAllAudioFromDb();
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
        appBar: AppPlayerAppBar(
          title: "Mozika",
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlayerAudioScreen()));
                },
                icon: const Icon(Icons.audiotrack))
          ],
        ),
        bottomNavigationBar: const BottomBar(),
        body: Stack(children: [
          FutureBuilder(
              future: initAudioList(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                }

                return Container(
                  padding: CustomTheme.container,
                  color: CustomTheme.black,
                  child: Column(
                    children: [
                      SearchInput(),
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                Audio currentMusic = audioList[index];
                                return OneMusicItem(
                                  key: Key(index.toString()),
                                  audio: currentMusic,
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: audioList.length))
                    ],
                  ),
                );
              })),
          MiniPlayer(),
        ]));
  }
}
