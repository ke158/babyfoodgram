import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/convert_timestamp.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();
  const factory AppUser(
      {String? id,
      String? userId,
      String? userName,
      @Default('') String selfIntroduction,
      String? profileImage,
      @CreatedAtField() DateTime? createdAt,
      @UpdatedAtField() DateTime? updatedAt}) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  factory AppUser.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return AppUser.fromJson(data);
  }
}
