// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyLike _$MyLikeFromJson(Map<String, dynamic> json) {
  return _MyLike.fromJson(json);
}

/// @nodoc
mixin _$MyLike {
  String get postUserId => throw _privateConstructorUsedError;
  String get likesPostId => throw _privateConstructorUsedError;
  @CreatedAtField()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyLikeCopyWith<MyLike> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyLikeCopyWith<$Res> {
  factory $MyLikeCopyWith(MyLike value, $Res Function(MyLike) then) =
      _$MyLikeCopyWithImpl<$Res>;
  $Res call(
      {String postUserId,
      String likesPostId,
      @CreatedAtField() DateTime? createdAt});
}

/// @nodoc
class _$MyLikeCopyWithImpl<$Res> implements $MyLikeCopyWith<$Res> {
  _$MyLikeCopyWithImpl(this._value, this._then);

  final MyLike _value;
  // ignore: unused_field
  final $Res Function(MyLike) _then;

  @override
  $Res call({
    Object? postUserId = freezed,
    Object? likesPostId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      postUserId: postUserId == freezed
          ? _value.postUserId
          : postUserId // ignore: cast_nullable_to_non_nullable
              as String,
      likesPostId: likesPostId == freezed
          ? _value.likesPostId
          : likesPostId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_MyLikeCopyWith<$Res> implements $MyLikeCopyWith<$Res> {
  factory _$$_MyLikeCopyWith(_$_MyLike value, $Res Function(_$_MyLike) then) =
      __$$_MyLikeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String postUserId,
      String likesPostId,
      @CreatedAtField() DateTime? createdAt});
}

/// @nodoc
class __$$_MyLikeCopyWithImpl<$Res> extends _$MyLikeCopyWithImpl<$Res>
    implements _$$_MyLikeCopyWith<$Res> {
  __$$_MyLikeCopyWithImpl(_$_MyLike _value, $Res Function(_$_MyLike) _then)
      : super(_value, (v) => _then(v as _$_MyLike));

  @override
  _$_MyLike get _value => super._value as _$_MyLike;

  @override
  $Res call({
    Object? postUserId = freezed,
    Object? likesPostId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_MyLike(
      postUserId: postUserId == freezed
          ? _value.postUserId
          : postUserId // ignore: cast_nullable_to_non_nullable
              as String,
      likesPostId: likesPostId == freezed
          ? _value.likesPostId
          : likesPostId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyLike extends _MyLike with DiagnosticableTreeMixin {
  const _$_MyLike(
      {required this.postUserId,
      required this.likesPostId,
      @CreatedAtField() this.createdAt})
      : super._();

  factory _$_MyLike.fromJson(Map<String, dynamic> json) =>
      _$$_MyLikeFromJson(json);

  @override
  final String postUserId;
  @override
  final String likesPostId;
  @override
  @CreatedAtField()
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyLike(postUserId: $postUserId, likesPostId: $likesPostId, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyLike'))
      ..add(DiagnosticsProperty('postUserId', postUserId))
      ..add(DiagnosticsProperty('likesPostId', likesPostId))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyLike &&
            const DeepCollectionEquality()
                .equals(other.postUserId, postUserId) &&
            const DeepCollectionEquality()
                .equals(other.likesPostId, likesPostId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(postUserId),
      const DeepCollectionEquality().hash(likesPostId),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_MyLikeCopyWith<_$_MyLike> get copyWith =>
      __$$_MyLikeCopyWithImpl<_$_MyLike>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyLikeToJson(
      this,
    );
  }
}

abstract class _MyLike extends MyLike {
  const factory _MyLike(
      {required final String postUserId,
      required final String likesPostId,
      @CreatedAtField() final DateTime? createdAt}) = _$_MyLike;
  const _MyLike._() : super._();

  factory _MyLike.fromJson(Map<String, dynamic> json) = _$_MyLike.fromJson;

  @override
  String get postUserId;
  @override
  String get likesPostId;
  @override
  @CreatedAtField()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_MyLikeCopyWith<_$_MyLike> get copyWith =>
      throw _privateConstructorUsedError;
}
