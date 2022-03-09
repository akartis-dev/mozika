import 'package:flutter/material.dart';
import 'package:mozika/bloc/player/player_bloc.dart';
import 'package:mozika/model/entity/audio_model.dart';
import 'package:mozika/utils/theme.dart';
import 'package:provider/provider.dart';
import '../../../services/audio_service.dart';

class OneMusicItem extends StatefulWidget {
  final Audio audio;
  final int musicId;

  const OneMusicItem({Key? key, required this.audio, required this.musicId})
      : super(key: key);

  @override
  _OneMusicItemState createState() => _OneMusicItemState();
}

class _OneMusicItemState extends State<OneMusicItem> {
  @override
  void initState() {
    super.initState();
  }

  void onTapHandler() {
    String audioName = widget.audio.name;

    AudioService.playMusicInAudioManager(
        uri: widget.audio.uriPath, name: audioName);
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
        onTap: () {
          context.read<PlayerBloc>().add(PlayerCurrentPlaying(widget.musicId));
          onTapHandler();
        });
  }
}
