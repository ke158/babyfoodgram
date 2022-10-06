import 'dart:io';

import 'package:babyfoodgram/infrastructure_layer/infrastructure_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain_layer/models/state/image_state.dart';

class ImageStateController extends StateNotifier<ImageState> {
  ImageStateController(this._read) : super(ImageState());
  final Reader _read;

  Future<File?> setImage() async {
    final result = await _read(imageRepositoryProvider).getImageFromGallery();
    if (result != null) {
      final image = File(result.path);
      state = state.copyWith(image: image);
      return image;
    }
    return null;
  }

  Future<File?> updateImage() async {
    final result = await _read(imageRepositoryProvider).getImageFromGallery();
    if (result != null) {
      final image = File(result.path);
      state = state.copyWith(image: image);
      return image;
    }
    return null;
  }

  Future<void> clearImage() async {
    if (state.image != null) {
      state = await state.copyWith(image: null);
    }
  }
}
