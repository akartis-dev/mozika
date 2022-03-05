part of 'audio_bloc.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class AudioListStarted extends AudioEvent {}

class AudioResetList extends AudioEvent {}
