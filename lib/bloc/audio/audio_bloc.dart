import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_music_repository/local_music_repository.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioStates> {
  final LocalRepository _localRepository;

  AudioBloc({required LocalRepository localRepository})
      : _localRepository = localRepository,
        super(AudioInitial(localRepository.getAllAudioList())) {
    on<AudioListStarted>(_onInit);
    on<AudioResetList>(_onReset);
  }

  _onInit(AudioListStarted event, Emitter<AudioStates> emit) {
    Stream<List<AudioModels>?> stream = _localRepository.getAllAudioList();

    emit(AudioHydrate(stream));
  }

  _onReset(AudioResetList event, Emitter<AudioStates> emit) {
    _localRepository.resetAudioDatabase();
  }
}
