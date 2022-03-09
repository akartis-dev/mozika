part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class PlayerPlay extends PlayerEvent {}

class PlayerChangeProperty extends PlayerEvent {
  final Duration duration;
  final Duration position;

  const PlayerChangeProperty(this.duration, this.position);
}

class PlayerPause extends PlayerEvent {
  final bool play;

  const PlayerPause(this.play);
}

class PlayerChangeSlider extends PlayerEvent {
  final double value;

  const PlayerChangeSlider(this.value);
}

class PlayerReadyTitle extends PlayerEvent {
  final String title;

  const PlayerReadyTitle(this.title);
}

class PlayerNext extends PlayerEvent {}

class PlayerPrevious extends PlayerEvent {}

class PlayerCurrentPlaying extends PlayerEvent {
  final int id;

  const PlayerCurrentPlaying(this.id);
}
