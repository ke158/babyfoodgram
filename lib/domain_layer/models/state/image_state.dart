import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_state.freezed.dart';

@freezed
abstract class ImageState with _$ImageState {
  const ImageState._();
  const factory ImageState({File? image}) = _ImageState;
}
