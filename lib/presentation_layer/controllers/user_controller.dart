import 'dart:async';
import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain_layer/models/user/user.dart';
import '../../infrastructure_layer/infrastructure_providers.dart';

class UserController extends StateNotifier<AppUser> {
  final Reader _read;

  UserController(this._read) : super(AppUser());

  Future<void> fetchAppUser(String uid) async {
    final user = await _read(userRepositoryProvider).fetchUser(uid);
    state = state.copyWith(
        id: user.id,
        userName: user.userName,
        profileImage: user.profileImage,
        userId: user.userId,
        selfIntroduction: user.selfIntroduction,
        createdAt: user.createdAt,
        updatedAt: user.updatedAt);
  }

  Future<void> createAppUser(
      String uid, String userName, String userId, File? image) async {
    if (userName.isNotEmpty && userId.isNotEmpty && image != null) {
      final folderName = "/profile_images/";
      final imagePath = await _read(imageRepositoryProvider)
          .uploadImage(uid, folderName, image);
      final createUser = AppUser(
          id: uid,
          userName: userName,
          userId: userId,
          profileImage: imagePath,
          selfIntroduction: "",
          createdAt: DateTime.now());
      await _read(userRepositoryProvider).createUser(createUser);

      final user = await _read(userRepositoryProvider).fetchUser(uid);
      state = state.copyWith(
          id: user.id,
          userName: user.userName,
          profileImage: user.profileImage,
          userId: user.userId,
          selfIntroduction: user.selfIntroduction,
          createdAt: user.createdAt,
          updatedAt: user.updatedAt);
    } else {
      print("ユーザー名が入力されていません。");
    }
  }

  Future<void> updateAppUser(String uid, String userName, String userId,
      String selfIntroduction, File? image, String? img) async {
    if (uid.isNotEmpty &&
        userName.isNotEmpty &&
        userId.isNotEmpty &&
        selfIntroduction.isNotEmpty) {
      if (image == null) {
        final updateUser = AppUser(
            id: uid,
            userName: userName,
            userId: userId,
            profileImage: img!,
            selfIntroduction: selfIntroduction,
            updatedAt: DateTime.now());
        await _read(userRepositoryProvider).updateUser(updateUser);
        final user = await _read(userRepositoryProvider)
            .fetchUser(updateUser.id.toString());
        state = state.copyWith(
            id: user.id,
            userName: user.userName,
            userId: user.userId,
            profileImage: img,
            selfIntroduction: user.selfIntroduction,
            createdAt: user.createdAt,
            updatedAt: DateTime.now());
      } else {
        final folderName = "/profile_images/";
        await _read(imageRepositoryProvider).deleteUploadImage(uid, folderName);
        final imagePath = await _read(imageRepositoryProvider)
            .uploadImage(uid, folderName, image);
        final updateUser = AppUser(
            id: uid,
            userName: userName,
            userId: userId,
            profileImage: imagePath,
            selfIntroduction: selfIntroduction,
            updatedAt: DateTime.now());
        await _read(userRepositoryProvider).updateUser(updateUser);
        final user = await _read(userRepositoryProvider)
            .fetchUser(updateUser.id.toString());
        state = state.copyWith(
            id: user.id,
            userName: user.userName,
            userId: user.userId,
            profileImage: user.profileImage,
            selfIntroduction: user.selfIntroduction,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt);
      }
    } else {
      print("ユーザー名または自己紹介が入力されていません。");
    }
  }

  Future<void> deleteAppUser(String uid) async {
    final postFileName = "/post_images/";
    final userFileName = "/profile_images/";
    await _read(userRepositoryProvider)
        .deleteUser(uid, postFileName, userFileName);
    await _read(authRepositoryProvider).deleteAuth(uid);
  }
}
