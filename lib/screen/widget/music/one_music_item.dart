import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:mozika/model/entity/audio_model.dart';
import 'package:mozika/utils/theme.dart';

import '../../../services/audio_service.dart';

class OneMusicItem extends StatefulWidget {
  final Audio audio;

  const OneMusicItem({
    Key? key,
    required this.audio,
  }) : super(key: key);

  @override
  _OneMusicItemState createState() => _OneMusicItemState();
}

class _OneMusicItemState extends State<OneMusicItem> {
  String? _currentTitle;

  @override
  void initState() {
    super.initState();
    // audioManagerEvent();
  }

  void audioManagerEvent() {
    AudioManager.instance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.ready:
          _currentTitle = AudioManager.instance.info?.title;

          setState(() {});
          break;
        case AudioManagerEvents.start:
          setState(() {
            // _isPlaying = true;
          });
      }
    });
  }

  void onTapHandler() {
    String audioName = widget.audio.name;

    if (_currentTitle != audioName) {
      AudioService.playMusicInAudioManager(
          uri: widget.audio.uriPath, name: audioName);
    } else {
      AudioManager.instance.playOrPause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.music_note_outlined, color: Colors.white),
        title: Text(
          widget.audio.name,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          widget.audio.folder,
          style: const TextStyle(color: Colors.white54),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_outline_outlined,
                  size: 23, color: CustomTheme.primary),
            ),
          ],
        ),
        onTap: onTapHandler);
  }
}
