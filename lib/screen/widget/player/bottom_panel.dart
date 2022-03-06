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
  double _slider = 0;
  String _currentTitle = '';
  bool _isPlaying = false;
  bool _refreshPlayer = false;

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
          if (!_refreshPlayer) {
            _position = AudioManager.instance.position;
            _duration = AudioManager.instance.duration;
            _currentMusicPlaying();
            _isPlaying = AudioManager.instance.isPlaying;

            setState(() {
              _refreshPlayer = true;
            });
          }

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .75,
              child: Text(
                _currentTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                softWrap: true,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_outlined)),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Expanded(
                  child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        thumbColor: Colors.white,
                        overlayColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                          disabledThumbRadius: 7,
                          enabledThumbRadius: 7,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 10,
                        ),
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                      child: Slider(
                          value: _slider,
                          min: 0.0,
                          max: 1.0,
                          onChanged: onChangeSlider,
                          onChangeEnd: onChangeSliderEnd))),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AudioService.formatAudioDuration(_position),
              style: const TextStyle(fontSize: 14),
            ),
            IconButton(
                iconSize: 40,
                onPressed: prevSong,
                icon: const Icon(Icons.skip_previous_outlined)),
            IconButton(
                iconSize: 75,
                onPressed: playSong,
                icon: _isPlaying
                    ? const Icon(Icons.pause_circle_filled_outlined)
                    : const Icon(Icons.play_circle_outline_outlined)),
            IconButton(
                iconSize: 40,
                onPressed: nextSong,
                icon: const Icon(Icons.skip_next_outlined)),
            Text(
              AudioService.formatAudioDuration(_duration),
              style: const TextStyle(fontSize: 14),
            ),
            // IconButton(icon: getPlayModeIcon(playMode), onPressed: changeMode),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.repeat)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.shuffle)),
          ],
        )
      ],
    );
  }
}
