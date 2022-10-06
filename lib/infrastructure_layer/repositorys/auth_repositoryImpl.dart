import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain_layer/domain_providers.dart';
import '../../domain_layer/interfaces/repository/auth_repository.dart';
import '../../utils/custom_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Reader _read;
  const AuthRepositoryImpl(this._read);

// CurrentUser情報の取得
  @override
  User? getCurrentUser() {
    try {
      return _read(firebaseAuthProvider).currentUser;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

//ログイン
  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _read(firebaseAuthProvider)
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// ログアウト
  @override
  Future<void> signOut() async {
    try {
      await _read(firebaseAuthProvider).signOut();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 登録
  @override
  Future<User?> signUp(String email, String password) async {
    try {
      final result = await _read(firebaseAuthProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 削除
  @override
  Future<void> deleteAuth(String uid) async {
    try {
      await _read(firebaseAuthProvider).currentUser!.delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
