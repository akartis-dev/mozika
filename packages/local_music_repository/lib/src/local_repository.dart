import 'dart:async';

import 'package:local_music_api/local_music_api.dart';
import 'package:rxdart/rxdart.dart';

import 'models/local_music.dart';

class LocalRepository extends LocalMusicRepositoryInterface {
  final _audioStreamCtr = BehaviorSubject<List<AudioModels>>.seeded(const []);

  LocalRepository() {
    _init();
  }

  void _init() async {
    LocalMusicApi providerData = LocalMusicApi();
    List<AudioModels> lists = await providerData.getAllAudioList();
    _audioStreamCtr.add(lists);
  }

  @override
  Stream<List<AudioModels>> getAllAudioList() {
    return _audioStreamCtr.asBroadcastStream();
  }
}
