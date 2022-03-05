part of 'audio_bloc.dart';

abstract class AudioStates extends Equatable {
  final Stream<List<AudioModels>?> audios;
  const AudioStates(this.audios);

  @override
  List<Object> get props => [];
}

class AudioInitial extends AudioStates {
  AudioInitial(Stream<List<AudioModels>?> stream) : super(stream) {
    // print(stream);
    // stream.listen(print);
  }
}

class AudioHydrate extends AudioStates {
  const AudioHydrate(Stream<List<AudioModels>?> stream) : super(stream);
}
