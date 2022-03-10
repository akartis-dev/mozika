import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/media_information.dart';
import 'package:mozika/model/interface/audio_custom_info.dart';

class AudioService {
  /// Play music in audio manager
  static void playMusicInAudioManager(
      {required String uri, required String name}) {
    AudioManager.instance.file(File(uri), name,
        desc: "", cover: 'assets/images/photo1.jpeg', auto: true);
  }

  /// Format audio duration
  static String formatAudioDuration(Duration d) {
    if (d == null) return "--:--";

    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  static Future<AudioCustomInfo> getAudioInformation(String uriPath) async {
    final FlutterFFprobe _flutterFFprobe = new FlutterFFprobe();
    MediaInformation info = await _flutterFFprobe.getMediaInformation(uriPath);
    // print(info.getMediaProperties());
    return AudioCustomInfo(
        artist: info.getMediaProperties()?['tags']?['artist'],
        duration: info.getMediaProperties()?['duration'],
        title: info.getMediaProperties()?['tags']?['title']);
  }
}
