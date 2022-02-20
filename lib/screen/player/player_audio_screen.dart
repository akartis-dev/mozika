import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mozika/model/entity/audio_model.dart';
import 'package:mozika/screen/widget/player/bottom_panel.dart';
import 'package:mozika/services/audio_service.dart';

class PlayerAudioScreen extends StatefulWidget {
  const PlayerAudioScreen({Key? key}) : super(key: key);

  @override
  _PlayerAudioScreenState createState() => _PlayerAudioScreenState();
}

class _PlayerAudioScreenState extends State<PlayerAudioScreen> {
  bool isPlaying = false;
  late Duration _duration;
  late Duration _position;
  late double _slider;
  late double _sliderVolume;
  late String _error;

  @override
  void initState() {
    super.initState();
    // AudioService().saveAllAudioInDatabase();
    setupAudio();
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
      appBar: AppBar(title: Text('Player')),
      body: Container(
        child: Column(
          children: [PlayerBottomPanel()],
        ),
      ),
    );
  }
}
