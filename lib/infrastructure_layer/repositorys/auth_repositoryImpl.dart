import 'package:firebase_auth/firebase_auth.dart';

import '../../domain_layer/interfaces/repository/auth_repository.dart';
import '../../utils/custom_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;
// CurrentUser情報の取得
  @override
  User? getCurrentUser() {
    try {
      return _firebaseAuth.currentUser;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

//ログイン
  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// ログアウト
  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 登録
  @override
  Future<User?> signUp(String email, String password) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 削除
  @override
  Future<void> deleteAuth(String uid) async {
    try {
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
