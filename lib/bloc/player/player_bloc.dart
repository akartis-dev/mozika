import 'package:audio_manager/audio_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(const PlayerState()) {
    on<PlayerPlay>(_onPlayerPlay);
    on<PlayerChangeProperty>(_onPlayerChangeProperty);
    on<PlayerChangeSlider>(_onPlayerChangeSlider);
    on<PlayerReadyTitle>(_onPlayerReadyTitle);
  }

  /// Listen all audio player event
  void _onPlayerPlay(PlayerPlay event, Emitter<PlayerState> emit) {
    AudioManager.instance.onEvents((events, args) {
      switch (events) {
        case AudioManagerEvents.ready:
          add(PlayerReadyTitle(AudioManager.instance.info?.title ?? ""));
          add(PlayerChangeProperty(
              AudioManager.instance.duration, AudioManager.instance.position));
          break;
        case AudioManagerEvents.timeupdate:
          add(PlayerChangeProperty(
              AudioManager.instance.duration, AudioManager.instance.position));
          break;
        case AudioManagerEvents.ended:
          AudioManager.instance.next();
          break;
      }
    });
  }

  /// Update duration and position state from audio player
  void _onPlayerChangeProperty(
      PlayerChangeProperty event, Emitter<PlayerState> emit) {
    emit(state.copyWith(duration: event.duration, position: event.position));
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
}
