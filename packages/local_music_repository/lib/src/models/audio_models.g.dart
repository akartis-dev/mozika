// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioModelsRepository _$AudioModelsFromJson(Map<String, dynamic> json) =>
    AudioModelsRepository(
      id: json['id'] as int?,
      name: json['name'] as String,
      folder: json['folder'] as String,
      uriPath: json['uriPath'] as String,
    );

Map<String, dynamic> _$AudioModelsToJson(AudioModelsRepository instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'folder': instance.folder,
      'uriPath': instance.uriPath,
    };
