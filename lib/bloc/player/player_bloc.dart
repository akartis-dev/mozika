import 'package:audio_manager/audio_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_music_repository/local_music_repository.dart';
import 'package:mozika/services/audio_service.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final LocalRepository localRepository;

  PlayerBloc(LocalRepository _localRepository)
      : localRepository = _localRepository,
        super(const PlayerState()) {
    on<PlayerPlay>(_onPlayerPlay);
    on<PlayerChangeProperty>(_onPlayerChangeProperty);
    on<PlayerChangeSlider>(_onPlayerChangeSlider);
    on<PlayerReadyTitle>(_onPlayerReadyTitle);
    on<PlayerPause>(_onPlayerPause);
    on<PlayerNext>(_onPlayerNext);
    on<PlayerPrevious>(_onPlayerPrevious);
    on<PlayerCurrentPlaying>(_onPlayerCurrentPlaying);
  }

  /// Listen all audio player event
  void _onPlayerPlay(PlayerPlay event, Emitter<PlayerState> emit) {
    AudioManager.instance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.ready:
          add(PlayerReadyTitle(AudioManager.instance.info?.title ?? ""));
          add(PlayerChangeProperty(
              AudioManager.instance.duration, AudioManager.instance.position));
          add(const PlayerPause(false));
          break;
        case AudioManagerEvents.timeupdate:
          if (state.title != AudioManager.instance.info?.title) {
            add(PlayerReadyTitle(AudioManager.instance.info?.title ?? ""));
          }
          add(PlayerChangeProperty(
              AudioManager.instance.duration, AudioManager.instance.position));
          break;
        case AudioManagerEvents.ended:
          add(PlayerNext());
          break;
        case AudioManagerEvents.playstatus:
          add(PlayerPause(AudioManager.instance.isPlaying));
          break;
      }
    });
  }

  /// Update duration and position state from audio player
  void _onPlayerChangeProperty(
      PlayerChangeProperty event, Emitter<PlayerState> emit) {
    emit(state.copyWith(
      duration: event.duration,
      position: event.position,
    ));
  }

  /// Handle slider change
  void _onPlayerChangeSlider(
      PlayerChangeSlider event, Emitter<PlayerState> emit) {
    Duration msec = Duration(
        milliseconds: (state.duration.inMilliseconds * event.value).round());
    emit(state.copyWith(position: msec));
    AudioManager.instance.seekTo(msec);
  }

  /// Save music title
  void _onPlayerReadyTitle(PlayerReadyTitle event, Emitter<PlayerState> emit) {
    emit(state.copyWith(title: event.title));
  }

  /// When player pause
  void _onPlayerPause(PlayerPause event, Emitter<PlayerState> emit) {
    emit(state.copyWith(isPlay: event.play));
  }

  void _onPlayerNext(PlayerNext event, Emitter<PlayerState> emit) {
    NextPrevAudioModels next = localRepository.getNextSong(state.idPlaying);
    AudioService.playMusicInAudioManager(
        uri: next.audio.uriPath, name: next.audio.name);
    add(PlayerCurrentPlaying(next.id));
  }

  void _onPlayerPrevious(PlayerPrevious event, Emitter<PlayerState> emit) {
    NextPrevAudioModels prev = localRepository.getPrevSong(state.idPlaying);
    AudioService.playMusicInAudioManager(
        uri: prev.audio.uriPath, name: prev.audio.name);
    add(PlayerCurrentPlaying(prev.id));
  }

  void _onPlayerCurrentPlaying(
      PlayerCurrentPlaying event, Emitter<PlayerState> emit) {
    emit(state.copyWith(idPlaying: event.id));
  }
}
