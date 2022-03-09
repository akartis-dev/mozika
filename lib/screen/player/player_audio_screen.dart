import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozika/model/entity/audio_model.dart';
import 'package:mozika/screen/widget/player/bottom_panel.dart';
import 'package:mozika/services/audio_service.dart';
import 'package:mozika/utils/theme.dart';

import '../../bloc/player/player_bloc.dart';

class PlayerAudioScreen extends StatefulWidget {
  const PlayerAudioScreen({Key? key}) : super(key: key);

  @override
  _PlayerAudioScreenState createState() => _PlayerAudioScreenState();
}

class _PlayerAudioScreenState extends State<PlayerAudioScreen> {
  @override
  void initState() {
    super.initState();
  }

  void setupAudio() async {
    final List<Audio> allAudio = await AudioService().getAllAudioFromDb();
    final _random = Random();
    final Audio randomAudio = allAudio[_random.nextInt(allAudio.length)];
    AudioService.playMusicInAudioManager(
        uri: randomAudio.uriPath, name: randomAudio.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.black,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Container(
        padding: CustomTheme.container,
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [Colors.grey.shade800, CustomTheme.black])),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .45,
              child: Image.asset(
                "assets/images/player.png",
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            PlayerBottomPanel()
          ],
        ),
      ),
    );
  }
}
