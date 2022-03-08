part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final Duration duration;
  final Duration position;
  final String title;

  const PlayerState(
      {this.duration = const Duration(milliseconds: 0),
      this.position = const Duration(milliseconds: 0),
      this.title = ""});

  PlayerState copyWith(
      {Duration? duration, Duration? position, String? title}) {
    return PlayerState(
        duration: duration ?? this.duration,
        position: position ?? this.position,
        title: title ?? this.title);
  }

  @override
  List<Object> get props => [duration, position, title];
}
