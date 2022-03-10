import 'package:flutter/material.dart';
import 'package:mozika/screen/widget/player/bottom_panel.dart';
import 'package:mozika/utils/theme.dart';

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
