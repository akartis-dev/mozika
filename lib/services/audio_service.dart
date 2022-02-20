import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:mozika/model/database/db_sqlite.dart';
import 'package:mozika/model/entity/audio_model.dart';
import 'package:mozika/utils/audio_utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class AudioService {
  final String storagePath = "/storage/emulated/0/";
  final List<String> excludePath = [
    "/storage/emulated/0/Android",
    "/storage/emulated/0/Sound",
    "/storage/emulated/0/."
  ];

  /// Search all audio in storage
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

  /// Create a audio file and add into
  /// audiomanager instance
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

  /// Save one audio file in database
  /// Manipulate audio file to get parent
  /// Get audio name without extension
  Future<int> saveAudioFileInDb(
      {required String filePath, required String uri}) async {
    File file = File(filePath);
    final String parent =
        file.parent.path.replaceAll(RegExp(r'\/storage\/emulated\/0\/'), '');
    final String name = basenameWithoutExtension(file.path);

    Audio audio = Audio(name: name, folder: parent, uriPath: uri);
    final db = await DatabaseInstance.createInstance();
    return await db.insert('audio', audio.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Map all audio file and save in database
  Future<void> saveAllAudioInDatabase() async {
    List allAudio = await AudioUtils().getAllAudioFiles();

    for (var audioInfo in allAudio) {
      await saveAudioFileInDb(
          filePath: audioInfo['title'], uri: audioInfo['url']);
    }
  }

  Future<List<Audio>> getAllAudio() async {
    final db = await DatabaseInstance.createInstance();

    final List<Map<String, dynamic>> data = await db.query('audio');

    return List.generate(
        data.length,
        (i) => Audio(
            id: data[i]['id'],
            name: data[i]['name'],
            folder: data[i]['folder'],
            uriPath: data[i]['uri_path']));
  }
}
