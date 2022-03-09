part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final Duration duration;
  final Duration position;
  final String title;
  final bool isPlay;
  final int idPlaying;

  const PlayerState(
      {this.duration = const Duration(milliseconds: 0),
      this.position = const Duration(milliseconds: 0),
      this.title = "",
      this.isPlay = false,
      this.idPlaying = 0});

  PlayerState copyWith(
      {Duration? duration,
      Duration? position,
      String? title,
      bool? isPlay,
      int? idPlaying}) {
    return PlayerState(
        duration: duration ?? this.duration,
        position: position ?? this.position,
        title: title ?? this.title,
        isPlay: isPlay ?? this.isPlay,
        idPlaying: idPlaying ?? this.idPlaying);
  }

  @override
  List<Object> get props => [duration, position, title, isPlay, idPlaying];
}
