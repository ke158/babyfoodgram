import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../../utils/convert_timestamp.dart';

part 'my_post.freezed.dart';
part 'my_post.g.dart';

@freezed
class MyPost with _$MyPost {
  const MyPost._();
  const factory MyPost(
      {
        required String postUserId,
        required String postId,
      @CreatedAtField() DateTime? createdAt}) = _MyPost;

  factory MyPost.fromJson(Map<String, dynamic> json) => _$MyPostFromJson(json);

  factory MyPost.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return MyPost.fromJson(data);
  }
}