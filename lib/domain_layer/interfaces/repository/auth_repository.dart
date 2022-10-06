import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<void> signIn(String email, String password);
  Future<User?> signUp(String email, String password);
  User? getCurrentUser();
  Future<void> signOut();
  Future<void> deleteAuth(String uid);
}
