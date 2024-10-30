// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turnament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TurnamentModelImpl _$$TurnamentModelImplFromJson(Map<String, dynamic> json) =>
    _$TurnamentModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$TurnamentModelImplToJson(
        _$TurnamentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date,
      'imageUrl': instance.imageUrl,
    };
