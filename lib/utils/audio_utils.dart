import 'dart:developer';
import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioUtils {
  final List<String> excludePath = [
    "/storage/emulated/0/Android",
    "/storage/emulated/0/Sound",
    "/storage/emulated/0/."
  ];

  Future _searchAudioFile() async {
    Directory? dir = await getExternalStorageDirectory();
    List<FileSystemEntity>? allMusics = [];

    if (dir != null) {
      await Permission.storage.request();
      Directory? parent = dir.parent.parent.parent.parent;
      List<FileSystemEntity>? files =
          parent.listSync(recursive: true, followLinks: false);

      for (FileSystemEntity file in files) {
        bool skip = false;

        for (String path in excludePath) {
          if (file.path.startsWith(path)) {
            skip = true;
            break;
          }
        }

        if (skip) continue;

        if (file.path.endsWith(".m4a") || file.path.endsWith(".mp3")) {
          allMusics.add(file);
        }
      }
    }

    return allMusics;
  }

  Future getAllAudioFiles() async {
    List<FileSystemEntity> allMusics = await _searchAudioFile();

    List audio = [];

    for (FileSystemEntity file in allMusics) {
      AudioInfo audioInfo = AudioInfo(file.uri.toString(),
          title: file.path,
          desc: "hira",
          coverUrl: "assets/images/photo1.jpeg");
      audio.add(audioInfo.toJson());

      AudioManager.instance.audioList.add(audioInfo);
    }

    return audio;
  }
}
