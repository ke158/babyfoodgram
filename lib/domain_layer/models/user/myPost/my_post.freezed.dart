// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyPost _$MyPostFromJson(Map<String, dynamic> json) {
  return _MyPost.fromJson(json);
}

/// @nodoc
mixin _$MyPost {
  String get postUserId => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  @CreatedAtField()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyPostCopyWith<MyPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyPostCopyWith<$Res> {
  factory $MyPostCopyWith(MyPost value, $Res Function(MyPost) then) =
      _$MyPostCopyWithImpl<$Res>;
  $Res call(
      {String postUserId,
      String postId,
      @CreatedAtField() DateTime? createdAt});
}

/// @nodoc
class _$MyPostCopyWithImpl<$Res> implements $MyPostCopyWith<$Res> {
  _$MyPostCopyWithImpl(this._value, this._then);

  final MyPost _value;
  // ignore: unused_field
  final $Res Function(MyPost) _then;

  @override
  $Res call({
    Object? postUserId = freezed,
    Object? postId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      postUserId: postUserId == freezed
          ? _value.postUserId
          : postUserId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_MyPostCopyWith<$Res> implements $MyPostCopyWith<$Res> {
  factory _$$_MyPostCopyWith(_$_MyPost value, $Res Function(_$_MyPost) then) =
      __$$_MyPostCopyWithImpl<$Res>;
  @override
  $Res call(
      {String postUserId,
      String postId,
      @CreatedAtField() DateTime? createdAt});
}

/// @nodoc
class __$$_MyPostCopyWithImpl<$Res> extends _$MyPostCopyWithImpl<$Res>
    implements _$$_MyPostCopyWith<$Res> {
  __$$_MyPostCopyWithImpl(_$_MyPost _value, $Res Function(_$_MyPost) _then)
      : super(_value, (v) => _then(v as _$_MyPost));

  @override
  _$_MyPost get _value => super._value as _$_MyPost;

  @override
  $Res call({
    Object? postUserId = freezed,
    Object? postId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_MyPost(
      postUserId: postUserId == freezed
          ? _value.postUserId
          : postUserId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
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
class _$_MyPost extends _MyPost with DiagnosticableTreeMixin {
  const _$_MyPost(
      {required this.postUserId,
      required this.postId,
      @CreatedAtField() this.createdAt})
      : super._();

  factory _$_MyPost.fromJson(Map<String, dynamic> json) =>
      _$$_MyPostFromJson(json);

  @override
  final String postUserId;
  @override
  final String postId;
  @override
  @CreatedAtField()
  final DateTime? createdAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyPost(postUserId: $postUserId, postId: $postId, createdAt: $createdAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyPost'))
      ..add(DiagnosticsProperty('postUserId', postUserId))
      ..add(DiagnosticsProperty('postId', postId))
      ..add(DiagnosticsProperty('createdAt', createdAt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyPost &&
            const DeepCollectionEquality()
                .equals(other.postUserId, postUserId) &&
            const DeepCollectionEquality().equals(other.postId, postId) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(postUserId),
      const DeepCollectionEquality().hash(postId),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_MyPostCopyWith<_$_MyPost> get copyWith =>
      __$$_MyPostCopyWithImpl<_$_MyPost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyPostToJson(
      this,
    );
  }
}

abstract class _MyPost extends MyPost {
  const factory _MyPost(
      {required final String postUserId,
      required final String postId,
      @CreatedAtField() final DateTime? createdAt}) = _$_MyPost;
  const _MyPost._() : super._();

  factory _MyPost.fromJson(Map<String, dynamic> json) = _$_MyPost.fromJson;

  @override
  String get postUserId;
  @override
  String get postId;
  @override
  @CreatedAtField()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_MyPostCopyWith<_$_MyPost> get copyWith =>
      throw _privateConstructorUsedError;
}
