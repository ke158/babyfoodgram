import '../../../models/post/post.dart';

abstract class PostStreamRepository {
  Stream<List<Post>> fetchPosts();
  Stream<Post> fetchMyPost(String id);
  Stream<Post> fetchMyLike(String id);
}
