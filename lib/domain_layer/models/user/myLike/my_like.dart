import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../../../utils/convert_timestamp.dart';

part 'my_like.freezed.dart';
part 'my_like.g.dart';

@freezed
class MyLike with _$MyLike {
  const MyLike._();
  const factory MyLike(
      {required String postUserId,
      required String likesPostId,
      @CreatedAtField() DateTime? createdAt}) = _MyLike;

  factory MyLike.fromJson(Map<String, dynamic> json) => _$MyLikeFromJson(json);

  factory MyLike.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return MyLike.fromJson(data);
  }
}
