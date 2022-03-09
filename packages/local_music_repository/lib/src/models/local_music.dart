import 'package:local_music_api/local_music_api.dart';

import 'next_prev_audio_models.dart';

abstract class LocalMusicRepositoryInterface {
  final audioStreamController = null; //BehaviorSubject
  LocalMusicRepositoryInterface();

  Stream<List<AudioModels>?> getAllAudioList();

  Future<void> resetAudioDatabase();

  NextPrevAudioModels getNextSong(int current);

  NextPrevAudioModels getPrevSong(int current);
}
