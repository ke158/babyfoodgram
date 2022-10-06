import '../../models/user/user.dart';

abstract class UserRepository {
  Future<AppUser> fetchUser(String uid);
  Future<void> createUser(AppUser user);
  Future<void> updateUser(AppUser user);
  Future<void> deleteUser(
      String uid, String postFileName, String userFileName);
}
