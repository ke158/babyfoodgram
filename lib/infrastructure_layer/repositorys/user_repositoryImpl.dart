import 'package:babyfoodgram/domain_layer/extensions/user_ref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain_layer/domain_providers.dart';
import '../../domain_layer/interfaces/repository/user_repository.dart';
import '../../domain_layer/models/user/user.dart';
import '../../utils/custom_exception.dart';
import '../infrastructure_providers.dart';

class UserRepositoryImpl implements UserRepository {
  final Reader _read;
  const UserRepositoryImpl(this._read);

//ユーザー情報の検索
  @override
  Future<AppUser> fetchUser(String uid) async {
    try {
      final docs = await _read(firebaseFirestoreProvider).myUsersRef(uid).get();
      final data = docs.data();
      return AppUser.fromJson(data!);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// ユーザー情報を作成
  @override
  Future<void> createUser(AppUser user) async {
    try {
      await _read(firebaseFirestoreProvider)
          .usersRef()
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// ユーザー情報の編集
  @override
  Future<void> updateUser(AppUser user) async {
    try {
      await _read(firebaseFirestoreProvider)
          .usersRef()
          .doc(user.id)
          .update(user.toJson());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// ユーザー情報の削除
  @override
  Future<void> deleteUser(
      String uid, String postFileName, String userFileName) async {
    try {
      // 投稿IDsを取得
      final postIds = await _read(postRepositoryProvider).myPostIds(uid);
      final likeIds = await _read(postRepositoryProvider).myLikeIds(uid);

      if (postIds != []) {
        // 投稿削除
        await _read(postRepositoryProvider)
            .deletePosts(uid, postIds, likeIds, postFileName);
      }
      // イメージ削除
      await _read(imageRepositoryProvider).deleteUploadImage(uid, userFileName);
      // ユーザー削除
      await _read(firebaseFirestoreProvider).myUsersRef(uid).delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
