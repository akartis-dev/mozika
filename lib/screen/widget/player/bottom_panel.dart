import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:mozika/services/audio_service.dart';

class PlayerBottomPanel extends StatefulWidget {
  const PlayerBottomPanel({Key? key}) : super(key: key);

  @override
  _PlayerBottomPanelState createState() => _PlayerBottomPanelState();
}

class _PlayerBottomPanelState extends State<PlayerBottomPanel> {
  PlayMode playMode = AudioManager.instance.playMode;
  Duration _duration = const Duration(milliseconds: 0);
  Duration _position = const Duration(milliseconds: 0);
  double _slider = 1;
  String _currentTitle = '';
  bool _isPlaying = false;

  Widget getPlayModeIcon(PlayMode playMode) {
    print(playMode);
    switch (playMode) {
      case PlayMode.sequence:
        return const Icon(
          Icons.repeat,
          color: Colors.black,
        );
      case PlayMode.shuffle:
        return const Icon(
          Icons.shuffle,
          color: Colors.black,
        );
      case PlayMode.single:
        return const Icon(
          Icons.repeat_one,
          color: Colors.black,
        );
    }
  }

  @override
  void initState() {
    super.initState();
    onChangeAudioEvent();
  }

  void nextSong() {
    AudioManager.instance.next();
  }

  void prevSong() {
    AudioManager.instance.previous();
  }

  void playSong() {
    AudioManager.instance.playOrPause();
  }

  void stopSong() {
    AudioManager.instance.stop();
  }

  void changeMode() {
    if (playMode == PlayMode.sequence) {
      AudioManager.instance.nextMode(playMode: PlayMode.shuffle);
    }

    if (playMode == PlayMode.shuffle) {
      AudioManager.instance.nextMode(playMode: PlayMode.single);
    }

    if (playMode == PlayMode.single) {
      AudioManager.instance.nextMode(playMode: PlayMode.sequence);
    }

    setState(() {});
  }

  void onChangeAudioEvent() {
    AudioManager.instance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.ready:
          _position = AudioManager.instance.position;
          _duration = AudioManager.instance.duration;
          _currentMusicPlaying();
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          _position = AudioManager.instance.position;
          _slider = _position.inMilliseconds / _duration.inMilliseconds;

          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          _isPlaying = AudioManager.instance.isPlaying;

          setState(() {});
          break;
        case AudioManagerEvents.ended:
          AudioManager.instance.next();
          setState(() {});
          break;
      }
    });
  }

  void onChangeSlider(value) {
    setState(() {
      _slider = value;
    });
  }

  void onChangeSliderEnd(value) {
    if (_duration != null) {
      Duration msec =
          Duration(milliseconds: (_duration.inMilliseconds * value).round());
      AudioManager.instance.seekTo(msec);
    }
  }

  String? _currentMusicPlaying() {
    setState(() {
      _currentTitle = AudioManager.instance.info?.title ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _currentTitle,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      thumbColor: Colors.blueAccent,
                      overlayColor: Colors.blue,
                      thumbShape: const RoundSliderThumbShape(
                        disabledThumbRadius: 5,
                        enabledThumbRadius: 5,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 10,
                      ),
                      activeTrackColor: Colors.blueAccent,
                      inactiveTrackColor: Colors.grey,
                    ),
                    child: Slider(
                        value: _slider,
                        onChanged: onChangeSlider,
                        onChangeEnd: onChangeSliderEnd))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AudioService.formatAudioDuration(_position),
            ),
            const Text(
              " / ",
            ),
            Text(
              AudioService.formatAudioDuration(_duration),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: prevSong,
                icon: const Icon(Icons.skip_previous_outlined)),
            IconButton(
                onPressed: playSong,
                icon: _isPlaying
                    ? const Icon(Icons.pause_circle_filled_outlined)
                    : const Icon(Icons.play_circle_outline_outlined)),
            IconButton(
                onPressed: stopSong, icon: const Icon(Icons.stop_circle)),
            IconButton(
                onPressed: nextSong,
                icon: const Icon(Icons.skip_next_outlined)),
            IconButton(icon: getPlayModeIcon(playMode), onPressed: changeMode),
          ],
        )
      ],
    );
  }
}
