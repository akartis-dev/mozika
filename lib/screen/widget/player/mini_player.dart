import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:mozika/bloc/player/player_bloc.dart';
import 'package:mozika/utils/theme.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  void playOrPause() {
    AudioManager.instance.playOrPause();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: GlassmorphicContainer(
        width: MediaQuery.of(context).size.width,
        height: 75,
        borderRadius: 0,
        blur: 20,
        alignment: Alignment.bottomCenter,
        border: 0,
        linearGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF47423c).withOpacity(0.7),
              Color(0xFF2a2a2a).withOpacity(0.7),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.5),
            const Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
        child: Center(
          child: Container(
            padding: CustomTheme.container,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                    maxRadius: 25,
                    backgroundImage: AssetImage("assets/images/mucis.png")),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: BlocBuilder<PlayerBloc, PlayerState>(
                        builder: ((context, state) {
                      return Text(
                        state.title,
                        style: TextStyle(fontSize: CustomTheme.h4),
                      );
                    }))),
                Expanded(child: Container()),
                BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: playOrPause,
                        icon: state.isPlay
                            ? const Icon(
                                Icons.pause_circle,
                                color: Colors.white,
                                size: 30,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ));
                  },
                ),
                IconButton(
                    onPressed: () {
                      context.read<PlayerBloc>().add(PlayerNext());
                    },
                    icon: const Icon(
                      Icons.skip_next_outlined,
                      color: Colors.white,
                      size: 30,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
