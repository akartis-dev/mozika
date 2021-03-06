import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_music_repository/local_music_repository.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioStates> {
  final LocalRepository _localRepository;

  AudioBloc({required LocalRepository localRepository})
      : _localRepository = localRepository,
        super(AudioStates(audios: localRepository.getAllAudioList())) {
    on<AudioResetList>(_onReset);
    on<AudioAddFavorite>(_onAddFavorite);
  }

  _onReset(AudioResetList event, Emitter<AudioStates> emit) {
    _localRepository.resetAudioDatabase();
  }

  _onAddFavorite(AudioAddFavorite event, Emitter<AudioStates> emit) {
    _localRepository.addFavoriteSong(event.audioModels);
  }
}
