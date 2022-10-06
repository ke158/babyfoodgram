import 'package:babyfoodgram/domain_layer/extensions/post_ref.dart';
import 'package:babyfoodgram/domain_layer/extensions/user_ref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain_layer/domain_providers.dart';
import '../../domain_layer/interfaces/repository/post_repository.dart';
import '../../domain_layer/models/post/post.dart';
import '../../domain_layer/models/user/myPost/my_post.dart';
import '../../utils/custom_exception.dart';

class PostRepositoryImpl implements PostRepository {
  final Reader _read;
  const PostRepositoryImpl(this._read);

// 投稿するIDの取得
  @override
  Future<String> getCreatePostId() async {
    try {
      final _id = await _read(firebaseFirestoreProvider).postsRef().doc().id;
      return _id;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 投稿した内容を取得
  @override
  Future<Post> fetchUserPost(String id) async {
    try {
      final docs =
          await _read(firebaseFirestoreProvider).userPostsRef(id).get();
      final data = docs.data();
      return Post.fromJson(data!);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 投稿内容の作成
  @override
  Future<void> createPost(Post post) async {
    try {
      // postに登録
      await _read(firebaseFirestoreProvider)
          .userPostsRef("${post.id}")
          .set(post.toJson());

      // myPostに登録
      await _read(firebaseFirestoreProvider)
          .myPostRef("${post.postUserId}")
          .doc(post.id)
          .set(MyPost(
                  postUserId: "${post.postUserId}",
                  postId: post.id!,
                  createdAt: post.createdAt)
              .toJson());
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 投稿したIDsをリストで取得
  @override
  Future<List<String>> myPostIds(String uid) async {
    try {
      final snapshot =
          await _read(firebaseFirestoreProvider).myPostRef(uid).get();
      final list = snapshot.docs.map((doc) {
        return doc.id;
      }).toList();
      return list;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// likeしたIDsをリストで取得
  @override
  Future<List<String>> myLikeIds(String uid) async {
    try {
      final snapshot =
          await _read(firebaseFirestoreProvider).myLikesRef(uid).get();
      final list = snapshot.docs.map((doc) {
        return doc.id;
      }).toList();
      return list;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// IDsから投稿内容をリストで取得
  @override
  Future<List<Post>> myPosts(List<String> ids) async {
    try {
      List<Post> postList = [];
      ids.forEach((id) async {
        final docs =
            await _read(firebaseFirestoreProvider).userPostsRef(id).get();
        final post = Post.fromDocument(docs);
        postList.add(post);
      });
      return postList;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 投稿内容の削除
  @override
  Future<void> deletePost(String uid, String postId) async {
    try {
      await _read(firebaseFirestoreProvider)
          .myPostRef(uid)
          .doc(postId)
          .delete();
      await _read(firebaseFirestoreProvider).postsRef().doc(postId).delete();

      await _read(firebaseFirestoreProvider)
          .myLikesRef(uid)
          .doc(postId)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// 全ての投稿内容の削除
  @override
  Future<void> deletePosts(String uid, List<String> postIds,
      List<String> likeIds, String folderName) async {
    try {
      if (postIds != []) {
        postIds.forEach((postId) async {
          // postの画像の削除
          await _read(firebaseStorageProvider)
              .ref(folderName)
              .child(postId)
              .delete();
          // postIdの削除
          await _read(firebaseFirestoreProvider)
              .myPostRef(uid)
              .doc(postId)
              .delete();
          // postの削除
          await _read(firebaseFirestoreProvider).userPostsRef(postId).delete();
        });
      }
      if (likeIds != []) {
        likeIds.forEach((likeId) async {
          final docs = await _read(firebaseFirestoreProvider)
              .postsRef()
              .doc(likeId)
              .get();
          final data = docs.data();
          final post = Post.fromJson(data!);
          await _read(firebaseFirestoreProvider).userPostsRef("${post.id}").set(
              Post(
                      id: post.id,
                      postUserId: "${post.postUserId}",
                      postImage: post.postImage,
                      title: post.title,
                      content: post.content,
                      likeCount: post.likeCount - 1)
                  .toJson());
          // likeIdの削除
          await _read(firebaseFirestoreProvider)
              .myLikesRef(uid)
              .doc(likeId)
              .delete();
        });
      }
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

// いいねを押した時の処理
  @override
  Future<Post> setLike(Post post) async {
    try {
      // likeした投稿のカウントをを保存
      await _read(firebaseFirestoreProvider).userPostsRef("${post.id}").set(
          Post(
                  id: post.id,
                  postUserId: "${post.postUserId}",
                  postImage: post.postImage,
                  title: post.title,
                  content: post.content,
                  likeCount: post.likeCount + 1,
                  createdAt: post.createdAt)
              .toJson());

      final docs =
          await _read(firebaseFirestoreProvider).postsRef().doc(post.id).get();
      final data = docs.data();
      return Post.fromJson(data!);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<Post> deleteLike(Post post) async {
    try {
      await _read(firebaseFirestoreProvider).userPostsRef("${post.id}").set(
          Post(
                  id: post.id,
                  postUserId: "${post.postUserId}",
                  postImage: post.postImage,
                  title: post.title,
                  content: post.content,
                  likeCount: post.likeCount - 1,
                  createdAt: post.createdAt)
              .toJson());

      final docs =
          await _read(firebaseFirestoreProvider).postsRef().doc(post.id).get();
      final data = docs.data();
      return Post.fromJson(data!);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
