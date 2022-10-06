abstract class LikeRepository {
  Future<void> setLike(String uid, String likeId);

  Future<void> deleteLike(String uid, String likeId);
}
