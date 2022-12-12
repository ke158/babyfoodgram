import 'package:babyfoodgram/domain_layer/domain_providers.dart';
import 'package:babyfoodgram/infrastructure_layer/repositorys/auth_repositoryImpl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../presentation_layer/presentation_providers.dart';
import 'repositorys/image_repositoryImpl.dart';
import 'repositorys/like_repositoryImpl.dart';
import 'repositorys/post_repositoryImpl.dart';
import 'repositorys/stream/auth_stream_repositoryImpl.dart';
import 'repositorys/stream/post_stream_repositoryImpl.dart';
import 'repositorys/stream/user_stream_repositoryImpl.dart';
import 'repositorys/user_repositoryImpl.dart';

// Auth
final authRepositoryProvider = Provider.autoDispose<AuthRepositoryImpl>(
    (ref) => AuthRepositoryImpl(firebaseAuth: ref.read(firebaseAuthProvider)));

final authStreamRepositoryProvider = Provider<AuthStreamRepositoryImpl>(
    (ref) => AuthStreamRepositoryImpl(ref.read));

final authStreamProvider = StreamProvider.autoDispose((ref) {
  ref.onDispose(() => print('authStreamProvider dispose'));
  return ref.watch(authStreamRepositoryProvider).authStateChanges;
});

// AppUser
final userRepositoryProvider = Provider.autoDispose<UserRepositoryImpl>((ref) {
  ref.onDispose(() => print('userRepositoryProvider dispose'));
  return UserRepositoryImpl(ref.read);
});

final userStreamRepositoryProvider =
    Provider.autoDispose<UserStreamRepositoryImpl>((ref) {
  ref.onDispose(() => print('userStreamRepositoryProvider dispose'));
  return UserStreamRepositoryImpl(ref.read);
});

final userStreamProvider =
    StreamProvider.family.autoDispose((ref, String postUserId) {
  print('userStreamProvider init');
  ref.onDispose(() => print('userStreamProvider dispose'));
  return ref.watch(userStreamRepositoryProvider).fetchUser(postUserId);
});

final myPostIdsStreamProvider =
    StreamProvider.family.autoDispose((ref, String uid) {
  print('myPostIdsStreamProvider init');
  ref.onDispose(() => print('myPostIdsStreamProvider dispose'));
  return ref.watch(userStreamRepositoryProvider).myPostIds(uid);
});

final mylikeIdsStreamProvider =
    StreamProvider.family.autoDispose((ref, String uid) {
  print('mylikeIdsStreamProvider init');
  ref.onDispose(() => print('mylikeIdsStreamProvider dispose'));
  return ref.watch(userStreamRepositoryProvider).myLikeIds(uid);
});

final isFavoriteProvider =
    StreamProvider.family.autoDispose((ref, String postId) {
  final _authState = ref.watch(authControllerProvider);
  print('isFavoriteProvider init');
  ref.onDispose(() => print('isFavoriteProvider dispose'));
  return ref
      .watch(userStreamRepositoryProvider)
      .isFavorite(_authState!.uid, postId);
});

// Post
final postRepositoryProvider = Provider.autoDispose<PostRepositoryImpl>((ref) {
  print('postRepositoryProvider init');
  return PostRepositoryImpl(
      firebaseFirestore: ref.read(firebaseFirestoreProvider),
      firebaseStorage: ref.read(firebaseStorageProvider));
});

final postStreamRepositoryProvider =
    Provider.autoDispose<PostStreamRepositoryImpl>((ref) {
  print('postStreamRepositoryProvider init');
  ref.onDispose(() => print('postStreamProvider dispose'));
  return PostStreamRepositoryImpl(ref.read);
});

final postsStreamProvider = StreamProvider.autoDispose((ref) {
  print('postStreamProvider init');
  ref.onDispose(() => print('postStreamProvider dispose'));
  return ref.watch(postStreamRepositoryProvider).fetchPosts();
});

final myPostStreamProvider =
    StreamProvider.family.autoDispose((ref, String id) {
  print('myPostStreamProvider init');
  ref.onDispose(() => print('myPostStreamProvider dispose'));
  return ref.watch(postStreamRepositoryProvider).fetchMyPost(id);
});

// Image
final imageRepositoryProvider =
    Provider.autoDispose<ImageRepositoryImpl>((ref) {
  print('imageRepositoryProvider init');
  ref.onDispose(() => print('imageRepositoryProvider dispose'));
  return ImageRepositoryImpl(
      firebaseStorage: ref.read(firebaseStorageProvider));
});

// like
final likeRepositoryProvider = Provider.autoDispose<LikeRepositoryImpl>((ref) {
  print('likeRepositoryProvider init');
  ref.onDispose(() => print('likeRepositoryProvider dispose'));
  return LikeRepositoryImpl(ref.read);
});
