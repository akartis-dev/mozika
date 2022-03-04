import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_music_repository/local_music_repository.dart';
import 'package:mozika/bloc/audio/audio_bloc.dart';
import 'package:mozika/screen/player/player_screen.dart';
import 'package:mozika/utils/theme.dart';

import 'screen/player/player_audio_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AudioBloc>(
            create: (BuildContext context) =>
                AudioBloc(localRepository: LocalRepository()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PlayerScreen(),
        theme: ThemeData(
            primaryColor: CustomTheme.primary,
            primaryTextTheme: const TextTheme(
                bodyText2: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white)),
            textTheme: const TextTheme(
                bodyText2: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white))),
      ),
    );
  }
}
