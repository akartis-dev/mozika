import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_models.g.dart';

@JsonSerializable()
class AudioModels extends Equatable {
  final int? id;
  final String name;
  final String folder;
  final String uriPath;

  const AudioModels(
      {this.id,
      required this.name,
      required this.folder,
      required this.uriPath});

  static AudioModels fromJson(Map<String, dynamic> json) =>
      _$AudioModelsFromJson(json);

  Map<String, dynamic> toJson() => _$AudioModelsToJson(this);

  @override
  List<Object?> get props => [id, name, folder, uriPath];
}
