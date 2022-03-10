import 'package:local_music_api/src/models/models.dart';

abstract class LocalMusic {
  final String storagePath = "";
  final List<String> excludePath = [];

  LocalMusic();

  Future<List<AudioModels>> _allAudioList();

  Future<List<AudioModels>> getAllAudioList();

  Future<bool> resetAudioTable();

  Future<bool> setAudioToFavorite(AudioModels audio);
}
