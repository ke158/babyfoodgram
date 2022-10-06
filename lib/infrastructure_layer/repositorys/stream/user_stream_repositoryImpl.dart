import 'package:babyfoodgram/domain_layer/extensions/user_ref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain_layer/domain_providers.dart';
import '../../../domain_layer/interfaces/repository/stream/user_stream_repository.dart';
import '../../../domain_layer/models/user/user.dart';
import '../../../utils/custom_exception.dart';

class UserStreamRepositoryImpl implements UserStreamRepository {
  final Reader _read;
  const UserStreamRepositoryImpl(this._read);

  @override
  Stream<List<AppUser>> fetchUsers() {
    try {
      return _read(firebaseFirestoreProvider)
          .usersRef()
          .snapshots()
          .map((snapshot) {
        final list = snapshot.docs.map((doc) {
          final jsonObject = AppUser.fromJson(doc.data());
          return jsonObject;
        }).toList();
        return list;
      });
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Stream<AppUser> fetchUser(String postAccountId) {
    try {
      return _read(firebaseFirestoreProvider)
          .myUsersRef(postAccountId)
          .snapshots()
          .map((docs) {
        return AppUser.fromDocument(docs);
      });
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Stream<List<String>> myPostIds(String uid) {
    try {
      return _read(firebaseFirestoreProvider)
          .myPostRef(uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.id;
        }).toList();
      });
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Stream<List<String>> myLikeIds(String uid) {
    try {
      return _read(firebaseFirestoreProvider)
          .myLikesRef(uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return doc.id;
        }).toList();
      });
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Stream<bool> isFavorite(String uid, String postId) {
    try {
      return _read(firebaseFirestoreProvider)
          .myLikesRef(uid)
          .doc(postId)
          .snapshots()
          .map((docs) {
        if (docs.data() != null) {
          return true;
        } else {
          return false;
        }
      });
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
