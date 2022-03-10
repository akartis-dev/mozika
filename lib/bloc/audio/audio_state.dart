part of 'audio_bloc.dart';

class AudioStates extends Equatable {
  final Stream<List<AudioModels>?> audios;
  const AudioStates({required this.audios});

  AudioStates copyWith(Stream<List<AudioModels>?>? audios) {
    return AudioStates(audios: audios ?? this.audios);
  }

  @override
  List<Object> get props => [audios];
}
