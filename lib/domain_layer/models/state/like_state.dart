import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_state.freezed.dart';

@freezed
abstract class LikeState with _$LikeState {
  const LikeState._();
  const factory LikeState({
    @Default(false) bool isFavorite,
  }) = _LikeState;
}
