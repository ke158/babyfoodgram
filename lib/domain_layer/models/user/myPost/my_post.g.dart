// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyPost _$$_MyPostFromJson(Map<String, dynamic> json) => _$_MyPost(
      postUserId: json['postUserId'] as String,
      postId: json['postId'] as String,
      createdAt: const CreatedAtField().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$_MyPostToJson(_$_MyPost instance) => <String, dynamic>{
      'postUserId': instance.postUserId,
      'postId': instance.postId,
      'createdAt': const CreatedAtField().toJson(instance.createdAt),
    };
