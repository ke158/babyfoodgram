import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStreamRepository {
  Stream<User?> get authStateChanges;
}
