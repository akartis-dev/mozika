part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class AudioResetList extends AudioEvent {}

class AudioAddFavorite extends AudioEvent {
  final AudioModels audioModels;
  const AudioAddFavorite(this.audioModels);
}
