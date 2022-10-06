import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain_layer/models/post/post.dart';
import '../../infrastructure_layer/infrastructure_providers.dart';

class PostController extends StateNotifier<Post> {
  PostController(this._read) : super(Post());

  final Reader _read;

  Future<void> fetchUserPost(String id) async {
    final post = await _read(postRepositoryProvider).fetchUserPost(id);

    state = state.copyWith(
        id: post.id,
        postUserId: "${post.postUserId}",
        postImage: post.postImage,
        title: post.title,
        content: post.content,
        likeCount: post.likeCount,
        createdAt: post.createdAt);
  }

  // 投稿内容の作成
  Future<void> createPost(
      String uid, String title, String content, File? image) async {
    if (title.isNotEmpty && content.isNotEmpty) {
      final docId = await _read(postRepositoryProvider).getCreatePostId();
      final folderName = "/post_images/";

      final imagePath = await _read(imageRepositoryProvider)
          .uploadImage(docId, folderName, image);

      final post = Post(
          id: docId,
          postUserId: uid,
          postImage: imagePath,
          title: title,
          content: content,
          likeCount: 0,
          createdAt: DateTime.now());
      await _read(postRepositoryProvider).createPost(post);
    } else {
      print("title & content & image is Empty");
    }
  }

  Future<void> setLike(post) async {
    final result = await _read(postRepositoryProvider).setLike(post);
    state = state.copyWith(
        id: result.id,
        postUserId: result.postUserId,
        postImage: result.postImage,
        title: result.title,
        content: result.content,
        likeCount: result.likeCount);
  }

  Future<void> deleteLike(post) async {
    final result = await _read(postRepositoryProvider).deleteLike(post);
    state = state.copyWith(
        id: result.id,
        postUserId: result.postUserId,
        postImage: result.postImage,
        title: result.title,
        content: result.content,
        likeCount: result.likeCount);
  }

  // 投稿内容の削除
  Future<void> deletePost(String uid, String postId) async {
    final folderName = "/post_images/";
    await _read(imageRepositoryProvider).deleteUploadImage(postId, folderName);
    await _read(postRepositoryProvider).deletePost(uid, postId);
  }

  // 全ての投稿内容の削除
  Future<void> deletePosts(String uid) async {
    final folderName = "/post_images/";
    final postIds = await _read(postRepositoryProvider).myPostIds(uid);
    final likeIds = await _read(postRepositoryProvider).myLikeIds(uid);

    await _read(postRepositoryProvider)
        .deletePosts(uid, postIds, likeIds, folderName);
  }
}
