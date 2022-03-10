import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_models.g.dart';

@JsonSerializable()
class AudioModels extends Equatable {
  final int? id;
  final String name;
  final String folder;
  final String uriPath;
  final int favorite;

  const AudioModels(
      {this.id,
      required this.name,
      required this.folder,
      required this.uriPath,
      this.favorite = 0});

  static AudioModels fromJson(Map<String, dynamic> json) =>
      _$AudioModelsFromJson(json);

  Map<String, dynamic> toJson() => _$AudioModelsToJson(this);

  bool get favoriteBool => favorite == 1;

  int get favoriteOpposite => favorite == 1 ? 0 : 1;

  set favorite(int favorite) {
    this.favorite = favorite;
  }

  AudioModels copyWith(
      {String? name, String? folder, String? uriPath, int? favorite}) {
    return AudioModels(
        name: name ?? this.name,
        folder: folder ?? this.folder,
        uriPath: uriPath ?? this.uriPath,
        favorite: favorite ?? this.favorite);
  }

  @override
  List<Object?> get props => [id, name, folder, uriPath, favorite];
}
