import '../../../models/user/user.dart';

abstract class UserStreamRepository {
  Stream<List<AppUser>> fetchUsers();
  Stream<List<String>> myPostIds(String uid);
  Stream<List<String>> myLikeIds(String uid);
  Stream<bool> isFavorite(String uid, String postId);
  Stream<AppUser> fetchUser(String postUserId);
}
