import 'dart:developer';
import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_music_repository/local_music_repository.dart';
import 'package:mozika/bloc/audio/audio_bloc.dart';
import 'package:mozika/model/entity/audio_model.dart';
import 'package:mozika/screen/player/player_audio_screen.dart';
import 'package:mozika/screen/widget/appBar/appbar.dart';
import 'package:mozika/screen/widget/appBar/bottom_bar.dart';
import 'package:mozika/screen/widget/music/one_music_item.dart';
import 'package:mozika/screen/widget/music/search_input.dart';
import 'package:mozika/screen/widget/player/mini_player.dart';
import 'package:mozika/utils/theme.dart';

import '../../bloc/player/player_bloc.dart';

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
                  context.read<AudioBloc>().add(AudioResetList());
                },
                icon: const Icon(Icons.delete)),
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
          SearchInput(),
          BlocBuilder<AudioBloc, AudioStates>(builder: ((context, state) {
            // state.audios.listen(print);
            return StreamBuilder(
              stream: state.audios,
              builder: (BuildContext context,
                  AsyncSnapshot<List<AudioModels>?> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      color: CustomTheme.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text("Rafraichissement en cours..."),
                          )
                        ],
                      ));
                }

                return Container(
                  width: MediaQuery.of(context).size.width,
                  color: CustomTheme.black,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              AudioModels audioModel = snapshot.data![index];
                              Audio currentMusic = Audio(
                                  name: audioModel.name,
                                  folder: audioModel.folder,
                                  uriPath: audioModel.uriPath);
                              return OneMusicItem(
                                key: Key(index.toString()),
                                audio: currentMusic,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: snapshot.data?.length ?? 0),
                      )
                    ],
                  ),
                );
              },
            );
          })),
          MiniPlayer(),
        ]));
  }
}
