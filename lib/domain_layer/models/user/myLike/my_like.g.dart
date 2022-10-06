// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyLike _$$_MyLikeFromJson(Map<String, dynamic> json) => _$_MyLike(
      postUserId: json['postUserId'] as String,
      likesPostId: json['likesPostId'] as String,
      createdAt: const CreatedAtField().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$_MyLikeToJson(_$_MyLike instance) => <String, dynamic>{
      'postUserId': instance.postUserId,
      'likesPostId': instance.likesPostId,
      'createdAt': const CreatedAtField().toJson(instance.createdAt),
    };
