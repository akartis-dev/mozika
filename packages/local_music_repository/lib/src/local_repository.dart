import 'dart:async';

import 'package:local_music_api/local_music_api.dart';
import 'package:local_music_repository/src/models/models.dart';
import 'package:rxdart/rxdart.dart';

import 'models/local_music.dart';

class LocalRepository extends LocalMusicRepositoryInterface {
  final _audioStreamCtr = BehaviorSubject<List<AudioModels>?>.seeded(null);
  final LocalMusicApi _providerData;

  LocalRepository() : _providerData = LocalMusicApi() {
    _init();
  }

  /// Init all audio list in stream
  void _init() async {
    List<AudioModels> lists = await _providerData.getAllAudioList();
    _audioStreamCtr.add(lists);
  }

  /// Get BehaviorSubjet stream
  @override
  Stream<List<AudioModels>?> getAllAudioList() {
    return _audioStreamCtr.asBroadcastStream();
  }

  /// Reset audio database
  /// Clear stream and add data
  @override
  Future<void> resetAudioDatabase() async {
    _audioStreamCtr.add(null);
    await _providerData.resetAudioTable();
    _init();
  }

  /// Get next song
  /// Fetch next song from stream list
  @override
  NextPrevAudioModels getNextSong(int current) {
    if (current + 1 > _audioStreamCtr.value!.length - 1) {
      return NextPrevAudioModels(0, _audioStreamCtr.value!.first);
    }

    return NextPrevAudioModels(
        current + 1, _audioStreamCtr.value!.elementAt(current + 1));
  }

  /// Get prev song
  /// Fetch prev song from stream list
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

  /// Add one song to favorite
  @override
  Future<bool> addFavoriteSong(AudioModels audio) async {
    List<AudioModels>? lists = _audioStreamCtr.value;

    if (lists != null) {
      int index = lists.indexOf(audio);

      AudioModels copyAudioInstance =
          audio.copyWith(favorite: audio.favoriteOpposite);

      lists[index] = copyAudioInstance;

      _audioStreamCtr.add(lists);
    }

    return await _providerData.setAudioToFavorite(audio);
  }
}
