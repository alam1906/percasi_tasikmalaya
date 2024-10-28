// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubModelImpl _$$ClubModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      fullName: json['fullName'] as String,
      hasLeader: json['hasLeader'] as bool,
      member: (json['member'] as num).toInt(),
      prestasi: (json['prestasi'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      listImageUrl: json['listImageUrl'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ClubModelImplToJson(_$ClubModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fullName': instance.fullName,
      'hasLeader': instance.hasLeader,
      'member': instance.member,
      'prestasi': instance.prestasi,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'listImageUrl': instance.listImageUrl,
    };
