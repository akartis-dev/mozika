import 'package:local_music_api/src/models/models.dart';

abstract class LocalMusic {
  final String storagePath = "";
  final List<String> excludePath = [];

  LocalMusic();

  Stream<AudioModels> _allAudioList();

  Future<List<AudioModels>> getAllAudioList();
}
