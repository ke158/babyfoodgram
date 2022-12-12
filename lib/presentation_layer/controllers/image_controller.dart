import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain_layer/models/state/image_state.dart';
import '../../infrastructure_layer/repositorys/image_repositoryImpl.dart';

class ImageStateController extends StateNotifier<AsyncValue<ImageState>> {
  ImageStateController({required ImageRepositoryImpl imageRepositoryImpl})
      : _imageRepositoryImpl = imageRepositoryImpl,
        super(AsyncValue.loading());

  final ImageRepositoryImpl _imageRepositoryImpl;

  Future<File?> setImage() async {
    state = await AsyncValue.guard(() async {
      final result = await (_imageRepositoryImpl.getImageFromGallery());
      final image = File(result!.path);
      return ImageState(image: image);
    });
    return null;
  }

  Future<void> clearImage() async {
    state = await AsyncValue.guard(() async {
      return ImageState(image: null);
    });
  }
}
