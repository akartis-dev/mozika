import 'package:local_music_api/local_music_api.dart';

abstract class LocalMusicRepositoryInterface {
  final audioStreamController = null; //BehaviorSubject
  LocalMusicRepositoryInterface();

  Stream<List<AudioModels>> getAllAudioList();
}
