import 'dart:async';

import 'package:local_music_api/local_music_api.dart';
import 'package:local_music_repository/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

import 'models/local_music.dart';

class LocalRepository extends LocalMusicRepositoryInterface {
  final _audioStreamCtr = BehaviorSubject<List<AudioModels>?>.seeded(null);
  LocalMusicApi _providerData;

  LocalRepository() : _providerData = LocalMusicApi() {
    _init();
  }

  void _init() async {
    List<AudioModels> lists = await _providerData.getAllAudioList();
    _audioStreamCtr.add(lists);
  }

  @override
  Stream<List<AudioModels>?> getAllAudioList() {
    return _audioStreamCtr.asBroadcastStream();
  }

  @override
  Future<void> resetAudioDatabase() async {
    _audioStreamCtr.add(null);
    await _providerData.resetAudioTable();
    _init();
  }

  @override
  NextPrevAudioModels getNextSong(int current) {
    if (current + 1 > _audioStreamCtr.value!.length - 1) {
      return NextPrevAudioModels(0, _audioStreamCtr.value!.first);
    }

    return NextPrevAudioModels(
        current + 1, _audioStreamCtr.value!.elementAt(current + 1));
  }

  @override
  NextPrevAudioModels getPrevSong(int current) {
    if (current - 1 < 0) {
      return NextPrevAudioModels(
          _audioStreamCtr.value!.length - 1, _audioStreamCtr.value!.last);
      ;
    }

    return NextPrevAudioModels(
        current - 1, _audioStreamCtr.value!.elementAt(current - 1));
  }
}
