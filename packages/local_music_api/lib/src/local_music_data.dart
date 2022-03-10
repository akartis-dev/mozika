import 'dart:async';

import 'package:local_music_api/src/database.dart';
import 'package:local_music_api/src/models/audio_models.dart';
import 'package:local_music_api/src/models/local_music.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class LocalMusicApi implements LocalMusic {
  /// Provide a list for all audio in external memory
  @override
  Future<List<AudioModels>> _allAudioList() async {
    Directory? dir = await getExternalStorageDirectory();
    List<AudioModels> results = [];

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
          final String name = basenameWithoutExtension(file.path);
          final String folder = file.parent.path
              .replaceAll(RegExp(r'\/storage\/emulated\/0\/'), '');
          results.add(AudioModels(
              name: name, folder: folder, uriPath: file.uri.toString()));
        }
      }
    }

    return results;
  }

  @override
  List<String> get excludePath => [
        "/storage/emulated/0/Android",
        "/storage/emulated/0/Sound",
        "/storage/emulated/0/."
      ];

  @override
  String get storagePath => "/storage/emulated/0/";

  /// Provide all audio list stream from database
  @override
  Future<List<AudioModels>> getAllAudioList() async {
    Database db = await DatabaseInstance.createInstance();

    List<Map<String, dynamic>> data = await db.query('audio');

    if (data.isEmpty) {
      List<AudioModels> lists = await _allAudioList();
      lists.forEach((AudioModels e) {
        db.insert('audio', e.toJson());
      });
      data = await db.query('audio');
    }

    return List.generate(
      data.length,
      (i) => AudioModels(
          id: data[i]['id'],
          name: data[i]['name'],
          folder: data[i]['folder'],
          uriPath: data[i]['uriPath'],
          favorite: data[i]['favorite']),
    );
  }

  /// Delete everything in audio database
  @override
  Future<bool> resetAudioTable() async {
    Database db = await DatabaseInstance.createInstance();
    await db.execute("DELETE FROM audio");

    return true;
  }

  /// Set audio favorite
  @override
  Future<bool> setAudioToFavorite(AudioModels audio) async {
    Database db = await DatabaseInstance.createInstance();
    await db.rawUpdate("UPDATE audio SET favorite = ? where id = ?",
        [audio.favoriteOpposite, audio.id]);
    return !audio.favoriteBool;
  }
}
