// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'like_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LikeState {
  bool get isFavorite => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LikeStateCopyWith<LikeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikeStateCopyWith<$Res> {
  factory $LikeStateCopyWith(LikeState value, $Res Function(LikeState) then) =
      _$LikeStateCopyWithImpl<$Res>;
  $Res call({bool isFavorite});
}

/// @nodoc
class _$LikeStateCopyWithImpl<$Res> implements $LikeStateCopyWith<$Res> {
  _$LikeStateCopyWithImpl(this._value, this._then);

  final LikeState _value;
  // ignore: unused_field
  final $Res Function(LikeState) _then;

  @override
  $Res call({
    Object? isFavorite = freezed,
  }) {
    return _then(_value.copyWith(
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_LikeStateCopyWith<$Res> implements $LikeStateCopyWith<$Res> {
  factory _$$_LikeStateCopyWith(
          _$_LikeState value, $Res Function(_$_LikeState) then) =
      __$$_LikeStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isFavorite});
}

/// @nodoc
class __$$_LikeStateCopyWithImpl<$Res> extends _$LikeStateCopyWithImpl<$Res>
    implements _$$_LikeStateCopyWith<$Res> {
  __$$_LikeStateCopyWithImpl(
      _$_LikeState _value, $Res Function(_$_LikeState) _then)
      : super(_value, (v) => _then(v as _$_LikeState));

  @override
  _$_LikeState get _value => super._value as _$_LikeState;

  @override
  $Res call({
    Object? isFavorite = freezed,
  }) {
    return _then(_$_LikeState(
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_LikeState extends _LikeState {
  const _$_LikeState({this.isFavorite = false}) : super._();

  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'LikeState(isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LikeState &&
            const DeepCollectionEquality()
                .equals(other.isFavorite, isFavorite));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(isFavorite));

  @JsonKey(ignore: true)
  @override
  _$$_LikeStateCopyWith<_$_LikeState> get copyWith =>
      __$$_LikeStateCopyWithImpl<_$_LikeState>(this, _$identity);
}

abstract class _LikeState extends LikeState {
  const factory _LikeState({final bool isFavorite}) = _$_LikeState;
  const _LikeState._() : super._();

  @override
  bool get isFavorite;
  @override
  @JsonKey(ignore: true)
  _$$_LikeStateCopyWith<_$_LikeState> get copyWith =>
      throw _privateConstructorUsedError;
}
