// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewsModelImpl _$$NewsModelImplFromJson(Map<String, dynamic> json) =>
    _$NewsModelImpl(
      id: json['id'] as String,
      date: json['date'] as String,
      dateTime: json['dateTime'] as String,
      description: json['description'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$NewsModelImplToJson(_$NewsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'dateTime': instance.dateTime,
      'description': instance.description,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };
