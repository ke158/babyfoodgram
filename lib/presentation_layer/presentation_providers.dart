import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain_layer/models/post/post.dart';
import '../domain_layer/models/state/image_state.dart';
import '../domain_layer/models/user/user.dart';
import 'controllers/user_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/image_controller.dart';
import 'controllers/post_controller.dart';

final userControllerProvider =
    StateNotifierProvider.autoDispose<UserController, AppUser>((ref) {
  print('userControllerProvider init');
  ref.onDispose(() => print('userControllerProvider dispose'));
  return UserController(ref.read);
});

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, User?>((ref) {
  print('authControllerProvider init');
  ref.onDispose(() => print('authControllerProvider dispose'));
  return AuthController(ref.read);
});
final postControllerProvider =
    StateNotifierProvider.autoDispose<PostController, Post>((ref) {
  print('postControllerProvider init');
  ref.onDispose(() => print('postControllerProvider dispose'));
  return PostController(ref.read);
});

final imageStateControllerProvider =
    StateNotifierProvider.autoDispose<ImageStateController, ImageState>((ref) {
  print('imageStateControllerProvider init');
  ref.onDispose(() => print('imageStateControllerProvider dispose'));
  return ImageStateController(ref.read);
});
