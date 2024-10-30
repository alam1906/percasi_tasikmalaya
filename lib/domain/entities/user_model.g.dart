// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      uid: json['uid'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      role: json['role'] as String,
      rating: (json['rating'] as num).toInt(),
      clubId: json['clubId'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'role': instance.role,
      'rating': instance.rating,
      'clubId': instance.clubId,
      'imageUrl': instance.imageUrl,
    };
