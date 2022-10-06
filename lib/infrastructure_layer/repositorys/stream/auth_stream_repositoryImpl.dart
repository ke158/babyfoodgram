import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain_layer/domain_providers.dart';
import '../../../domain_layer/interfaces/repository/stream/auth_stream_repository.dart';

class AuthStreamRepositoryImpl implements AuthStreamRepository {
  final Reader _read;
  const AuthStreamRepositoryImpl(this._read);

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();
}
