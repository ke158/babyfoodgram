// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      id: json['id'] as String?,
      postUserId: json['postUserId'] as String?,
      postImage: json['postImage'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      likeCount: json['likeCount'] as int? ?? 0,
      createdAt: const CreatedAtField().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'postUserId': instance.postUserId,
      'postImage': instance.postImage,
      'title': instance.title,
      'content': instance.content,
      'likeCount': instance.likeCount,
      'createdAt': const CreatedAtField().toJson(instance.createdAt),
    };
