import '../../models/post/post.dart';

abstract class PostRepository {
  Future<String> getCreatePostId();
  Future<Post> fetchUserPost(String id);

  Future<List<String>> myPostIds(String uid);
  Future<List<String>> myLikeIds(String uid);
  Future<List<Post>> myPosts(List<String> id);

  Future<void> createPost(Post post);
  Future<void> deletePost(String uid, String postId);

  Future<Post> setLike(Post post);
  Future<Post> deleteLike(Post post);

  Future<void> deletePosts(String uid, List<String> postIds,
      List<String> likeIds, String folderName);
}
