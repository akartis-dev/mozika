// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioModels _$AudioModelsFromJson(Map<String, dynamic> json) => AudioModels(
      id: json['id'] as int?,
      name: json['name'] as String,
      folder: json['folder'] as String,
      uriPath: json['uriPath'] as String,
      favorite: json['favorite'] as int? ?? 0,
    );

Map<String, dynamic> _$AudioModelsToJson(AudioModels instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'folder': instance.folder,
      'uriPath': instance.uriPath,
      'favorite': instance.favorite,
    };
