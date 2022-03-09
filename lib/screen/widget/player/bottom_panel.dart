import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mozika/bloc/player/player_bloc.dart';
import 'package:mozika/services/audio_service.dart';

class PlayerBottomPanel extends StatefulWidget {
  const PlayerBottomPanel({Key? key}) : super(key: key);

  @override
  _PlayerBottomPanelState createState() => _PlayerBottomPanelState();
}

class _PlayerBottomPanelState extends State<PlayerBottomPanel> {
  PlayMode playMode = AudioManager.instance.playMode;

  @override
  void initState() {
    super.initState();
  }

  void playSong() {
    AudioManager.instance.playOrPause();
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
                child: BlocBuilder<PlayerBloc, PlayerState>(
                    builder: (context, state) {
                  return Text(
                    state.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    softWrap: true,
                  );
                })),
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
                      child: BlocBuilder<PlayerBloc, PlayerState>(
                          builder: (context, state) {
                        double sliderValue = state.position.inMilliseconds /
                            state.duration.inMilliseconds;

                        return Slider(
                          value: sliderValue.isNaN ? 0 : sliderValue,
                          min: 0.0,
                          max: 1.0,
                          onChangeEnd: (double value) {
                            context
                                .read<PlayerBloc>()
                                .add(PlayerChangeSlider(value));
                          },
                          onChanged: (double value) {},
                        );
                      })))
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
              return Text(
                AudioService.formatAudioDuration(state.position),
                style: const TextStyle(fontSize: 14),
              );
            }),

            IconButton(
                iconSize: 40,
                onPressed: () {
                  context.read<PlayerBloc>().add(PlayerPrevious());
                },
                icon: const Icon(Icons.skip_previous_outlined)),
            BlocBuilder<PlayerBloc, PlayerState>(builder: ((context, state) {
              return IconButton(
                  iconSize: 75,
                  onPressed: playSong,
                  icon: state.isPlay
                      ? const Icon(Icons.pause_circle_filled_outlined)
                      : const Icon(Icons.play_circle_outline_outlined));
            })),
            IconButton(
                iconSize: 40,
                onPressed: () {
                  context.read<PlayerBloc>().add(PlayerNext());
                },
                icon: const Icon(Icons.skip_next_outlined)),
            BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
              return Text(
                AudioService.formatAudioDuration(state.duration),
                style: const TextStyle(fontSize: 14),
              );
            }),
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
