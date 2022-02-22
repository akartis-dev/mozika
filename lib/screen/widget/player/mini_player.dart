import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:mozika/utils/theme.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  _MiniPlayerState createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  String? currentTitle = "";
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    playerEvent();
  }

  void playerEvent() {
    AudioManager.instance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.timeupdate:
          if (currentTitle == "") {
            currentTitle = AudioManager.instance.info?.title;
            setState(() {});
          }
          break;
        case AudioManagerEvents.ready:
          currentTitle = AudioManager.instance.info?.title;
          setState(() {});
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = AudioManager.instance.isPlaying;
          setState(() {});
      }
    });
  }

  void playOrPause() {
    AudioManager.instance.playOrPause();
  }

  void next() {
    AudioManager.instance.next();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: GlassmorphicContainer(
        width: MediaQuery.of(context).size.width,
        height: 100,
        borderRadius: 0,
        blur: 2,
        alignment: Alignment.bottomCenter,
        border: 0,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.1),
              const Color(0xFFFFFFFF).withOpacity(0.05),
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
                  child: Text(
                    currentTitle ?? "No music",
                    style: TextStyle(fontSize: CustomTheme.h4),
                  ),
                ),
                Expanded(child: Container()),
                IconButton(
                    onPressed: playOrPause,
                    icon: isPlaying
                        ? const Icon(
                            Icons.pause_circle,
                            color: Colors.white,
                            size: 30,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          )),
                IconButton(
                    onPressed: next,
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
