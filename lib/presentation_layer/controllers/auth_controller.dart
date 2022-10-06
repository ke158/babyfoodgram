import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure_layer/infrastructure_providers.dart';

class AuthController extends StateNotifier<User?> {
  final Reader _read;

  AuthController(this._read) : super(null);

  @override
  User? get state => _read(authRepositoryProvider).getCurrentUser();

  Future<void> signIn(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      await _read(authRepositoryProvider).signIn(email, password);

      final user = await _read(authRepositoryProvider).getCurrentUser();
      if (user != null) {
        state = user;
      }
    } else {
      print("メールアドレスまたはパスワードが入力されていません");
    }
  }

  Future<User?> signUp(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      return await _read(authRepositoryProvider).signUp(email, password);
    } else {
      print("メールアドレスまたはパスワードが入力されていません");
      return null;
    }
  }

  Future<void> signOut() async {
    await _read(authRepositoryProvider).signOut();
  }
}
