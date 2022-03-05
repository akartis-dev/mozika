import 'dart:async';

import 'package:local_music_api/local_music_api.dart';
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
}
