import 'package:babyfoodgram/domain_layer/domain_providers.dart';
import 'package:babyfoodgram/domain_layer/extensions/user_ref.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain_layer/interfaces/repository/like_repository.dart';
import '../../domain_layer/models/user/myLike/my_like.dart';
import '../../utils/custom_exception.dart';

class LikeRepositoryImpl implements LikeRepository {
  final Reader _read;
  const LikeRepositoryImpl(this._read);

  @override
  Future<void> setLike(String uid, String likeId) async {
    try {
      // 登録処理
      await _read(firebaseFirestoreProvider).myLikesRef(uid).doc(likeId).set(
          MyLike(
                  postUserId: uid,
                  likesPostId: likeId,
                  createdAt: DateTime.now())
              .toJson());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteLike(String uid, String likeId) async {
    try {
      // 削除処理
      await _read(firebaseFirestoreProvider)
          .myLikesRef(uid)
          .doc(likeId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
